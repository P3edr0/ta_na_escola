import 'package:flutter/material.dart';

import '../../../../shared/utils/validators/password_validator.dart';

class CreatePasswordController extends ChangeNotifier {
  String? exception;
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  bool loading = false;
  int currentPasswordRequire = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /////////////////// GET

  bool get hasError => exception != null;

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
    final validator = PasswordValidator();
    final response = validator(
      content.toLowerCase(),
      'Pedro Camargo'.toLowerCase(),
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

  String? validConfirmPassword() {
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    if (password == confirmPassword) return null;

    return "As senhas precisam ser iguais";
  }

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;
    return true;
  }
}
