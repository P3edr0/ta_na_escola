import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/auth/recover_password_datasource.dart';

class RecoverPasswordDatasourceImpl implements IRecoverPasswordDatasource {
  @override
  Future<Either<ITneExceptions, String>> call(String credential) async {
    final dio = Dio();
    final query = json.encode({"cpfEmail": credential});
    try {
      final response = await dio.post(
        '${TneEnvironment.apiUrl}autenticacao/recuperar-senha',
        data: query,
        options: Options(
          headers: {
            "accept": "text/plain",
            "x-app-api-key": " ${TneEnvironment.apiKey}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final contentRecovery = data['email'];

        return Right(contentRecovery);
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
