import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/data/base_datasource/services/get_version.dart';
import 'package:ta_na_escola/data/mapper/version_mapper.dart';
import 'package:ta_na_escola/domain/entities/version_entity.dart';

import '../../../../../domain/exceptions/auth_exceptions.dart';
import '../../../shared/framework/jack_environment.dart';

class GetVersionDatasourceImpl implements IGetVersionDatasource {
  @override
  Future<Either<ITneExceptions, VersionEntity>> call() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}versoes',
        options: Options(
          headers: {
            "accept": "text/plain",
            "x-app-api-key": " ${TneEnvironment.apiKey}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final version = VersionMapper.fromJson(response.data);
        return Right(version);
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
