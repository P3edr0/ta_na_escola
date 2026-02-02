import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/calendar_entity.dart';
import 'package:ta_na_escola/domain/entities/teste_vai_bugar.dart';

import '../../exceptions/auth_exceptions.dart';

abstract class IGetCalendarByMonthRepository {
  Future<Either<ITneExceptions, List<CalendarEntity>>> call(
    DataAgendaEntity data,
  );
}
