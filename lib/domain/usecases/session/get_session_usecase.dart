import 'package:dartz/dartz.dart';

import '../../entities/session_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/session/session_repository.dart';

class GetSessionUseCase {
  final IGetSessionRepository repository;

  GetSessionUseCase({required this.repository});

  Future<Either<ITneExceptions, SessionEntity?>> call() async {
    return repository();
  }
}
