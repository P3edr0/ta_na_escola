import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/shared/framework/jack_environment.dart';

import '../../../domain/exceptions/auth_exceptions.dart';
import '../../base_datasource/auth/create_face_id_datasource.dart';

class CreateFaceIdDatasourceImpl implements ICreateFaceIdDatasource {
  @override
  Future<Either<ITneExceptions, bool>> call(String image, String token) async {
    final dio = Dio();

    final query = json.encode({"imagemBase64": image});
    try {
      final response = await dio.put(
        '${TneEnvironment.apiUrl}autenticacao/alterar-foto',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Content-Type": "application/json-patch+json",
            "Authorization": "Bearer $token",
          },
        ),
        data: query,
      );
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(
          BadRequestJackException(message: 'Falha ao atualizar imagem'),
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

            handledException = exceptionList.first['message'];
          }
        } catch (e) {
          handledException = 'Falha ao atualizar imagem';
        }
        return Left(WithoutAccountException(message: handledException));
      }
      log('Exception:${e.toString()}');
      return Left(
        BadRequestJackException(
          message: 'Falha ao cadastrar imagem. Por favor tente mais tarde',
        ),
      );
    }
  }
}
