import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/dialogs/error_dialog.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/services/notification_service.dart';
import 'package:ta_na_escola/shared/utils/formatters/password_formatter.dart';
import 'package:ta_na_escola/shared/utils/routes/app_navigator.dart';

import '../../../components/textfields/textfield.dart';
import '../../../responsiveness/leg_font_style.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_routes.dart';
import '../../../theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final AppNavigator _navigator = AppNavigator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            TneBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: Responsive.getSize(30)),
                    Text('Senha do Aplicativo', style: TneFontStyle.h3Sec),
                    SizedBox(height: Responsive.getSize(20)),
                    Text(
                      'Digite a senha que você criou anteriormente',
                      style: TneFontStyle.bodyLargeSec,
                    ),
                    SizedBox(height: Responsive.getSize(30)),

                    Consumer<LoginController>(
                      builder: (context, controller, child) {
                        return Form(
                          key: controller.formKey,
                          child: TneTextfield(
                            label: 'Senha',

                            controller: controller.passwordController,
                            hint: 'Senha',

                            formatter: [PasswordFormatter.maskFormatter],
                            inputType: TextInputType.number,

                            isObscureText: true,
                            validator: (value) {
                              return null;

                              // return controller.validPassword();
                            },
                            onChanged: (value) {
                              // controller.validPassword();
                            },
                          ),
                        );
                      },
                    ),

                    SizedBox(height: Responsive.getSize(10)),
                    InkWell(
                      onTap: () => _navigator.goto(TneRoutes.passwordRecover),
                      child: Text(
                        'Esqueceu a senha?',
                        style: TneFontStyle.bodyLargeSec.copyWith(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<LoginController>(
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
                  if (controller.loading) return;
                  final notifyService = FirebaseNotificationService();
                  final token = await notifyService.getToken();
                  final credentialController = context
                      .read<CredentialController>();
                  final credential = credentialController.refinedCredential!;
                  await controller.login(
                    credential: credential,
                    notifyToken: token!,
                  );

                  if (controller.hasError && context.mounted) {
                    await ErrorDialog.show(
                      'Atenção',
                      controller.exception!,
                      context,
                    );
                    return;
                  }

                  final credentialStatus =
                      credentialController.credentialStatus;
                  if (credentialStatus!.isWithoutFaceId) {
                    _navigator.goto(TneRoutes.preFaceCapture);
                    return;
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
