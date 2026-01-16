import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/data/mapper/frequency_mapper.dart';
import 'package:ta_na_escola/domain/entities/data_frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../shared/framework/jack_environment.dart';
import '../../base_datasource/student/student_datasource.dart';

class GetFrequencyDatasourceImpl implements IGetFrequencyDatasource {
  @override
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  ) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}alunos/entrada-saida/aluno/${data.studentId}/escola/${data.schoolId}?pagina=${data.pages.first}',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${data.token}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final listData = List<Map<String, dynamic>>.from(response.data['data']);
        final frequencies = listData
            .map((frequency) => FrequencyMapper.fromMap(frequency))
            .toList();
        return Right(frequencies);
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
