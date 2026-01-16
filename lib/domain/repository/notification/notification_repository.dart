import 'package:dartz/dartz.dart';

import '../../entities/data_notification_entity.dart';
import '../../entities/notification_category_entity.dart';
import '../../entities/notification_entity.dart';
import '../../exceptions/auth_exceptions.dart';

abstract class IGetNotificationsByCategoryRepository {
  Future<Either<ITneExceptions, List<NotificationEntity>>> call(
    DataNotificationEntity data,
  );
}

abstract class IGetNotificationCategoriesRepository {
  Future<Either<ITneExceptions, List<NotificationCategoryEntity>>> call(
    DataNotificationEntity data,
  );
}

abstract class IUpdateNotificationStatusRepository {
  Future<Either<ITneExceptions, bool>> call(DataNotificationEntity data);
}
