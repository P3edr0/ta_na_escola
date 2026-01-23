import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../../responsiveness/responsive.dart';

class BlocAppPage extends StatelessWidget {
  const BlocAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
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
                    'ATENÇÃO!',
                    style: TneFontStyle.bodyLargeBold.copyWith(
                      color: alertColor,
                    ),
                  ),
                  Text(
                    'Houve uma falha ao tentar acessar o Tá na escola.\n Por favor, tente novamente mais tarde',
                    textAlign: TextAlign.center,
                    style: TneFontStyle.body.copyWith(color: blueGrey),
                  ),

                  SizedBox(height: Responsive.getSize(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
