import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/user_entity.dart';

import '../../../domain/entities/check_credential_response_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import '../../base_datasource/auth/check_credential_datasource.dart';
import '../../base_datasource/auth/create_face_id_datasource.dart';
import '../../base_datasource/auth/create_password_datasource.dart';
import '../../base_datasource/auth/login_datasource.dart';
import '../../base_datasource/auth/recover_password_datasource.dart';

class CheckCredentialRepositoryImpl implements ICheckCredentialRepository {
  CheckCredentialRepositoryImpl({required this.datasource});

  ICheckCredentialDatasource datasource;
  @override
  Future<Either<ITneExceptions, CheckCredentialResponseEntity>> call(
    String credential,
  ) async {
    final response = await datasource(credential);
    return response;
  }
}

class RecoverPasswordRepositoryImpl implements IRecoverPasswordRepository {
  RecoverPasswordRepositoryImpl({required this.datasource});

  IRecoverPasswordDatasource datasource;
  @override
  Future<Either<ITneExceptions, String>> call(String credential) async {
    final response = await datasource(credential);
    return response;
  }
}

class LoginRepositoryImpl implements ILoginRepository {
  LoginRepositoryImpl({required this.datasource});

  ILoginDatasource datasource;
  @override
  Future<Either<ITneExceptions, UserEntity>> call(
    String credential,
    String password,
    String? notifyToken,
  ) async {
    final response = await datasource(credential, password, notifyToken);
    return response;
  }
}

class CreatePasswordRepositoryImpl implements ICreatePasswordRepository {
  CreatePasswordRepositoryImpl({required this.datasource});

  ICreatePasswordDatasource datasource;
  @override
  Future<Either<ITneExceptions, bool>> call(
    String password,
    String createPasswordToken,
  ) async {
    final response = await datasource(password, createPasswordToken);
    return response;
  }
}

class CreateFaceIdRepositoryImpl implements ICreateFaceIdRepository {
  CreateFaceIdRepositoryImpl({required this.datasource});

  ICreateFaceIdDatasource datasource;
  @override
  Future<Either<ITneExceptions, bool>> call(String image, String token) async {
    final response = await datasource(image, token);
    return response;
  }
}
