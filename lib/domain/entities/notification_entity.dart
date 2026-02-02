import 'package:ta_na_escola/domain/entities/notification_category_entity.dart';

class NotificationEntity {
  final NotificationCategoryEntity? category;
  final DateTime? sendAt;
  final DateTime? readAt;
  final String? title;
  final String? image;
  final String? htmlContent;
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
    required this.image,
    required this.htmlContent,
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
    String? image,
    String? htmlContent,
  }) {
    return NotificationEntity(
      category: category ?? this.category,
      sendAt: sendAt ?? this.sendAt,
      readAt: readAt ?? this.readAt,
      title: title ?? this.title,
      content: content ?? this.content,
      notificationId: notificationId ?? this.notificationId,
      notificationTargetId: notificationTargetId ?? this.notificationTargetId,
      htmlContent: htmlContent ?? this.htmlContent,
      image: image ?? this.image,
      fcmId: fcmId ?? this.fcmId,
    );
  }
}
