import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/data/mapper/user_mapper.dart';
import 'package:ta_na_escola/domain/entities/user_entity.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/auth/login_datasource.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  @override
  Future<Either<ITneExceptions, UserEntity>> call(
    String credential,
    String password,
    String? notifyToken,
  ) async {
    final dio = Dio();
    final bytes = utf8.encode(password);
    final digest = md5.convert(bytes);
    final encryptedPassword = digest.toString();
    final query = json.encode({
      "emailCpf": credential,
      "senha": encryptedPassword,
      "tokenFcm": notifyToken ?? '',
    });
    try {
      final response = await dio.post(
        '${TneEnvironment.apiUrl}autenticacao',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Content-Type": "application/json-patch+json",
            "x-app-api-key": " ${TneEnvironment.apiKey}",
          },
        ),
        data: query,
      );

      if (response.statusCode == 200) {
        final user = UserMapper.fromJson(response.data);
        return Right(user);
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
          handledException = 'Falha ao fazer a autenticação';
        }
        return Left(WithoutAccountException(message: handledException));
      }
      log('Exception:${e.toString()}');
      return Left(
        BadRequestJackException(
          message: 'Falha ao fazer o login. Por favor tente mais tarde',
        ),
      );
    }
  }
}
