import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/calendar_entity.dart';

import '../../../domain/entities/teste_vai_bugar.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IGetAgendaByMonthDatasource {
  Future<Either<ITneExceptions, List<CalendarEntity>>> call(
    DataAgendaEntity data,
  );
}
