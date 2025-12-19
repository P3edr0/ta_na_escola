import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/auth/create_password_datasource.dart';

class CreatePasswordDatasourceImpl implements ICreatePasswordDatasource {
  @override
  Future<Either<ITneExceptions, bool>> call(
    String password,
    String createPasswordToken,
  ) async {
    final dio = Dio();
    final bytes = utf8.encode(password);
    final digest = md5.convert(bytes);
    final encryptedPassword = digest.toString();
    final query = json.encode({"senha": encryptedPassword});
    try {
      final response = await dio.put(
        '${TneEnvironment.apiUrl}autenticacao/alterar-senha',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Content-Type": "application/json-patch+json",
            "Authorization": "Bearer $createPasswordToken",
          },
        ),
        data: query,
      );
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(message: 'Falha ao fazer a login'));
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

            handledException = exceptionList.first['message'];
          }
        } catch (e) {
          handledException = 'Falha ao cadastrar senha';
        }
        return Left(WithoutAccountException(message: handledException));
      }
      log('Exception:${e.toString()}');
      return Left(
        BadRequestJackException(
          message: 'Falha ao cadastrar senha. Por favor tente mais tarde',
        ),
      );
    }
  }
}
