import '../formatters/regx.dart';

class PasswordValidator {
  Map<int, String>? call(String password, String? confirmPassword) {
    {
      final handledPassword = password.trim();
      if (handledPassword.length < 6) {
        return {1: 'A senha precisa ter exatamente 6 caracteres'};
      }
      if (!TneRegex.onlyNumbers.hasMatch(handledPassword)) {
        return {2: 'A senha precisa conter apenas números'};
      }

      if (confirmPassword == null) return null;
      final isSamePassword = password == confirmPassword;

      if (!isSamePassword) {
        return {3: 'As senhas precisam ser iguais'};
      }

      return null;
    }
  }
}
