import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';
import 'package:ta_na_escola/theme/icons.dart';

import '../../../responsiveness/leg_font_style.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import '../../../theme/colors.dart';

class WithoutAccountPage extends StatefulWidget {
  const WithoutAccountPage({super.key});
  @override
  WithoutAccountPageState createState() => WithoutAccountPageState();
}

class WithoutAccountPageState extends State<WithoutAccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            TneBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: Responsive.getSize(40)),

                    CircleAvatar(
                      backgroundColor: lightGrey,
                      radius: Responsive.getSize(28),
                      child: Icon(
                        TneIcons.user,
                        size: Responsive.getSize(24),
                        color: grey,
                      ),
                    ),

                    SizedBox(height: Responsive.getSize(16)),
                    Consumer<CredentialController>(
                      builder: (context, controller, child) => Text(
                        "${controller.currentCredentialType.toString()}: ${controller.credentialTextController.text}",
                        textAlign: TextAlign.center,
                        style: TneFontStyle.bodyLargeBold,
                      ),
                    ),
                    SizedBox(height: Responsive.getSize(16)),
                    Text(
                      "Não identificamos um cadastro ativo no Tá na Escola.",
                      style: TneFontStyle.bodyLargeBold,
                    ),
                    SizedBox(height: Responsive.getSize(8)),
                    Text(
                      "Por favor, entre em contato com a escola para liberar seu acesso.",
                      style: TneFontStyle.body,
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
            TneRoundedButton(
              width: 250,
              height: 50,
              child: Text(
                "Voltar",
                textAlign: TextAlign.center,
                style: TneFontStyle.titleBold.copyWith(color: secondaryColor),
              ),
              onTap: () async {
                final AppNavigator navigator = AppNavigator();
                navigator.goto(TneRoutes.credential, clearStack: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
