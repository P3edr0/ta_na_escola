import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../shared/utils/app_assets.dart';
import '../../theme/colors.dart';

class TneFrequencyCard extends StatelessWidget {
  const TneFrequencyCard.entry({super.key})
    : label = 'Entrada',
      color = accentColor,
      icon = TneAppAssets.entryIcon;
  const TneFrequencyCard.exit({super.key})
    : label = 'Saída',
      color = blueGrey,
      icon = TneAppAssets.exitIcon;
  final String label;
  final Color color;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6),

      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.5),

        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Row(
          children: [
            Image.asset(icon),
            SizedBox(width: Responsive.getSize(4)),
            Text(
              label,
              style: TneFontStyle.bodySec.copyWith(color: secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
