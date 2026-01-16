import 'package:ta_na_escola/shared/utils/enums/notification_category.dart';

import '../../domain/entities/notification_category_entity.dart';

class NotificationCategoryMapper {
  static NotificationCategoryEntity fromMap(Map<String, dynamic> data) {
    String id;
    NotificationCategory category;
    int notificationQtd;

    id = data["id"];
    category = NotificationCategory.translate(data["nome"].toString());
    notificationQtd = data["quantidadeNotificacao"];
    return NotificationCategoryEntity(
      id: id,
      category: category,
      notificationQtd: notificationQtd,
      onTap: null,
    );
  }
}
