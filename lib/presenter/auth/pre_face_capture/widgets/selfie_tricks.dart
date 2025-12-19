import 'package:flutter/material.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';

import '../../../../responsiveness/responsive.dart';

class SelfieTricks extends StatelessWidget {
  const SelfieTricks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox.square(
          dimension: Responsive.getSize(52),
          child: Image.asset(TneAppAssets.selfieTrickOne, fit: BoxFit.cover),
        ),
        SizedBox.square(
          dimension: Responsive.getSize(52),
          child: Image.asset(TneAppAssets.selfieTrickTwo, fit: BoxFit.cover),
        ),
        SizedBox.square(
          dimension: Responsive.getSize(52),
          child: Image.asset(TneAppAssets.selfieTrickThree, fit: BoxFit.cover),
        ),
        SizedBox.square(
          dimension: Responsive.getSize(52),
          child: Image.asset(TneAppAssets.selfieTrickFour, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
