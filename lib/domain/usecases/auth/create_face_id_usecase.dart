import 'package:dartz/dartz.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../repository/auth/auth_repository.dart';

class CreateFaceIdUsecase {
  CreateFaceIdUsecase({required this.repository});
  ICreateFaceIdRepository repository;
  Future<Either<ITneExceptions, bool>> call({
    required String image,
    required String token,
  }) async {
    if (image.trim().isEmpty) {
      return Left(DataException(message: 'Imagem inválida.'));
    }
    if (token.trim().isEmpty) {
      return Left(DataException(message: 'Token inválido .'));
    }

    return await repository(image, token);
  }
}
