import 'package:flutter/material.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class FaceCaptureTipCard extends StatelessWidget {
  const FaceCaptureTipCard({
    super.key,
    required this.heavyText,
    required this.lightText,
  });
  final String heavyText;
  final String lightText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: Responsive.getSize(16),
        horizontal: Responsive.getSize(10),
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: lightGrey,
            blurRadius: 0.9,
            spreadRadius: 0.9,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            blurRadius: 0.9,
            spreadRadius: 0.9,
            color: lightGrey,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(TneAppAssets.alert, height: Responsive.getSize(20)),
          SizedBox(width: Responsive.getSize(8)),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: heavyText,
                    style: TneFontStyle.bodyBoldSec.copyWith(color: grey),
                  ),
                  TextSpan(
                    text: lightText,
                    style: TneFontStyle.bodySec.copyWith(
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.start,
              style: TneFontStyle.bodyLargeBold.copyWith(color: grey),
            ),
          ),
        ],
      ),
    );
  }
}
