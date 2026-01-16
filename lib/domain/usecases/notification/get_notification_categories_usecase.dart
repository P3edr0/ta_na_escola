import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';

import '../../entities/data_notification_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/notification/notification_repository.dart';

class GetNotificationCategoriesUsecase {
  GetNotificationCategoriesUsecase({required this.repository});
  IGetNotificationCategoriesRepository repository;
  Future<Either<ITneExceptions, List<NotificationCategoryEntity>>> call({
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
