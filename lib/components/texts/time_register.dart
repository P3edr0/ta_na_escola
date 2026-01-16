import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../responsiveness/responsive.dart';

class TneTimeRegister extends StatelessWidget {
  const TneTimeRegister({super.key, required this.color, required this.time})
    : isWithSubtitle = false,
      subtitle = null;
  const TneTimeRegister.withSubtitle({
    super.key,
    required this.color,
    required this.time,
    required this.subtitle,
  }) : isWithSubtitle = true;

  final Color color;
  final String time;
  final String? subtitle;
  final bool isWithSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      crossAxisAlignment: isWithSubtitle
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(time, style: TneFontStyle.bodyLargeSec.copyWith(color: color)),
        if (!isWithSubtitle)
          Container(
            color: color,
            width: Responsive.getSize(26),
            height: Responsive.getSize(2),
          ),
        if (isWithSubtitle)
          Text(
            subtitle!,

            style: TneFontStyle.bodyLargeSec.copyWith(color: color),
          ),
      ],
    );
  }
}
