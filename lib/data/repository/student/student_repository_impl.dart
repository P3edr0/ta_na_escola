import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/data/base_datasource/student/student_datasource.dart';
import 'package:ta_na_escola/domain/entities/data_frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';
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

class GetFrequencyRepositoryImpl implements IGetFrequencyRepository {
  GetFrequencyRepositoryImpl({required this.datasource});

  IGetFrequencyDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  ) async {
    final response = await datasource(data);
    return response;
  }
}

class GetFilteredFrequencyRepositoryImpl
    implements IGetFilteredFrequencyRepository {
  GetFilteredFrequencyRepositoryImpl({required this.datasource});

  IGetFilteredFrequencyDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  ) async {
    final response = await datasource(data);
    return response;
  }
}
