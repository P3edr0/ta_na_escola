import 'package:dartz/dartz.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../repository/session/session_repository.dart';

class DeleteSessionUseCase {
  final IDeleteSessionRepository repository;

  DeleteSessionUseCase({required this.repository});

  Future<Either<ITneExceptions, bool>> call() async {
    return repository();
  }
}
