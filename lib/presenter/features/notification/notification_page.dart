import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/domain/entities/data_notification_entity.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/notification/store/controller.dart';
import 'package:ta_na_escola/presenter/features/notification/widgets/notification_category_collection.dart';

import '../../../../../components/app_bar/app_bar.dart';
import '../../../../../components/avatar/avatar_border.dart';
import '../../../../../components/loadings/loading.dart';
import '../../../../../responsiveness/responsive.dart';
import '../../../../../shared/utils/app_assets.dart';
import '../../../../../theme/colors.dart';
import '../home/controller/controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final LoginController loginController;
  late final HomeController homeController;
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
      await controller.getNotificationCategories(data: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, child) {
            if (controller.categoryLoading) {
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
                      TneAppBar(title: 'Notificações'),

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

                                NotificationCategoryCollection(
                                  categories: controller.categories,
                                ),
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
                                radius: Responsive.getSize(30),
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
