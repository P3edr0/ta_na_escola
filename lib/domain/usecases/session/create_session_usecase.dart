import 'package:dartz/dartz.dart';

import '../../entities/session_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/session/session_repository.dart';

class CreateSessionUseCase {
  final ICreateSessionRepository repository;

  CreateSessionUseCase({required this.repository});

  Future<Either<ITneExceptions, bool>> call(SessionEntity session) async {
    if (session.image == null || session.credential.trim().isEmpty) {
      return Left(DataException(message: 'A imagem não pode ser vazio'));
    }
    if (session.credential.trim().isEmpty) {
      return Left(DataException(message: 'A credencial não pode ser vazio'));
    }
    if (session.password.trim().isEmpty) {
      return Left(DataException(message: 'A senha não pode ser vazia'));
    }

    return repository(session);
  }
}
