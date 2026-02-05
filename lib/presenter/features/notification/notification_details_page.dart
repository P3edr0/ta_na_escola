import 'dart:developer' as dev;
import 'dart:math';

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
import '../../../components/dialogs/error_dialog.dart';
import '../../../components/dialogs/notification_dialog.dart';
import '../../../components/loadings/loading_button.dart';
import '../../../domain/entities/data_notification_entity.dart';
import '../../../responsiveness/leg_font_style.dart';
import '../home/controller/controller.dart';

class NotificationDetailsPage extends StatefulWidget {
  const NotificationDetailsPage({super.key});

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  late final LoginController loginController;
  late final NotificationController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loginController = context.read<LoginController>();
      final homeController = context.read<HomeController>();
      controller = context.read<NotificationController>();
      controller.startNotificationsDetailsPage();
      final user = loginController.user!;
      final student = homeController.selectedStudent!;
      final data = DataNotificationEntity(
        studentId: student.guardianId,
        fcmId: 'firebase_token',
        token: user.token,
      );

      await controller.getNotificationsByCategory(data: data);

      if (controller.hasError) {
        if (context.mounted) {
          await ErrorDialog.show('Atenção', controller.exception!, context);
          return;
        }

        return;
      }

      controller.scrollController.addListener(() async {
        if (_shouldLoadMore()) {
          await controller.getMoreNotificationsByCategory(data: data);
        }
      });
    });
  }

  bool _shouldLoadMore() {
    if (controller.moreNotificationsDetailsLoading ||
        !controller.hasMoreNotifications()) {
      return false;
    }
    final maxScroll = controller.scrollController.position.maxScrollExtent;
    final currentScroll = controller.scrollController.position.pixels;

    return currentScroll >= (maxScroll - Responsive.getSize(50));
  }

  @override
  void dispose() {
    super.dispose();
    controller.scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, child) {
            if (controller.notificationsDetailsLoading) {
              return TnePageLoading();
            }

            final bool isFrequency =
                controller.selectedNotificationCategory!.category.isFrequency;

            final int notifyLength = isFrequency
                ? min(10, controller.notifications.length)
                : controller.notifications.length;
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
                        top: Responsive.getSize(130),
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

                          child: controller.notifications.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: Responsive.getSize(32)),
                                      Image.asset(
                                        TneAppAssets.notify,
                                        fit: BoxFit.cover,
                                        height: Responsive.getSize(60),
                                      ),
                                      SizedBox(height: Responsive.getSize(10)),
                                      Text(
                                        'Você não possui notificações.',
                                        style: TneFontStyle.bodySec.copyWith(
                                          color: grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: Responsive.getSize(32)),
                                    ],
                                  ),
                                )
                              :
                                //////////////
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: notifyLength,
                                  controller: controller.scrollController,
                                  itemBuilder: (context, index) {
                                    dev.log(index.toString());

                                    final notification =
                                        controller.notifications[index];
                                    final date = notification.sendAt != null
                                        ? TneDateFormat.notificationFormat(
                                            notification.sendAt!,
                                          )
                                        : '--:--';
                                    final isFirst = index == 0;
                                    final isLast = index == notifyLength - 1;
                                    if (controller
                                            .moreNotificationsDetailsLoading &&
                                        isLast) {
                                      return Center(
                                        child: TneLoadingButton(
                                          color: primaryColor,
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: isFirst ? 50 : 0.0,
                                      ),
                                      child: TneNotificationCard.details(
                                        image: notification.category!.category
                                            .getImage(),
                                        title: notification.category!.category
                                            .getTitle(),

                                        date: date,
                                        read: notification.readAt != null,
                                        isFrequency: isFrequency,
                                        content: notification.content,
                                        onTap: () async {
                                          String handledTitle = '';

                                          if (isFrequency) {
                                            if (notification.content!.contains(
                                              'saiu',
                                            )) {
                                              handledTitle = 'Saída';
                                            } else {
                                              handledTitle = 'Entrada';
                                            }
                                          } else {
                                            handledTitle = notification
                                                .category!
                                                .category
                                                .getTitle();
                                          }
                                          NotificationDialog.show(
                                            image: notification
                                                .category!
                                                .category
                                                .getImage(),
                                            title: handledTitle,
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

                                            await controller
                                                .setReadNotification(
                                                  data: data,
                                                );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),

                          // SingleChildScrollView(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       SizedBox(height: Responsive.getSize(50)),

                          //       ...List<Widget>.generate(notifyLength, (index) {
                          //         log(index.toString());
                          //         if (index == 20) {
                          //           controller.hasMoreNotifications();
                          //         }
                          //         final notification =
                          //             controller.notifications[index];
                          //         final date = notification.sendAt != null
                          //             ? TneDateFormat.notificationFormat(
                          //                 notification.sendAt!,
                          //               )
                          //             : '--:--';
                          //         return TneNotificationCard.details(
                          //           image: notification.category!.category
                          //               .getImage(),
                          //           title: notification.category!.category
                          //               .getTitle(),

                          //           date: date,
                          //           read: notification.readAt != null,
                          //           isFrequency: isFrequency,
                          //           content: notification.content,
                          //           onTap: () async {
                          //             String handledTitle = '';

                          //             if (isFrequency) {
                          //               if (notification.content!.contains(
                          //                 'saiu',
                          //               )) {
                          //                 handledTitle = 'Saída';
                          //               } else {
                          //                 handledTitle = 'Entrada';
                          //               }
                          //             } else {
                          //               handledTitle = notification
                          //                   .category!
                          //                   .category
                          //                   .getTitle();
                          //             }
                          //             NotificationDialog.show(
                          //               image: notification.category!.category
                          //                   .getImage(),
                          //               title: handledTitle,
                          //               content: notification.content!,
                          //               context: context,
                          //             );
                          //             if (notification.readAt == null) {
                          //               final loginController = context
                          //                   .read<LoginController>();
                          //               final homeController = context
                          //                   .read<HomeController>();
                          //               final user = loginController.user!;
                          //               final student =
                          //                   homeController.selectedStudent!;
                          //               final data = DataNotificationEntity(
                          //                 studentId: student.guardianId,
                          //                 fcmId: notification.fcmId ?? '',
                          //                 notificationTargetId: notification
                          //                     .notificationTargetId!,
                          //                 token: user.token,
                          //               );

                          //               await controller.setReadNotification(
                          //                 data: data,
                          //               );
                          //             }
                          //           },
                          //         );
                          //       }),

                          //       if (!controller.moreNotificationsDetailsLoading)
                          //         Center(
                          //           child: TneLoadingButton(
                          //             color: primaryColor,
                          //           ),
                          //         ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        right: 0,
                        top: Responsive.getSize(100),
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
