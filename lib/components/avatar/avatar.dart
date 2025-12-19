import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneAvatar extends StatelessWidget {
  const TneAvatar({
    super.key,
    required this.image,
    required this.radius,
    this.subtitle,
    this.onTap,
  });
  final ImageProvider image;
  final double radius;
  final String? subtitle;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final handledPadding = subtitle != null
        ? EdgeInsets.only(top: Responsive.getSize(10))
        : EdgeInsets.zero;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: handledPadding,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: lightGrey.withValues(alpha: 0.2),
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(1, 1),
                  ),
                  BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    color: lightGrey.withValues(alpha: 0.2),
                    offset: Offset(-1, -1),
                  ),
                ],
              ),
              padding: EdgeInsets.all(2),

              child: CircleAvatar(
                radius: Responsive.getSize(radius),
                backgroundImage: image,
              ),
            ),
            if (subtitle != null)
              Container(
                margin: EdgeInsets.only(top: Responsive.getSize(4)),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.getSize(4),
                  vertical: Responsive.getSize(1),
                ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  border: Border.all(width: 1, color: grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  subtitle!,
                  style: TneFontStyle.verySmallBoldSec.copyWith(color: grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
