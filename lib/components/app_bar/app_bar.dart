import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/buttons/back_button.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneAppBar extends StatelessWidget {
  const TneAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Responsive.getSize(Responsive.getSize(4)),
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TneBackButton.transparent(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              title,
              style: TneFontStyle.bodyBoldSec.copyWith(color: secondaryColor),
            ),
          ),
          SizedBox(width: Responsive.getSize(40)),
        ],
      ),
    );
  }
}
