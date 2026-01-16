import 'dart:core';

class DataNotificationEntity {
  final String studentId;
  final String fcmId;
  final String token;
  final String? notificationTargetId;
  final String? category;

  DataNotificationEntity({
    required this.studentId,
    required this.fcmId,
    required this.token,
    this.notificationTargetId,

    this.category,
  });

  DataNotificationEntity copyWith({
    String? studentId,
    String? fcmId,
    String? token,
    String? notificationTargetId,
    String? category,
  }) {
    return DataNotificationEntity(
      studentId: studentId ?? this.studentId,
      fcmId: fcmId ?? this.fcmId,
      token: token ?? this.token,
      category: category ?? this.category,
      notificationTargetId: notificationTargetId ?? this.notificationTargetId,
    );
  }
}
