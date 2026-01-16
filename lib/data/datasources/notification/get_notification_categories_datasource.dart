import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';

import '../../../domain/entities/data_notification_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../shared/framework/jack_environment.dart';
import '../../base_datasource/notification/notification_datasource.dart';
import '../../mapper/notification_category_mapper.dart';

class GetNotificationCategoriesDatasourceImpl
    implements IGetNotificationCategoriesDatasource {
  @override
  Future<Either<ITneExceptions, List<NotificationCategoryEntity>>> call(
    DataNotificationEntity data,
  ) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}notificacoes/categorias/${data.studentId}',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${data.token}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final listData = List<Map<String, dynamic>>.from(response.data);
        final categories = listData
            .map((category) => NotificationCategoryMapper.fromMap(category))
            .toList();
        return Right(categories);
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
