import 'package:dartz/dartz.dart';

import '../../entities/check_credential_response_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/auth/auth_repository.dart';

class CheckCredentialUsecase {
  CheckCredentialUsecase({required this.repository});
  ICheckCredentialRepository repository;
  Future<Either<ITneExceptions, CheckCredentialResponseEntity>> call({
    required String credential,
  }) async {
    if (credential.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }

    return await repository(credential);
  }
}
