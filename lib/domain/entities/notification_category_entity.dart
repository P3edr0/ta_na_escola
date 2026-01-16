import '../../shared/utils/enums/notification_category.dart';

class NotificationCategoryEntity {
  NotificationCategoryEntity({
    required this.notificationQtd,
    required this.category,
    required this.id,
    this.onTap,
  });
  NotificationCategory category;
  int notificationQtd;
  String id;
  void Function()? onTap;

  NotificationCategoryEntity copyWith({
    String? id,
    int? notificationQtd,
    void Function()? onTap,
    NotificationCategory? category,
  }) {
    return NotificationCategoryEntity(
      notificationQtd: notificationQtd ?? this.notificationQtd,
      onTap: onTap ?? this.onTap,
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }
}
