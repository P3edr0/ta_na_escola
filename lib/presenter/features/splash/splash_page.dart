import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/services/version/app_version_service.dart';
import 'package:ta_na_escola/shared/utils/enums/check_credential_response.dart';
import 'package:ta_na_escola/shared/utils/routes/app_navigator.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../../../shared/utils/app_assets.dart';
import '../../../responsiveness/responsive.dart';
import '../../core/store/core_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final CoreController controller;
  late final AppVersionService versionService;
  final navigator = AppNavigator();

  @override
  void initState() {
    super.initState();
    controller = context.read<CoreController>();
    versionService = context.read<AppVersionService>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await versionService.getLatestVersion();
      switch (versionService.hasNewVersion) {
        case null:
          log('Falha ao buscar versão');

          navigator.goto(TneRoutes.blockApp, clearStack: true);
          return;
        case true:
          navigator.goto(TneRoutes.updateApp, clearStack: true);
          log('Versão depreciada do app');
          return;
        default:
          log('Versão Atualizada');
      }
      await controller.getSession();
      final size = MediaQuery.of(context).size;
      Responsive.defineSize(size, pixelRatio: size.aspectRatio);
      Future.delayed(const Duration(seconds: 2), () async {
        redirect();
      });
    });
  }

  redirect() async {
    switch (controller.sessionCredentialStatus) {
      case CheckCredentialStatus.completeAccount:
        navigator.goto(TneRoutes.recoverSession, clearStack: true);

      default:
        navigator.goto(TneRoutes.credential, clearStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: Opacity(
            opacity: 0.9,
            child: Stack(
              children: [
                Image.asset(
                  colorBlendMode: BlendMode.hardLight,
                  TneAppAssets.background,
                  fit: BoxFit.cover,
                  height: size.height,
                ),
                Center(child: TneLoadingButton(size: 70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
