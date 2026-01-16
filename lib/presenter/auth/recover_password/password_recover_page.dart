import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/dialogs/info_dialog.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/components/textfields/textfield.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/store/recover_password_controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/routes/app_navigator.dart';

import '../../../components/buttons/back_button.dart';
import '../../../components/datepickers/date_input.dart';
import '../../../components/step_by_step.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_routes.dart';
import '../../../theme/colors.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({super.key});
  @override
  PasswordRecoverPageState createState() => PasswordRecoverPageState();
}

class PasswordRecoverPageState extends State<PasswordRecoverPage> {
  late final RecoverPasswordController controller;
  late final CredentialController credentialController;
  @override
  void initState() {
    super.initState();

    controller = context.read<RecoverPasswordController>();
    credentialController = context.read<CredentialController>();

    final userBirthDay = credentialController.user!.birthDay;
    final credential = credentialController.refinedCredential!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBirthDate(userBirthDay);
      controller.setCredential(credential);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: Responsive.getSize(60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TneBackButton(),
                  Text(
                    "Recuperar senha",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold,
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
            SizedBox(height: Responsive.getSize(50)),
            SizedBox(
              height: Responsive.getSize(50),
              child: const StepByStep(steps: 2, currentStep: 1),
            ),
            SizedBox(height: Responsive.getSize(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Primeiro precisamos confirmar alguns dados:",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.title.copyWith(color: grey),
                  ),
                  SizedBox(height: Responsive.getSize(20)),
                  Consumer<CredentialController>(
                    builder: (context, credentialController, child) =>
                        TneTextfield(
                          enable: false,
                          controller: TextEditingController(
                            text: credentialController
                                .credentialTextController
                                .text,
                          ),
                          hint: '',
                        ),
                  ),
                  SizedBox(height: Responsive.getSize(20)),
                  Text(
                    "Data de nascimento",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.title.copyWith(color: grey),
                  ),
                  SizedBox(height: Responsive.getSize(10)),
                  Consumer<RecoverPasswordController>(
                    builder: (context, controller, child) => TneDateInput(
                      dayController: controller.dayController,
                      monthController: controller.monthController,
                      yearController: controller.yearController,
                    ),
                  ),
                  SizedBox(height: Responsive.getSize(40)),
                  InkWell(
                    onTap: () async {
                      final navigator = AppNavigator();
                      navigator.goto(TneRoutes.passwordRecoverHelp);
                    },
                    child: Text(
                      "PRECISO DE AJUDA",
                      textAlign: TextAlign.center,
                      style: TneFontStyle.bodyLargeBold.copyWith(
                        fontWeight: FontWeight.w900,
                        color: grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TneRoundedButton(
              width: 250,
              height: 50,
              child: controller.loading
                  ? TneLoadingButton()
                  : Text(
                      "Avançar",
                      textAlign: TextAlign.center,
                      style: TneFontStyle.titleBold.copyWith(
                        color: secondaryColor,
                      ),
                    ),
              onTap: () async {
                final checkResponse = controller.checkBirthDay();

                if (!checkResponse) {
                  await InfoDialog.closeAuto(
                    'Falha',
                    'Data de nascimento incorreta',
                    context,
                  );
                  return;
                }
                await controller.recoverPassword();

                if (controller.hasError) {
                  await InfoDialog.closeAuto(
                    'Falha',
                    controller.exception!,
                    context,
                  );
                  return;
                }

                final navigator = AppNavigator();
                navigator.goto(TneRoutes.passwordRecoverEmail, replace: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
