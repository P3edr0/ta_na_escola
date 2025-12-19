import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.title, required this.image});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: Responsive.getSize(10),
        horizontal: Responsive.getSize(10),
      ),
      margin: EdgeInsetsDirectional.all(2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: lightGrey.withValues(alpha: 0.05),
            blurRadius: 3,
            spreadRadius: 3,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 3,
            color: lightGrey.withValues(alpha: 0.05),
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: Responsive.getSize(50)),
          SizedBox(height: Responsive.getSize(8)),
          Text(
            title,
            style: TneFontStyle.bodySec.copyWith(
              color: grey,
              fontWeight: FontWeight.w400,
            ),

            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
