import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';
import 'package:ta_na_escola/domain/entities/notification_entity.dart';

import '../../../domain/entities/data_notification_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IGetNotificationsByCategoryDatasource {
  Future<Either<ITneExceptions, List<NotificationEntity>>> call(
    DataNotificationEntity data,
  );
}

abstract class IGetNotificationCategoriesDatasource {
  Future<Either<ITneExceptions, List<NotificationCategoryEntity>>> call(
    DataNotificationEntity data,
  );
}

abstract class IUpdateNotificationStatusDatasource {
  Future<Either<ITneExceptions, bool>> call(DataNotificationEntity data);
}
