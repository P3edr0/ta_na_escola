import 'package:flutter/material.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.image,
    required this.isNextFlag,
    this.onTap,
  });
  final String title;
  final bool isNextFlag;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: Responsive.getSize(10)),
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
        child: Row(
          children: [
            Expanded(
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
            ),
            if (isNextFlag)
              RotatedBox(
                quarterTurns: 3,
                child: Container(
                  padding: EdgeInsets.all(Responsive.getSize(2)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),

                    color: primaryColor,
                  ),
                  child: Text(
                    'Em breve',
                    style: TneFontStyle.verySmallBoldSec.copyWith(
                      color: secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
