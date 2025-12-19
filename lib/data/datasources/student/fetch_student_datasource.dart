import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/data/mapper/student_mapper.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/student/fetch_student_datasource.dart';

class FetchStudentDatasourceImpl implements IFetchStudentDatasource {
  @override
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}alunos',
        options: Options(
          headers: {"accept": "text/plain", "Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        final listData = List<Map<String, dynamic>>.from(response.data);
        final students = listData
            .map((data) => StudentMapper.fromMap(data))
            .toList();
        return Right(students);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'),
        );
      }
    } catch (e) {
      final exception = e as DioException;
      if (exception.type == DioExceptionType.badResponse) {
        late String handledException;
        try {
          final exceptionData = exception.response?.data?["notifications"];
          if (exceptionData != null) {
            final exceptionList = List<Map<String, dynamic>>.from(
              exceptionData,
            );

            handledException = exceptionList.first['key'];
          }
        } catch (e) {
          handledException = 'Falha ao fazer a autenticação';
        }
        return Left(WithoutAccountException(message: handledException));
      }
      log('Exception:${e.toString()}');
      return Left(
        BadRequestJackException(message: 'Falha ao fazer a autenticação'),
      );
    }
  }
}
