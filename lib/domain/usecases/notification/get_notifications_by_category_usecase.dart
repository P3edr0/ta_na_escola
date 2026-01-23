import 'package:dartz/dartz.dart';

import '../../entities/data_notification_entity.dart';
import '../../entities/notification_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/notification/notification_repository.dart';

class GetNotificationsByCategoryUsecase {
  GetNotificationsByCategoryUsecase({required this.repository});
  IGetNotificationsByCategoryRepository repository;
  Future<Either<ITneExceptions, List<NotificationEntity>>> call({
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
    if (data.category == null || data.category!.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.page == null || data.page! < 1) {
      return Left(DataException(message: 'Dados inválido.'));
    }

    return await repository(data);
  }
}
