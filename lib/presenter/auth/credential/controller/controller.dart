import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/check_credential_response_entity.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';
import 'package:ta_na_escola/domain/usecases/auth/check_credential_usecase.dart';
import 'package:ta_na_escola/shared/utils/enums/check_credential_response.dart';
import 'package:ta_na_escola/shared/utils/enums/credential_type.dart';

import '../../../../shared/utils/formatters/cpf_formatter.dart';
import '../../../../shared/utils/formatters/regx.dart';
import '../../../../shared/utils/validators/credential_validator.dart';

class CredentialController extends ChangeNotifier {
  CredentialController({required this.checkCredentialUsecase});
  final CheckCredentialUsecase checkCredentialUsecase;
  final TextEditingController credentialTextController =
      TextEditingController();
  String? exception;
  CredentialType currentCredentialType = CredentialType.document;
  CheckCredentialResponseEntity? user;
  CheckCredentialStatus? credentialStatus;
  final GlobalKey<FormState> _credentialKey = GlobalKey<FormState>();
  bool loading = false;
  String? refinedCredential;
  ////////////// GET

  GlobalKey<FormState> get credentialKey => _credentialKey;
  bool get hasError => exception != null;

  ////////////// FUNCTIONS

  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      loading = newLoading;
      notifyListeners();
      return;
    }
    loading = !loading;
    notifyListeners();
  }

  String? validCredential() {
    final String content = credentialTextController.text;
    final validator = CredentialValidator();
    final response = validator(currentCredentialType.isEmail, content);
    return response;
  }

  Future<void> changeCredentialMask() async {
    final validator = CpfFormatter.maskFormatter.getUnmaskedText();
    if (TneRegex.onlyNumbers.hasMatch((validator))) {
      if (currentCredentialType.isDocument) return;
      credentialTextController.value = CpfFormatter.maskFormatter.updateMask(
        mask: "###.###.###-##",
      );
      currentCredentialType = CredentialType.document;
      notifyListeners();
    } else {
      if (currentCredentialType.isEmail) return;

      credentialTextController.value = CpfFormatter.maskFormatter.updateMask(
        mask: "",
      );
      currentCredentialType = CredentialType.email;
      notifyListeners();
    }
  }

  Future<void> checkCredential() async {
    setLoading();
    late final String handledCredential;
    final credential = credentialTextController.text;
    if (currentCredentialType.isDocument) {
      handledCredential = credential.replaceAll(RegExp(r'\D'), '');
    } else {
      handledCredential = credential;
    }
    refinedCredential = handledCredential;
    final response = await checkCredentialUsecase(
      credential: handledCredential,
    );
    response.fold(
      (newException) {
        if (newException.runtimeType == WithoutAccountException) {
          credentialStatus = CheckCredentialStatus.withoutAccount;
          exception = null;
        } else {
          credentialStatus = null;
          exception = newException.message;
        }
        setLoading();
      },
      (newUser) {
        user = newUser;

        if (!newUser.hasPassword) {
          credentialStatus = CheckCredentialStatus.withoutPassword;
          setLoading();

          return;
        }
        if (!newUser.hasFaceId) {
          credentialStatus = CheckCredentialStatus.withoutFaceId;
          setLoading();

          return;
        }
        credentialStatus = CheckCredentialStatus.completeAccount;
        setLoading();
      },
    );
  }

  Future<CheckCredentialStatus?> checkCredentialExternal(
    String externalCredential,
  ) async {
    final response = await checkCredentialUsecase(
      credential: externalCredential,
    );
    return response.fold(
      (newException) {
        if (newException.runtimeType == WithoutAccountException) {
          return CheckCredentialStatus.withoutAccount;
        } else {
          return null;
        }
      },
      (newUser) {
        user = newUser;

        if (!newUser.hasPassword) {
          return CheckCredentialStatus.withoutPassword;
        }
        if (!newUser.hasFaceId) {
          return CheckCredentialStatus.withoutFaceId;
        }
        return CheckCredentialStatus.completeAccount;
      },
    );
  }
}
