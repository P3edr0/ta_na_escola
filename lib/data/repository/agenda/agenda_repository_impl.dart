import 'package:dartz/dartz.dart';

import '../../../domain/entities/calendar_entity.dart';
import '../../../domain/entities/teste_vai_bugar.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/repository/calendar/calendar_repository.dart';
import '../../base_datasource/agenda/agenda_datasource.dart';

class GetAgendaByMonthRepositoryImpl implements IGetCalendarByMonthRepository {
  GetAgendaByMonthRepositoryImpl({required this.datasource});

  IGetAgendaByMonthDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<CalendarEntity>>> call(
    DataAgendaEntity data,
  ) async {
    final response = await datasource(data);
    return response;
  }
}
