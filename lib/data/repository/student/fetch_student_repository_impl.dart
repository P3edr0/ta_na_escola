import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/data/base_datasource/student/fetch_student_datasource.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/repository/student/student_repository.dart';

class FetchStudentRepositoryImpl implements IFetchStudentRepository {
  FetchStudentRepositoryImpl({required this.datasource});

  IFetchStudentDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token) async {
    final response = await datasource(token);
    return response;
  }
}
