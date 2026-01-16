import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/cards/notification_card.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/notification/store/controller.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

import '../../../../../components/app_bar/app_bar.dart';
import '../../../../../components/avatar/avatar_border.dart';
import '../../../../../components/loadings/loading.dart';
import '../../../../../responsiveness/responsive.dart';
import '../../../../../shared/utils/app_assets.dart';
import '../../../../../theme/colors.dart';
import '../../../components/dialogs/notification_dialog.dart';
import '../../../domain/entities/data_notification_entity.dart';
import '../home/controller/controller.dart';

class NotificationDetailsPage extends StatefulWidget {
  const NotificationDetailsPage({super.key});

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  late final LoginController loginController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginController = context.read<LoginController>();
      final homeController = context.read<HomeController>();
      final controller = context.read<NotificationController>();
      final user = loginController.user!;
      final student = homeController.selectedStudent!;
      final data = DataNotificationEntity(
        studentId: student.guardianId,
        fcmId: 'firebase_token',
        token: user.token,
      );
      await controller.getNotificationsByCategory(data: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, child) {
            if (controller.categoryDetailsLoading) {
              return TnePageLoading();
            }
            final HomeController homeController = context
                .read<HomeController>();

            final student = homeController.selectedStudent;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,

                        color: secondaryColor,
                        child: Image.asset(
                          TneAppAssets.backgroundOverall,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TneAppBar(
                        title:
                            'Notificações - ${controller.selectedNotificationCategory!.category.getTitle()}',
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: Responsive.getSize(96),
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: Responsive.getSize(28),
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Responsive.getSize(50)),

                                ...controller.notifications.map((notification) {
                                  final date = notification.sendAt != null
                                      ? TneDateFormat.notificationFormat(
                                          notification.sendAt!,
                                        )
                                      : '--:--';
                                  return TneNotificationCard.details(
                                    image: notification.category!.category
                                        .getImage(),
                                    title: notification.category!.category
                                        .getTitle(),

                                    date: date,
                                    read: notification.readAt != null,
                                    content: notification.content,
                                    onTap: () async {
                                      NotificationDialog.show(
                                        image: notification.category!.category
                                            .getImage(),
                                        title: notification.category!.category
                                            .getTitle(),
                                        content: notification.content!,
                                        context: context,
                                      );
                                      if (notification.readAt == null) {
                                        final loginController = context
                                            .read<LoginController>();
                                        final homeController = context
                                            .read<HomeController>();
                                        final user = loginController.user!;
                                        final student =
                                            homeController.selectedStudent!;
                                        final data = DataNotificationEntity(
                                          studentId: student.guardianId,
                                          fcmId: notification.fcmId ?? '',
                                          notificationTargetId: notification
                                              .notificationTargetId!,
                                          token: user.token,
                                        );

                                        await controller.setReadNotification(
                                          data: data,
                                        );
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: Responsive.getSize(590),
                        left: 0,
                        right: 0,
                        top: Responsive.getSize(-20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),

                            Expanded(
                              child: TneAvatarBorder(
                                image: NetworkImage(student!.image ?? ''),
                                radius: 30,
                                hasBottomPadding: true,
                                color: accentColor,
                              ),
                            ),

                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
