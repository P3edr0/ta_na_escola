import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/responsive.dart';
import 'package:ta_na_escola/theme/icons.dart';

import '../responsiveness/leg_font_style.dart';
import '../theme/colors.dart';

class TnePasswordAttributes extends StatelessWidget {
  const TnePasswordAttributes({
    super.key,
    required this.content,
    required this.hasCompleted,
  });
  final bool hasCompleted;
  final String content;
  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      hasCompleted ? TneIcons.check : TneIcons.x,
      color: hasCompleted ? primaryFocusColor : alertColor,
      size: Responsive.getSize(16),
    );
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          content,
          textAlign: TextAlign.center,
          style: TneFontStyle.body.copyWith(color: grey),
        ),
      ],
    );
  }
}
