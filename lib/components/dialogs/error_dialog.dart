import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';
import '../buttons/rounded_button.dart';

class ErrorDialog {
  const ErrorDialog();

  static Future show(String title, String content, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(content, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TneRoundedButton(
            height: 50,
            width: Responsive.getSize(140),
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              "Fechar",
              textAlign: TextAlign.center,
              style: TneFontStyle.titleBold.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
