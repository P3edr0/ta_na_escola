import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/user_entity.dart';
import 'package:ta_na_escola/domain/usecases/auth/login_usecase.dart';

import '../../../../domain/entities/session_entity.dart';
import '../../../../domain/usecases/session/create_session_usecase.dart';
import '../../../../shared/utils/validators/password_validator.dart';

class LoginController extends ChangeNotifier {
  LoginController({
    required this.loginUsecase,
    required this.createSessionUseCase,
  });
  final LoginUsecase loginUsecase;
  final CreateSessionUseCase createSessionUseCase;

  String? exception;
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  bool loading = false;
  int currentPasswordRequire = 0;
  UserEntity? user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  /////////////////// GET

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

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;
    return true;
  }

  Future<void> login({
    required String credential,
    required String notifyToken,
  }) async {
    setLoading();
    final password = passwordController.text;

    final response = await loginUsecase(
      credential: credential,
      password: password,
      notifyToken: notifyToken,
    );
    response.fold(
      (newException) {
        exception = newException.message;
        setLoading();
      },
      (newUser) {
        user = newUser;
        unawaited(
          createSession(
            credential: credential,
            password: password,
            image: newUser.image,
          ),
        );
        exception = null;
        setLoading();
      },
    );
  }

  Future<UserEntity?> externalLogin({
    required String credential,
    required String password,
    required String notifyToken,
  }) async {
    setLoading();

    final response = await loginUsecase(
      credential: credential,
      password: password,
      notifyToken: notifyToken,
    );
    response.fold(
      (newException) {
        exception = newException.message;
        setLoading();
        return null;
      },
      (newUser) {
        user = newUser;
        unawaited(
          createSession(
            credential: credential,
            password: password,
            image: newUser.image,
          ),
        );
        exception = null;
        setLoading();
        return newUser;
      },
    );
    return null;
  }

  Future<void> createSession({
    required String password,
    required String credential,
    required String? image,
  }) async {
    final session = SessionEntity(
      credential: credential,
      image: image,
      password: password,
    );

    final response = await createSessionUseCase(session);
    response.fold(
      (newException) {
        log('Falha ao criar sessão: ${newException.message}');
      },
      (success) {
        log('Sessão criada com sucesso');
      },
    );
  }
}
