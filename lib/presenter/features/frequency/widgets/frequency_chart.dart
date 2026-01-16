import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../../../responsiveness/responsive.dart';

class TneFrequencyChart extends StatefulWidget {
  const TneFrequencyChart({
    super.key,
    required this.absencesPercentage,
    required this.presencesPercentage,
  });
  final double absencesPercentage;
  final double presencesPercentage;

  @override
  State<StatefulWidget> createState() => TneFrequencyChartState();
}

class TneFrequencyChartState extends State<TneFrequencyChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        PieChart(
          PieChartData(
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: Responsive.getSize(25),
            sections: showingSections(),
          ),
        ),
        Text(
          '${widget.presencesPercentage.toStringAsFixed(1)}%',
          style: TneFontStyle.titleBoldSec.copyWith(color: blueGrey),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final fontSize = Responsive.getSize(12.0);
      final radius = Responsive.getSize(6.0);
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return switch (i) {
        0 => PieChartSectionData(
          color: accentColor,
          value: widget.presencesPercentage,

          radius: radius,
          showTitle: false,

          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
            shadows: shadows,
          ),
        ),
        1 => PieChartSectionData(
          showTitle: false,
          color: alertColor,
          value: widget.absencesPercentage,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
            shadows: shadows,
          ),
        ),

        _ => throw StateError('Invalid'),
      };
    });
  }
}
