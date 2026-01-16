import 'package:dartz/dartz.dart';

import '../../entities/data_notification_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/notification/notification_repository.dart';

class UpdateNotificationStatusUsecase {
  UpdateNotificationStatusUsecase({required this.repository});
  IUpdateNotificationStatusRepository repository;
  Future<Either<ITneExceptions, bool>> call({
    required DataNotificationEntity data,
  }) async {
    if (data.fcmId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.studentId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.token.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }

    return await repository(data);
  }
}
