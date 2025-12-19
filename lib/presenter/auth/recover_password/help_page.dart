import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../../responsiveness/responsive.dart';
import '../../../theme/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});
  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: Responsive.getSize(60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TneBackButton(),
                  Text(
                    "Ajuda",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold,
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: Responsive.getSize(20)),
                  Text(
                    "Teve algum problema com o login no Tá na escola",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.titleBold.copyWith(
                      color: black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: Responsive.getSize(20)),
                  Text(
                    "Você está tendo dificuldades ou enfrentando algum problema no aplicativo, entre em contato com o nosso suporte o mais rápido possível para que possamos te ajudar.",
                    textAlign: TextAlign.center,
                    style: TneFontStyle.bodyLargeBold.copyWith(color: grey),
                  ),
                  SizedBox(height: Responsive.getSize(60)),
                  TneRoundedButton(
                    width: 280,
                    padding: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.whatsapp,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "(xx)xxxxx-xxxx",
                          textAlign: TextAlign.center,
                          style: TneFontStyle.titleBold.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: Responsive.getSize(20)),
                  TneRoundedButton(
                    padding: 0,
                    width: 280,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, color: secondaryColor),
                        const SizedBox(width: 10),
                        Text(
                          "tanaescola@gmail.com",
                          textAlign: TextAlign.center,
                          style: TneFontStyle.titleBold.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
