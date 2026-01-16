import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';

class NotificationEntity {
  final NotificationCategoryEntity? category;
  final DateTime? sendAt;
  final DateTime? readAt;
  final String? title;
  final String? content;
  final String? notificationId;
  final String? notificationTargetId;
  final String? fcmId;
  NotificationEntity({
    this.category,
    this.sendAt,
    this.readAt,
    required this.title,
    required this.content,
    this.notificationId,
    this.notificationTargetId,
    this.fcmId,
  });

  NotificationEntity copyWith({
    NotificationCategoryEntity? category,
    DateTime? sendAt,
    DateTime? readAt,
    String? title,
    String? content,
    String? notificationId,
    String? notificationTargetId,
    String? fcmId,
  }) {
    return NotificationEntity(
      category: category ?? this.category,
      sendAt: sendAt ?? this.sendAt,
      readAt: readAt ?? this.readAt,
      title: title ?? this.title,
      content: content ?? this.content,
      notificationId: notificationId ?? this.notificationId,
      notificationTargetId: notificationTargetId ?? this.notificationTargetId,
      fcmId: fcmId ?? this.fcmId,
    );
  }
}
