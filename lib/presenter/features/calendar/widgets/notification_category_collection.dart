import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/presenter/features/notification/store/controller.dart';

import '../../../../components/cards/notification_card.dart';
import '../../../../domain/entities/notification_category_entity.dart';

class NotificationCategoryCollection extends StatefulWidget {
  const NotificationCategoryCollection({super.key, required this.categories});
  final List<NotificationCategoryEntity> categories;

  @override
  State<NotificationCategoryCollection> createState() =>
      _NotificationCategoryCollectionState();
}

class _NotificationCategoryCollectionState
    extends State<NotificationCategoryCollection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, controller, child) {
        return Column(
          children: widget.categories.map((notificationCategory) {
            return TneNotificationCard(
              image: notificationCategory.category.getImage(),
              title: notificationCategory.category.getTitle(),
              notificationQtd: notificationCategory.notificationQtd,
              onTap: () {
                controller.setSelectedCategory(notificationCategory);
                if (notificationCategory.onTap != null) {
                  notificationCategory.onTap!();
                }
              },
            );
          }).toList(),
        );
      },
    );
  }
}
