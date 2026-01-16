import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';

import '../../../../components/cards/frequency_date_card.dart';
import '../../../../responsiveness/leg_font_style.dart';
import '../../../../responsiveness/responsive.dart';
import '../../../../shared/utils/formatters/date_formatter.dart';
import '../../../../theme/colors.dart';

class TneFrequencyList extends StatelessWidget {
  const TneFrequencyList({super.key, required this.items});
  final List<FrequencyEntity> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Responsive.getSize(32)),
            Image.asset(TneAppAssets.emptyList, fit: BoxFit.cover),
            SizedBox(height: Responsive.getSize(10)),
            Text(
              'Não foram encontrados registros neste período.',
              style: TneFontStyle.bodySec.copyWith(color: grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.getSize(32)),
          ],
        ),
      );
    }

    return Column(
      children: items.map((frequencyData) {
        final date = TneDateFormat.frequencyFormat(
          frequencyData.day,
        ).split(' ');

        if (frequencyData.entryTime == null && frequencyData.exitTime == null) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.getSize(8),
              horizontal: Responsive.getSize(2),
            ),
            child: TneFrequencyDateCard.fault(
              day: date.first,
              month: date[1],
              justify: '---',
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.getSize(8),
            horizontal: Responsive.getSize(2),
          ),
          child: TneFrequencyDateCard(
            day: date.first,
            month: date[1],
            entryTime: frequencyData.entryTime ?? '--:--',
            exitTime: frequencyData.exitTime ?? '--:--',
          ),
        );
      }).toList(),
    );
  }
}
