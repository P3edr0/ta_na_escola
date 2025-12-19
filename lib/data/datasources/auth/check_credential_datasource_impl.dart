import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/entities/check_credential_response_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/auth/check_credential_datasource.dart';
import '../../mapper/credential_response_mapper.dart';

class CheckCredentialDatasourceImpl implements ICheckCredentialDatasource {
  @override
  Future<Either<ITneExceptions, CheckCredentialResponseEntity>> call(
    String credential,
  ) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}autenticacao/$credential',
        options: Options(
          headers: {
            "accept": "text/plain",
            "x-app-api-key": " ${TneEnvironment.apiKey}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final user = CredentialResponseMapper.fromJson(response.data);
        return Right(user);
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
