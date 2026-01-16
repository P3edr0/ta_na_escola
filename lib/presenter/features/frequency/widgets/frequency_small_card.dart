import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../../../responsiveness/responsive.dart';
import '../../../../theme/colors.dart';

class FrequencySmallCard extends StatelessWidget {
  const FrequencySmallCard({
    super.key,
    required this.content,
    required this.contentColor,
    required this.title,
  });
  final String title;
  final int content;
  final Color contentColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(Responsive.getSize(8)),
        margin: EdgeInsets.symmetric(horizontal: Responsive.getSize(2)),
        decoration: BoxDecoration(
          color: lightGrey.withValues(alpha: 0.025),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content.toString(),
              style: TneFontStyle.h4BoldSec.copyWith(
                color: contentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(title, style: TneFontStyle.verySmall.copyWith(color: grey)),
          ],
        ),
      ),
    );
  }
}
