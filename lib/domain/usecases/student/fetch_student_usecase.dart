import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../repository/student/student_repository.dart';

class FetchStudentUsecase {
  FetchStudentUsecase({required this.repository});
  IFetchStudentRepository repository;
  Future<Either<ITneExceptions, List<StudentEntity>>> call({
    required String token,
  }) async {
    if (token.trim().isEmpty) {
      return Left(DataException(message: 'Token inválido.'));
    }

    return await repository(token);
  }
}
