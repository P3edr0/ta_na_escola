import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/services/version/app_version_service.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../../components/dialogs/quit_app_dialog.dart';
import '../../../responsiveness/responsive.dart';
import '../../../services/version/url_launcher_service.dart/url_launcher_service.dart';

class UpdateAppPage extends StatelessWidget {
  const UpdateAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppVersionService versionService = context.read<AppVersionService>();
    final appVersion = versionService.appVersion;
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
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Image.asset(
                      TneAppAssets.background,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(Responsive.getSize(16)),
                width: Responsive.getSize(300),

                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(TneAppAssets.logo, fit: BoxFit.cover),
                    SizedBox(height: Responsive.getSize(10)),

                    Text(
                      'NOVA VERSÃO DISPONÍVEL',
                      style: TneFontStyle.bodyLargeBold.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Temos uma nova versão do nosso App na loja.\n Atualize agora mesmo para continuar',
                      textAlign: TextAlign.center,
                      style: TneFontStyle.body.copyWith(color: blueGrey),
                    ),
                    SizedBox(height: Responsive.getSize(16)),
                    Text(
                      '+ Novos recursos incríveis\n+ Segurança\n+ Melhor performance',

                      style: TneFontStyle.body.copyWith(color: primaryColor),
                    ),
                    SizedBox(height: Responsive.getSize(20)),
                    TneRoundedButton(
                      child: Text(
                        'ATUALIZAR AGORA',
                        style: TneFontStyle.bodyLarge.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                      onTap: () async {
                        final versionService = context
                            .read<AppVersionService>();
                        final urlLauncherService = context
                            .read<IUrlLauncherService>();
                        final storeUrl = versionService.storeUrl;
                        if (storeUrl == null) return;
                        await urlLauncherService.launchCurrentUrl(storeUrl);
                      },
                    ),
                    SizedBox(height: Responsive.getSize(6)),

                    if (appVersion != null)
                      Text(
                        'Versão:$appVersion',
                        style: TneFontStyle.verySmallBold.copyWith(
                          color: primaryColor,
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
