import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';

import '../../responsiveness/responsive.dart';
import '../../shared/utils/app_assets.dart';
import '../../theme/colors.dart';
import '../texts/time_register.dart';

class TneFrequencyDateCard extends StatelessWidget {
  const TneFrequencyDateCard({
    super.key,
    required this.day,
    required this.month,
    required this.entryTime,
    required this.exitTime,
  }) : isFault = false,
       justify = null;
  const TneFrequencyDateCard.fault({
    super.key,
    required this.day,
    required this.month,

    required this.justify,
  }) : isFault = true,
       entryTime = null,
       exitTime = null;
  final String day;
  final String month;
  final String? entryTime;
  final String? exitTime;
  final String? justify;
  final bool isFault;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,

        boxShadow: [
          BoxShadow(
            color: lightGrey.withValues(alpha: 0.03),
            blurRadius: 0.9,
            spreadRadius: 0.9,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            blurRadius: 0.9,
            spreadRadius: 0.9,
            color: lightGrey.withValues(alpha: 0.03),
            offset: Offset(-1, -1),
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.getSize(12)),
            decoration: BoxDecoration(
              gradient: isFault ? null : primaryGradient,
              color: isFault ? alertColor : null,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  day,
                  style: TneFontStyle.h4BoldSec.copyWith(
                    color: secondaryColor,
                    height: 1,
                  ),
                ),
                Text(
                  month,

                  style: TneFontStyle.bodySec.copyWith(
                    color: secondaryColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.getSize(20)),
          if (isFault)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Falta',
                    style: TneFontStyle.bodyLarge.copyWith(
                      color: alertColor,
                      height: 1,
                    ),
                  ),
                  Text(
                    justify!,
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,
                    style: TneFontStyle.bodySec.copyWith(
                      color: blueGrey,

                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          if (!isFault) ...[
            Image.asset(
              TneAppAssets.entryIconGreen,
              height: Responsive.getSize(36),
              fit: BoxFit.cover,
            ),
            SizedBox(width: Responsive.getSize(8)),

            TneTimeRegister.withSubtitle(
              color: accentColor,
              time: entryTime!,
              subtitle: 'Entrada',
            ),
            SizedBox(width: Responsive.getSize(20)),
            Image.asset(
              TneAppAssets.exitIconGrey,
              height: Responsive.getSize(36),
              fit: BoxFit.cover,
            ),
            SizedBox(width: Responsive.getSize(8)),

            TneTimeRegister.withSubtitle(
              color: blueGrey,
              time: exitTime!,
              subtitle: 'Saída',
            ),
          ],
        ],
      ),
    );
  }
}
