import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../components/cards/face_capture_tip_card.dart';
import '../../../responsiveness/leg_font_style.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import '../../../theme/colors.dart';
import 'widgets/selfie_tricks.dart';

class PreFaceCapturePage extends StatefulWidget {
  const PreFaceCapturePage({super.key});
  @override
  PreFaceCapturePageState createState() => PreFaceCapturePageState();
}

class PreFaceCapturePageState extends State<PreFaceCapturePage> {
  @override
  void initState() {
    super.initState();
  }

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
                    SizedBox(height: Responsive.getSize(40)),

                    FaceCaptureTipCard(
                      heavyText:
                          'NÃO UTILIZE O MESMO ROSTO DO TITULAR OU DE TERCEIROS ',
                      lightText: 'QUE NÃO ESTEJAM VINCULADOS A ESSE CPF.',
                    ),
                    SizedBox(height: Responsive.getSize(30)),
                    FaceCaptureTipCard(
                      heavyText: 'O MESMO ROSTO EM DOIS CADASTROS ',
                      lightText: 'NÃO DÁ ACESSO PARA DUAS PESSOAS.',
                    ),
                    SizedBox(height: Responsive.getSize(30)),
                    FaceCaptureTipCard(
                      heavyText: 'EVITE PROBLEMAS ',
                      lightText:
                          'E GARANTA SUA ENTRADA E A DOS DEMAIS COM TRANQUILIDADE!',
                    ),
                    SizedBox(height: Responsive.getSize(34)),

                    Text(
                      "Para concluir, vamos finalizar com a foto do usuário informado",
                      textAlign: TextAlign.center,
                      style: TneFontStyle.bodyLargeBold.copyWith(color: grey),
                    ),
                    const SizedBox(height: 10),
                    const SelfieTricks(),
                    const SizedBox(height: 10),
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
            TneRoundedButton(
              width: 250,
              height: 50,
              child: Text(
                "Prosseguir",
                textAlign: TextAlign.center,
                style: TneFontStyle.titleBold.copyWith(color: secondaryColor),
              ),
              onTap: () async {
                final AppNavigator navigator = AppNavigator();
                navigator.goto(TneRoutes.faceCapture);
              },
            ),
          ],
        ),
      ),
    );
  }
}
