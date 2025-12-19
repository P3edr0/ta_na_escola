import 'package:dartz/dartz.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../repository/auth/auth_repository.dart';

class RecoverPasswordUsecase {
  RecoverPasswordUsecase({required this.repository});
  IRecoverPasswordRepository repository;
  Future<Either<ITneExceptions, String>> call({
    required String credential,
  }) async {
    if (credential.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }

    return await repository(credential);
  }
}
