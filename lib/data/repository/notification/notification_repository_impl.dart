import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';

import '../../../domain/entities/data_notification_entity.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/repository/notification/notification_repository.dart';
import '../../base_datasource/notification/notification_datasource.dart';

class GetNotificationsByCategoryRepositoryImpl
    implements IGetNotificationsByCategoryRepository {
  GetNotificationsByCategoryRepositoryImpl({required this.datasource});

  IGetNotificationsByCategoryDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<NotificationEntity>>> call(
    DataNotificationEntity data,
  ) async {
    final response = await datasource(data);
    return response;
  }
}

class GetNotificationCategoriesRepositoryImpl
    implements IGetNotificationCategoriesRepository {
  GetNotificationCategoriesRepositoryImpl({required this.datasource});

  IGetNotificationCategoriesDatasource datasource;
  @override
  Future<Either<ITneExceptions, List<NotificationCategoryEntity>>> call(
    DataNotificationEntity data,
  ) async {
    final response = await datasource(data);
    return response;
  }
}

class UpdateNotificationStatusRepositoryImpl
    implements IUpdateNotificationStatusRepository {
  UpdateNotificationStatusRepositoryImpl({required this.datasource});

  IUpdateNotificationStatusDatasource datasource;
  @override
  Future<Either<ITneExceptions, bool>> call(DataNotificationEntity data) async {
    final response = await datasource(data);
    return response;
  }
}
