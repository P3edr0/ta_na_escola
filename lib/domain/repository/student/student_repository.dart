import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../exceptions/auth_exceptions.dart';

abstract class IFetchStudentRepository {
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token);
}
