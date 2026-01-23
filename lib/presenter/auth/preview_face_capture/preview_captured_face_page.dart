import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/dialogs/info_dialog.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/presenter/auth/face_detector/store/face_capture_controller.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/auth/preview_face_capture/controller/preview_capturered_face_controller.dart';

import '../../../components/dialogs/error_dialog.dart';
import '../../../components/loadings/loading_button.dart';
import '../../../components/step_by_step.dart';
import '../../../responsiveness/leg_font_style.dart';
import '../../../responsiveness/responsive.dart';
import '../../../services/notification_service.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import '../../../shared/utils/routes/app_routes.dart';
import '../../../theme/colors.dart';

class PreviewCapturedFacePage extends StatefulWidget {
  final String title;
  const PreviewCapturedFacePage({
    super.key,
    this.title = 'PreviewFaceCapturePage',
  });
  @override
  PreviewCapturedFacePageState createState() => PreviewCapturedFacePageState();
}

class PreviewCapturedFacePageState extends State<PreviewCapturedFacePage> {
  final AppNavigator _navigator = AppNavigator();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    // Future.delayed(const Duration(seconds: 0)).then((_) async {
    //   //store.foto = await store.verificafoto();
    //   setState(() {});
    super.initState();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TneBackButton(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.getSize(24)),

              child: Column(
                children: [
                  SizedBox(height: Responsive.getSize(20)),

                  Text(
                    "Veja como ficou sua foto",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.h4Bold.copyWith(
                      color: black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: Responsive.getSize(20)),
                  SizedBox(
                    height: Responsive.getSize(50),
                    child: const StepByStep(steps: 3, currentStep: 3),
                  ),
                  Consumer<FaceCaptureController>(
                    builder: (context, controller, child) => Container(
                      margin: EdgeInsets.only(top: Responsive.getSize(20)),
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 82,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(controller.file!),
                          // backgroundColor: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.getSize(20)),
                  TneRoundedButton(
                    width: Responsive.getSize(200),
                    onTap: () {
                      _navigator.goto(TneRoutes.faceCapture, replace: true);

                      final controller = context.read<FaceCaptureController>();
                      controller.clearFile();
                    },
                    child: Text(
                      "Alterar foto",
                      textAlign: TextAlign.center,
                      style: TneFontStyle.titleBold.copyWith(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.getSize(40)),
                  Text(
                    "Pronto",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.h4Bold.copyWith(color: black),
                  ),
                  Text(
                    'Sua face foi cadastrada com sucesso. Agora você está pronto(a) para começar a usar o Tá na Escola!',
                    textAlign: TextAlign.start,
                    style: TneFontStyle.body.copyWith(color: grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: Responsive.getSize(30),
          top: Responsive.getSize(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PreviewCapturedFaceController>(
              builder: (context, controller, child) => TneRoundedButton(
                width: Responsive.getSize(250),
                child: controller.loading
                    ? const TneLoadingButton(color: secondaryColor)
                    : Text(
                        "Finalizar",
                        textAlign: TextAlign.center,
                        style: TneFontStyle.titleBold.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                onTap: () async {
                  if (controller.loading) return;
                  final faceCaptureController = context
                      .read<FaceCaptureController>();
                  final loginController = context.read<LoginController>();
                  final credentialController = context
                      .read<CredentialController>();
                  final image = faceCaptureController.base64Image ?? '';
                  final token = loginController.user!.token;
                  await controller.createFaceId(image: image, token: token);
                  if (controller.hasError && context.mounted) {
                    await ErrorDialog.show(
                      'Atenção',
                      controller.exception!,
                      context,
                    );
                    return;
                  }
                  final notifyService = FirebaseNotificationService();
                  final notifyToken = await notifyService.getToken();
                  await loginController.login(
                    credential: credentialController.refinedCredential!,
                    notifyToken: notifyToken!,
                  );
                  if (context.mounted) {
                    await InfoDialog.closeAuto(
                      'Sucesso',
                      'Sua imagem foi cadastrada com sucesso',
                      context,
                    );
                  }
                  _navigator.goto(TneRoutes.home, clearStack: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
