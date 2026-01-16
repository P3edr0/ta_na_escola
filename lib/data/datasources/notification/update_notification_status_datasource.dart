import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/data_notification_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../shared/framework/jack_environment.dart';
import '../../base_datasource/notification/notification_datasource.dart';

class UpdateNotificationStatusDatasourceImpl
    implements IUpdateNotificationStatusDatasource {
  @override
  Future<Either<ITneExceptions, bool>> call(DataNotificationEntity data) async {
    final dio = Dio();
    final query = {
      "idNotificacaoDestinatario": data.notificationTargetId,
      "idFcm": data.fcmId,
    };

    final handledQuery = json.encode(query);
    try {
      final response = await dio.put(
        data: handledQuery,
        '${TneEnvironment.apiUrl}notificacoes/marcar-como-lido',
        options: Options(
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json-patch+json",
            "Authorization": "Bearer ${data.token}",
          },
        ),
      );

      if (response.statusCode == 204) {
        return Right(true);
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
