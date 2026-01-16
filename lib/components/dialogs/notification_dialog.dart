import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/theme/colors.dart';

class NotificationDialog {
  const NotificationDialog();

  static Future show({
    required String image,
    required String title,
    required String content,
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          TneRoundedButton(
            onTap: () => Navigator.of(context).pop(),

            child: Text(
              'Fechar',
              style: TneFontStyle.bodyBoldSec.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
