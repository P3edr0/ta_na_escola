import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/presenter/auth/create_password/controller/create_password_controller.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/shared/utils/routes/app_navigator.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../components/dialogs/error_dialog.dart';
import '../../../components/password_attributes.dart';
import '../../../components/step_by_step.dart';
import '../../../components/textfields/textfield.dart';
import '../../../responsiveness/leg_font_style.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/formatters/password_formatter.dart';
import '../../../theme/colors.dart';
import '../credential/controller/controller.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});
  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  final AppNavigator _navigator = AppNavigator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TneBackButton(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: Responsive.getSize(30)),
                    SizedBox(
                      height: Responsive.getSize(50),
                      child: const StepByStep(steps: 3, currentStep: 2),
                    ),
                    SizedBox(height: Responsive.getSize(20)),

                    Consumer<CreatePasswordController>(
                      builder: (context, controller, child) => Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: Responsive.getSize(20)),

                            TnePasswordAttributes(
                              hasCompleted:
                                  controller.currentPasswordRequire > 1,
                              content: 'Conter 6 caracteres',
                            ),
                            TnePasswordAttributes(
                              hasCompleted:
                                  controller.currentPasswordRequire > 2,
                              content: 'Conter apenas números',
                            ),
                            TnePasswordAttributes(
                              hasCompleted:
                                  controller.currentPasswordRequire > 3,
                              content: 'Serem iguais',
                            ),
                            SizedBox(height: Responsive.getSize(20)),
                            TneTextfield(
                              label: 'Senha',

                              controller: controller.passwordController,
                              formatter: [PasswordFormatter.maskFormatter],

                              hint: 'Senha',
                              suffix: InkWell(
                                onTap: controller.setIsObscurePassword,
                                child: controller.isObscurePassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              isObscureText: true,
                              validator: (value) {
                                return controller.validPassword();
                              },
                              onChanged: (value) {
                                controller.validPassword();
                              },
                              inputType: TextInputType.number,
                            ),
                            SizedBox(height: Responsive.getSize(20)),
                            TneTextfield(
                              label: 'Confirmar senha',

                              controller: controller.confirmPasswordController,
                              formatter: [PasswordFormatter.maskFormatter],

                              hint: 'Confirmar senha',
                              suffix: InkWell(
                                onTap: controller.setIsObscureConfirmPassword,
                                child: controller.isObscureConfirmPassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              isObscureText: true,
                              validator: (value) {
                                return controller.validPassword();
                              },
                              onChanged: (value) {
                                controller.validPassword();
                              },
                              inputType: TextInputType.number,
                            ),
                            SizedBox(height: Responsive.getSize(10)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<CreatePasswordController>(
              builder: (context, controller, child) => TneRoundedButton(
                width: 250,
                height: 50,
                child: controller.loading
                    ? TneLoadingButton()
                    : Text(
                        "Confirmar",
                        textAlign: TextAlign.center,
                        style: TneFontStyle.titleBold.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                onTap: () async {
                  final isValid = controller.verifyForm();
                  if (isValid) {
                    if (controller.loading) return;
                    // final isValid = controller.verifyForm();
                    // if (!isValid) return;

                    final credentialController = context
                        .read<CredentialController>();
                    final loginController = context.read<LoginController>();
                    final user = credentialController.user!;
                    await controller.createPassword(
                      createPasswordToken: user.changePasswordToken,
                    );
                    if (controller.hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        if (context.mounted) {
                          await ErrorDialog.show(
                            'Atenção',
                            controller.exception!,
                            context,
                          );
                          return;
                        }
                      });
                      return;
                    }
                    await credentialController.checkCredential();
                    final credential = credentialController.refinedCredential!;
                    final password = controller.password;

                    await loginController.externalLogin(
                      credential: credential,
                      password: password,
                    );

                    if (loginController.hasError) {
                      _navigator.goto(TneRoutes.credential, clearStack: true);
                      return;
                    }
                    if (credentialController
                        .credentialStatus!
                        .isWithoutFaceId) {
                      _navigator.goto(TneRoutes.preFaceCapture);
                      return;
                    }
                    _navigator.goto(TneRoutes.home, clearStack: true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
