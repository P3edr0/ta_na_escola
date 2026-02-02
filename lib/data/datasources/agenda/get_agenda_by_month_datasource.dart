import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/calendar_entity.dart';
import '../../../domain/entities/teste_vai_bugar.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../shared/framework/jack_environment.dart';
import '../../base_datasource/agenda/agenda_datasource.dart';
import '../../mapper/agenda_mapper.dart';

class GetAgendaByMonthDatasourceImpl implements IGetAgendaByMonthDatasource {
  @override
  Future<Either<ITneExceptions, List<CalendarEntity>>> call(
    DataAgendaEntity data,
  ) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '${TneEnvironment.apiUrl}calendarios/mes/${data.month}/escola/${data.schoolId}/aluno/${data.studentId}',
        options: Options(
          headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${data.token}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final handledData = Map<String, dynamic>.from({
          ...response.data,
          'month': data.month,
        });

        final agendas = AgendaMapper.fromMap(handledData);
        return Right(agendas);
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
