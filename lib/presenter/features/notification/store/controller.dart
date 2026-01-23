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
  int? _notificationRequestPage = 1;
  ScrollController scrollController = ScrollController();
  bool categoryLoading = false;
  bool notificationsDetailsLoading = false;
  bool moreNotificationsDetailsLoading = false;
  String? exception;
  ////////////// GET

  bool get hasError => exception != null;

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

  startNotificationsDetailsPage() {
    notifications.clear();
    setNotificationRequestPage(1);
  }

  void setCategoryDetailsLoading([bool? newCategoryDetailLoading]) {
    if (newCategoryDetailLoading != null) {
      notificationsDetailsLoading = newCategoryDetailLoading;
      notifyListeners();
      return;
    }
    notificationsDetailsLoading = !notificationsDetailsLoading;
    notifyListeners();
  }

  void setMoreNotificationsDetailsLoading([
    bool? newMoreNotificationsDetailsLoading,
  ]) {
    if (newMoreNotificationsDetailsLoading != null) {
      moreNotificationsDetailsLoading = newMoreNotificationsDetailsLoading;
      notifyListeners();
      return;
    }
    moreNotificationsDetailsLoading = !moreNotificationsDetailsLoading;
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
      page: _notificationRequestPage,
    );
    final response = await getNotificationsByCategoryUsecase(data: handledData);
    response.fold(
      (newException) {
        exception = 'Falha ao buscar notificações';
        log(newException.message, name: 'NOTIFICATION ERROR');
        setCategoryDetailsLoading();
      },
      (newNotifications) {
        exception = null;
        if (newNotifications.isEmpty || newNotifications.length < 20) {
          setNotificationRequestPage(null);
        }
        notifications = [...notifications, ...newNotifications];
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

  Future<void> getMoreNotificationsByCategory({
    required DataNotificationEntity data,
  }) async {
    setNotificationRequestPage((_notificationRequestPage! + 1));

    setMoreNotificationsDetailsLoading();
    final handledData = data.copyWith(
      category: selectedNotificationCategory!.id,
      page: _notificationRequestPage,
    );
    final response = await getNotificationsByCategoryUsecase(data: handledData);
    response.fold(
      (newException) {
        log(newException.message, name: 'MORE NOTIFICATION ERROR');
        setMoreNotificationsDetailsLoading();
      },
      (newNotifications) {
        if (newNotifications.isEmpty ||
            _notificationRequestPage! > 1 && newNotifications.length < 20) {
          setNotificationRequestPage(null);
          setMoreNotificationsDetailsLoading();
          return;
        }
        notifications = [...notifications, ...newNotifications];
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

        setMoreNotificationsDetailsLoading();
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
        exception = 'Falha ao buscar notificações';
        log(newException.message, name: 'NOTIFICATION CATEGORY ERROR');
        setCategoryLoading();
      },
      (newCategories) {
        categories = [...newCategories];
        for (int index = 0; index < categories.length; index++) {
          categories[index] = categories[index].copyWith(
            onTap: () {
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

  setNotificationRequestPage(int? newNotificationRequestPage) {
    _notificationRequestPage = newNotificationRequestPage;
  }

  bool hasMoreNotifications() {
    if (selectedNotificationCategory!.category.isFrequency) return false;

    if (_notificationRequestPage == null) return false;

    return true;
  }
}
