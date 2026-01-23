import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/badges/badge.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/handler/value_handler.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneNotificationCard extends StatelessWidget {
  const TneNotificationCard({
    super.key,
    required this.image,
    required this.title,
    required this.notificationQtd,
    this.onTap,
  }) : date = null,
       isDetail = false,
       isFrequency = false,
       read = true,
       content = null;
  const TneNotificationCard.details({
    super.key,
    required this.image,
    required this.title,

    required this.date,
    required this.content,
    required this.read,
    required this.isFrequency,
    this.onTap,
  }) : isDetail = true,
       notificationQtd = 0;

  final String image;
  final String title;
  final String? content;
  final String? date;
  final int? notificationQtd;
  final bool isDetail;
  final bool read;
  final bool isFrequency;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isExit = (isFrequency && isDetail && content!.contains('saiu'));
    final handledColor = isExit ? alertColor : accentColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Responsive.getSize(isDetail ? 10 : 16),
          horizontal: Responsive.getSize(10),
        ),
        margin: EdgeInsets.only(
          bottom: Responsive.getSize(20),
          left: 2,
          right: 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,

          boxShadow: [
            BoxShadow(
              color: read
                  ? lightGrey.withValues(alpha: 0.03)
                  : handledColor.withValues(alpha: 0.3),
              blurRadius: 0.9,
              spreadRadius: 0.9,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              blurRadius: 0.9,
              spreadRadius: 0.9,
              color: read
                  ? lightGrey.withValues(alpha: 0.03)
                  : handledColor.withValues(alpha: 0.3),
              offset: Offset(-1, -1),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(image, height: Responsive.getSize(36)),
            SizedBox(width: Responsive.getSize(20)),
            if (isDetail) detailsContent(handledColor),
            if (!isDetail) ...categoryContent(),
          ],
        ),
      ),
    );
  }

  List<Widget> categoryContent() {
    return [
      Text(
        title,
        maxLines: 1,

        overflow: TextOverflow.ellipsis,
        style: TneFontStyle.bodyLargeSec.copyWith(color: blueGrey, height: 1),
      ),
      Spacer(),
      if (notificationQtd != null && notificationQtd! > 0)
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSize(8),
            vertical: Responsive.getSize(4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: primaryColor.withValues(alpha: 0.1),
          ),
          child: Text(
            TneValueHandler.smallNumberToShow(notificationQtd!),
            maxLines: 1,

            overflow: TextOverflow.ellipsis,
            style: TneFontStyle.bodySec.copyWith(
              color: primaryColor,
              height: 1,
            ),
          ),
        ),
    ];
  }

  Widget detailsContent(Color handledColor) {
    String handledTitle = '';
    bool isExit = false;
    if (isFrequency) {
      if (content!.contains('saiu')) {
        handledTitle = 'Saída';
        isExit = true;
      } else {
        handledTitle = 'Entrada';
      }
    } else {
      handledTitle = title;
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isExit) TneBadge.secondary(label: handledTitle),
              if (!isExit) TneBadge(label: handledTitle),

              Spacer(),
              Text(
                date!,
                maxLines: 1,

                style: TneFontStyle.smallSec.copyWith(
                  color: handledColor,
                  height: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSize(6)),
          Text(
            content!,
            maxLines: 2,

            overflow: TextOverflow.ellipsis,
            style: TneFontStyle.smallSec.copyWith(color: blueGrey, height: 1),
          ),
        ],
      ),
    );
  }
}
