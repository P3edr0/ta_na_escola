import 'package:dartz/dartz.dart';

import '../../entities/user_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/auth/auth_repository.dart';

class LoginUsecase {
  LoginUsecase({required this.repository});
  ILoginRepository repository;
  Future<Either<ITneExceptions, UserEntity>> call({
    required String credential,
    required String password,
    String? notifyToken,
  }) async {
    if (credential.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }
    if (password.trim().isEmpty) {
      return Left(DataException(message: 'Senha inválida.'));
    }

    return await repository(credential, password, notifyToken);
  }
}
