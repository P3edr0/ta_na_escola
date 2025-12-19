import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IFetchStudentDatasource {
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token);
}
