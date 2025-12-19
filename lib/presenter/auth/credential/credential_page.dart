import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/dialogs/error_dialog.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/presenter/auth/credential/controller/controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';
import 'package:ta_na_escola/shared/utils/formatters/cpf_formatter.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../components/dialogs/quit_app_dialog.dart';
import '../../../components/textfields/textfield.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import '../../../theme/colors.dart';

class CredentialPage extends StatefulWidget {
  const CredentialPage({super.key});
  @override
  CredentialPageState createState() => CredentialPageState();
}

final bool isLoading = false;
final AppNavigator navigator = AppNavigator();

class CredentialPageState extends State<CredentialPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      Responsive.defineSize(size, pixelRatio: pixelRatio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }

          bool shouldPop = await QuitAppDialog.show(
            'Sair do Tá na escola?',
            "Deseja sair do Tá na escola?",
            context,
          );
          if (shouldPop) {
            SystemNavigator.pop();
          }
        },

        child: SafeArea(
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
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: Responsive.getSize(32),
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Consumer<CredentialController>(
                          builder: (context, controller, child) {
                            return Form(
                              key: controller.credentialKey,
                              child: Column(
                                children: [
                                  SizedBox(height: Responsive.getSize(100)),
                                  Text(
                                    'Informe sua credencial',
                                    style: TneFontStyle.titleBoldSec,
                                  ),
                                  SizedBox(height: Responsive.getSize(44)),
                                  TneTextfield(
                                    controller:
                                        controller.credentialTextController,
                                    hint: 'CPF ou Email',
                                    formatter: [CpfFormatter.maskFormatter],
                                    onChanged: (value) {
                                      controller.changeCredentialMask();
                                    },
                                    validator: (value) {
                                      return controller.validCredential();
                                    },
                                  ),
                                  SizedBox(height: Responsive.getSize(67)),
                                  TneRoundedButton(
                                    onTap: () async {
                                      if (controller.loading) return;

                                      final isValid = controller
                                          .credentialKey
                                          .currentState!
                                          .validate();
                                      if (!isValid) return;
                                      await controller.checkCredential();
                                      if (controller.credentialStatus == null &&
                                          context.mounted) {
                                        ErrorDialog.show(
                                          'Erro',
                                          'falha ao buscar dados  da credencial. Por favor tente mais tarde',
                                          context,
                                        );
                                        return;
                                      }

                                      if (controller
                                          .credentialStatus!
                                          .isWithoutPassword) {
                                        navigator.goto(
                                          TneRoutes.createPassword,
                                        );

                                        return;
                                      }

                                      if (controller
                                          .credentialStatus!
                                          .isWithoutAccount) {
                                        navigator.goto(
                                          TneRoutes.withoutAccount,
                                        );

                                        return;
                                      }

                                      navigator.goto(TneRoutes.login);
                                    },
                                    child: controller.loading
                                        ? LoadingButton(color: secondaryColor)
                                        : Text(
                                            'Entrar',
                                            style: TneFontStyle.bodyLargeSec
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                  ),
                                  SizedBox(height: Responsive.getSize(20)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Responsive.getSize(300),
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            TneAppAssets.logo,
                            fit: BoxFit.cover,
                            height: Responsive.getSize(118),
                            width: Responsive.getSize(116),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
