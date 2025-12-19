import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/store/recover_password_controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import '../../../shared/utils/routes/app_routes.dart';
import '../../../theme/colors.dart';

class PasswordRecoverEmailPage extends StatefulWidget {
  const PasswordRecoverEmailPage({super.key});
  @override
  PasswordRecoverEmailPageState createState() =>
      PasswordRecoverEmailPageState();
}

class PasswordRecoverEmailPageState extends State<PasswordRecoverEmailPage> {
  @override
  void initState() {
    super.initState();
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
                  const SizedBox(width: 50),

                  Text(
                    "Redefinir sua senha",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold,
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
            SizedBox(height: Responsive.getSize(50)),

            Spacer(),
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 80,
              color: primaryColor,
            ),
            SizedBox(height: Responsive.getSize(30)),
            Consumer<RecoverPasswordController>(
              builder: (context, controller, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "O e-mail de redefinição de senha foi enviado para ${controller.recoveryEmail}",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold.copyWith(color: grey),
                  ),
                );
              },
            ),
            Spacer(),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.home_outlined,
                    size: 24,
                    color: secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Voltar",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold.copyWith(
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                final navigator = AppNavigator();
                navigator.goto(TneRoutes.credential, clearStack: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
