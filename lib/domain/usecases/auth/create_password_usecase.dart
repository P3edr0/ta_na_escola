import 'package:dartz/dartz.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../repository/auth/auth_repository.dart';

class CreatePasswordUsecase {
  CreatePasswordUsecase({required this.repository});
  ICreatePasswordRepository repository;
  Future<Either<ITneExceptions, bool>> call({
    required String password,
    required String createPasswordToken,
  }) async {
    if (password.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }
    if (createPasswordToken.trim().isEmpty) {
      return Left(DataException(message: 'Erro ao cadastrar senha.'));
    }
    return await repository(password, createPasswordToken);
  }
}
