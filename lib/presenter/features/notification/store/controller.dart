import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/data_notification_entity.dart';
import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';
import 'package:ta_na_escola/domain/entities/notification_entity.dart';
import 'package:ta_na_escola/domain/usecases/notification/get_notifications_by_category_usecase.dart';

import '../../../../domain/usecases/notification/get_notification_categories_usecase.dart';
import '../../../../domain/usecases/notification/update_notification_status_usecase .dart';
import '../../../../shared/utils/routes/app_navigator.dart';
import '../../../../shared/utils/routes/app_routes.dart';

class NotificationController extends ChangeNotifier {
  NotificationController({
    required this.getNotificationsByCategoryUsecase,
    required this.getNotificationCategoriesUsecase,
    required this.updateNotificationStatusUsecase,
  });
  final GetNotificationsByCategoryUsecase getNotificationsByCategoryUsecase;
  final GetNotificationCategoriesUsecase getNotificationCategoriesUsecase;
  final UpdateNotificationStatusUsecase updateNotificationStatusUsecase;
  NotificationCategoryEntity? selectedNotificationCategory;
  List<NotificationEntity> notifications = [];
  List<NotificationCategoryEntity> categories = [];

  bool categoryLoading = false;
  bool categoryDetailsLoading = false;
  ////////////// GET

  ////////////// FUNCTIONS

  void setCategoryLoading([bool? newCategoryLoading]) {
    if (newCategoryLoading != null) {
      categoryLoading = newCategoryLoading;
      notifyListeners();
      return;
    }
    categoryLoading = !categoryLoading;
    notifyListeners();
  }

  void setCategoryDetailsLoading([bool? newCategoryDetailLoading]) {
    if (newCategoryDetailLoading != null) {
      categoryDetailsLoading = newCategoryDetailLoading;
      notifyListeners();
      return;
    }
    categoryDetailsLoading = !categoryDetailsLoading;
    notifyListeners();
  }

  void setSelectedCategory(NotificationCategoryEntity newNotificationCategory) {
    selectedNotificationCategory = newNotificationCategory;

    notifyListeners();
  }

  Future<void> getNotificationsByCategory({
    required DataNotificationEntity data,
  }) async {
    setCategoryDetailsLoading();
    final handledData = data.copyWith(
      category: selectedNotificationCategory!.id,
    );
    final response = await getNotificationsByCategoryUsecase(data: handledData);
    response.fold(
      (newException) {
        setCategoryDetailsLoading();
      },
      (newNotifications) {
        notifications = [...newNotifications];
        for (int index = 0; index < notifications.length; index++) {
          notifications[index] = notifications[index].copyWith(
            category: selectedNotificationCategory,
          );
        }
        notifications.sort((a, b) {
          if (a.readAt != null && b.readAt != null) {
            return a.readAt!.compareTo(b.readAt!);
          } else {
            return 1;
          }
        });

        setCategoryDetailsLoading();
      },
    );
  }

  Future<void> getNotificationCategories({
    required DataNotificationEntity data,
  }) async {
    setCategoryLoading();

    final response = await getNotificationCategoriesUsecase(data: data);
    response.fold(
      (newException) {
        setCategoryLoading();
      },
      (newCategories) {
        categories = [...newCategories];
        for (int index = 0; index < categories.length; index++) {
          categories[index] = categories[index].copyWith(
            onTap: () {
              if (categories[index].notificationQtd < 1) return;
              final AppNavigator navigator = AppNavigator();
              navigator.goto(TneRoutes.notificationDetails);
            },
          );
        }
        setCategoryLoading();
      },
    );
  }

  Future<void> setReadNotification({
    required DataNotificationEntity data,
  }) async {
    final response = await updateNotificationStatusUsecase(data: data);
    response.fold(
      (newException) {
        log('Erro ao ler notificação:${newException.message}');
      },
      (success) {
        if (success) {
          for (int index = 0; index < notifications.length; index++) {
            if (notifications[index].notificationTargetId ==
                data.notificationTargetId) {
              log('Notificação lida');
              notifications[index] = notifications[index].copyWith(
                readAt: DateTime.now(),
              );
            }
          }
          notifyListeners();
        }
      },
    );
  }
}
