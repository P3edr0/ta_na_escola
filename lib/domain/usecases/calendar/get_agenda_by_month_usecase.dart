import 'package:dartz/dartz.dart';

import '../../entities/calendar_entity.dart';
import '../../entities/teste_vai_bugar.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/calendar/calendar_repository.dart';

class GetAgendaByMonthUsecase {
  GetAgendaByMonthUsecase({required this.repository});
  IGetCalendarByMonthRepository repository;
  Future<Either<ITneExceptions, List<CalendarEntity>>> call({
    required DataAgendaEntity data,
  }) async {
    if (data.schoolId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.studentId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.token.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }

    if (data.month == null || data.month! < 1) {
      return Left(DataException(message: 'Dados inválido.'));
    }

    return await repository(data);
  }
}
