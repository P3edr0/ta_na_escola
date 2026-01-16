import '../../domain/entities/notification_entity.dart';

class NotificationMapper {
  static NotificationEntity fromMap(Map<String, dynamic> data) {
    String? title;
    String? content;
    String? notificationId;
    String? notificationTargetId;
    String? fcmId;
    DateTime? sendTime;
    DateTime? readTime;
    try {
      final sendAtField = data["enviadoEm"];
      final readAtField = data["lidoEm"];
      if (sendAtField != null) {
        sendTime = DateTime.tryParse(sendAtField.toString());
      }
      if (readAtField != null) {
        readTime = DateTime.tryParse(readAtField.toString());
      }
    } catch (e) {
      sendTime = null;
      readTime = null;
    }
    title = data["tituloFinal"];
    content = data["corpoFinal"];
    notificationId = data["idNotificacao"];
    notificationTargetId = data["idNotificacaoDestinatario"];
    fcmId = data["fcmId"];
    return NotificationEntity(
      title: title,
      content: content,
      notificationId: notificationId,
      notificationTargetId: notificationTargetId,
      fcmId: fcmId,
      sendAt: sendTime,
      readAt: readTime,
    );
  }
}
