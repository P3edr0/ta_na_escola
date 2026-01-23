import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneFrequencyTypesCard extends StatelessWidget {
  const TneFrequencyTypesCard({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6),

      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.5),

        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Column(
          children: [
            Icon(icon, size: Responsive.getSize(50), color: secondaryColor),
            SizedBox(height: Responsive.getSize(4)),
            Text(
              label,
              style: TneFontStyle.bodyBold.copyWith(color: secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
