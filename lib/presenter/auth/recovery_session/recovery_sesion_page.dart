import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/avatar/avatar_border.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/presenter/core/store/core_controller.dart';
import 'package:ta_na_escola/presenter/home/home_page.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../components/loadings/loading_button.dart';
import '../../../responsiveness/responsive.dart';
import '../../../theme/colors.dart';
import '../credential/controller/controller.dart';
import 'widgets/keyboard.dart';
import 'widgets/password_icon.dart';

class RecoverySessionPage extends StatefulWidget {
  const RecoverySessionPage({super.key});
  @override
  RecoverySessionPageState createState() => RecoverySessionPageState();
}

class RecoverySessionPageState extends State<RecoverySessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,

                    color: secondaryColor,
                    child: Image.asset(
                      TneAppAssets.background,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: Responsive.getSize(0),
                    left: 0,
                    right: 0,
                    child: Consumer<CredentialController>(
                      builder: (context, controller, child) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Consumer<CoreController>(
                            builder: (context, controller, child) => Column(
                              children: [
                                SizedBox(height: Responsive.getSize(75)),
                                PasswordIcon(
                                  passwordLength: controller
                                      .recovererPasswordContent
                                      .length,
                                ),
                                SizedBox(
                                  height: Responsive.getSize(300),
                                  child: Keyboard(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer<CoreController>(
                    builder: (context, controller, child) {
                      final session = controller.currentSession!;
                      return Positioned(
                        bottom: Responsive.getSize(340),
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            const Spacer(),
                            controller.isLoading
                                ? CircleAvatar(
                                    backgroundColor: primaryFocusColor,
                                    radius: Responsive.getSize(50),
                                    child: const LoadingButton(
                                      color: secondaryColor,
                                    ),
                                  )
                                : Expanded(
                                    child: TneAvatarBorder(
                                      radius: 50,
                                      image: NetworkImage(session.image!),
                                    ),
                                  ),
                            const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
                  TneBackButton(
                    onTap: () async {
                      final controller = context.read<CoreController>();
                      unawaited(controller.deleteSession());
                      navigator.goto(TneRoutes.credential, replace: true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
