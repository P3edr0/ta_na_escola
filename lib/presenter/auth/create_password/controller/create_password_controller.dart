import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/usecases/auth/create_password_usecase.dart';

import '../../../../shared/utils/validators/password_validator.dart';

class CreatePasswordController extends ChangeNotifier {
  CreatePasswordController({required this.createPasswordUsecase});
  final CreatePasswordUsecase createPasswordUsecase;
  String? exception;
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  bool loading = false;
  int currentPasswordRequire = 0;
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /////////////////// GET

  bool get hasError => exception != null;
  String get password => _password;

  void setIsObscurePassword() {
    isObscurePassword = !isObscurePassword;
    notifyListeners();
  }

  void setIsObscureConfirmPassword() {
    isObscureConfirmPassword = !isObscureConfirmPassword;
    notifyListeners();
  }

  String? validPassword() {
    final String content = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    final validator = PasswordValidator();
    final response = validator(
      content.toLowerCase(),
      confirmPassword.toLowerCase(),
    );
    if (response == null) {
      currentPasswordRequire = 4;
      notifyListeners();
      return null;
    } else {
      currentPasswordRequire = response.keys.first;
      notifyListeners();
      return response.values.first;
    }
  }

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;
    return true;
  }

  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      loading = newLoading;
      notifyListeners();
      return;
    }
    loading = !loading;
    notifyListeners();
  }

  Future<void> createPassword({required String createPasswordToken}) async {
    setLoading();
    final newPassword = passwordController.text;

    final response = await createPasswordUsecase(
      password: newPassword,
      createPasswordToken: createPasswordToken,
    );
    response.fold(
      (newException) {
        exception = newException.message;

        setLoading();
      },
      (success) {
        if (success) {
          exception = null;
          _password = newPassword;
          setLoading();

          return;
        }
      },
    );
  }
}
