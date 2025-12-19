import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/shared/utils/enums/check_credential_response.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/session/delete_session_usecase.dart';
import '../../../domain/usecases/session/get_session_usecase.dart';

class CoreController extends ChangeNotifier {
  CoreController({
    required this.getSessionUseCase,
    required this.deleteSessionUseCase,
    required this.loginController,
    required this.credentialController,
  });

  ////////////////// VARS /////////////////////////

  final GetSessionUseCase getSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final LoginController loginController;
  final CredentialController credentialController;
  String recovererPasswordContent = '';
  CheckCredentialStatus? _sessionCredentialStatus;
  UserEntity? user;

  SessionEntity? _currentSession;

  ////////////////// GETS /////////////////////////

  bool get haveSession => _currentSession != null;
  SessionEntity? get currentSession => _currentSession;
  CheckCredentialStatus? get sessionCredentialStatus =>
      _sessionCredentialStatus;

  ////////////////// FUNCTIONS /////////////////////////

  Future<SessionEntity?> getSession() async {
    final response = await getSessionUseCase();
    return response.fold(
      (l) {
        log(l.message);
        return null;
      },
      (data) async {
        if (data?.image == null) return null;
        _currentSession = data;
        if (data == null) return data;
        _sessionCredentialStatus = await checkCredentialSession(
          _currentSession,
        );
        return data;
      },
    );
  }

  Future<void> deleteSession() async {
    final response = await deleteSessionUseCase();
    return response.fold(
      (l) {
        log(l.message);
        return;
      },
      (data) {
        if (data) {
          _currentSession = null;
        }
      },
    );
  }

  Future<String?> loginSession() async {
    if (recovererPasswordContent != currentSession!.password) {
      return 'Senha inválida';
    }

    setLoading();
    await Future.delayed(Durations.extralong4);
    await externalLogin(currentSession!.credential, recovererPasswordContent);
    setLoading();
    return null;
  }

  Future<CheckCredentialStatus?> checkCredentialSession(
    SessionEntity? session,
  ) async {
    final status = await credentialController.checkCredentialExternal(
      currentSession!.credential,
    );
    return status;
  }

  Future<void> externalLogin(String credential, String password) async {
    final newUser = await loginController.externalLogin(
      credential: credential,
      password: password,
    );
    user = newUser;

    notifyListeners();
  }

  ////////////////// SETS /////////////////////////
  int? setRecoverPassword(String letter, [isBackspace = false]) {
    if (isBackspace) {
      final size = recovererPasswordContent.length;
      if (size == 0) return null;
      recovererPasswordContent = recovererPasswordContent.substring(
        0,
        size - 1,
      );
      notifyListeners();
      return null;
    }
    if (recovererPasswordContent.length == 6) return null;
    recovererPasswordContent += letter;
    notifyListeners();
    return recovererPasswordContent.length;
  }

  void clearRecovererPasswordContent() {
    recovererPasswordContent = '';
  }

  ////////////////////////// TEMP RECOVER PASSWORD ////////////////////
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
