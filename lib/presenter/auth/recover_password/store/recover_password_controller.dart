import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/usecases/auth/recover_password_usecase.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

class RecoverPasswordController extends ChangeNotifier {
  RecoverPasswordController({required this.recoverPasswordUsecase});
  String birthDate = '';
  String? exception;
  String recoveryEmail = '';
  String credential = '';
  bool loading = false;

  final RecoverPasswordUsecase recoverPasswordUsecase;
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  bool get hasError => exception != null;

  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      loading = newLoading;
      notifyListeners();
      return;
    }
    loading = !loading;
    notifyListeners();
  }

  void setBirthDate(String newBirthDate) {
    birthDate = newBirthDate;
    notifyListeners();
  }

  void setCredential(String newCredential) {
    credential = newCredential;
    notifyListeners();
  }

  Future<void> recoverPassword() async {
    setLoading();

    final response = await recoverPasswordUsecase(credential: credential);
    response.fold(
      (newException) {
        exception = newException.message;

        setLoading();
      },
      (newEmail) {
        exception = null;
        recoveryEmail = newEmail;
        setLoading();
      },
    );
  }

  bool checkBirthDay() {
    final splitBirthDay = birthDate.split('-');
    if (splitBirthDay.length != 3) return false;

    final comparativeDay = dayController.text;
    final comparativeMonth = monthController.text;
    final comparativeYear = yearController.text;
    final comparativeDate =
        '$comparativeYear-$comparativeMonth-$comparativeDay';
    final handledBirthDay = TneDateFormat.birthDayFormatter(
      birthDate,
      '-',
      true,
    );
    final handledComparativeDate = TneDateFormat.birthDayFormatter(
      comparativeDate,
      '-',
      true,
    );
    if (handledComparativeDate == null || handledBirthDay == null) return false;
    return handledBirthDay.isAtSameMomentAs(handledComparativeDate);
  }
}
