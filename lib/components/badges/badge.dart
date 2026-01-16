import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneBadge extends StatelessWidget {
  const TneBadge({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSize(12),
        vertical: Responsive.getSize(2),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        color: primaryFocusColor.withValues(alpha: 0.1),
      ),
      child: Text(
        label,
        style: TneFontStyle.smallSec.copyWith(color: primaryColor),
      ),
    );
  }
}
