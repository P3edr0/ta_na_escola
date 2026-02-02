import 'package:flutter/material.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../responsiveness/responsive.dart';
import 'custom_range_picker.dart';

class TneCalendar extends StatefulWidget {
  const TneCalendar({
    super.key,
    required this.month,
    required this.isProjection,
    required this.onTapNextMonth,
    required this.onTapPrevMonth,
    required this.monthNumber,
    this.backgroundButtonColor = mediumGrey,
  });

  final Widget month;
  final int monthNumber;

  final bool isProjection;
  final Color backgroundButtonColor;
  final void Function() onTapNextMonth;
  final void Function() onTapPrevMonth;

  @override
  State<TneCalendar> createState() => _TneCalendarState();
}

class _TneCalendarState extends State<TneCalendar> {
  final menuController = MenuController();
  late bool haveDatepicker;

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.getSize(24)),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(height: Responsive.getSize(8)),

          MonthCalendar(
            monthWidget: widget.month,
            onTapNextMonth: widget.onTapNextMonth,
            onTapPrevMonth: widget.onTapPrevMonth,
            monthNumber: widget.monthNumber,
          ),
        ],
      ),
    );
  }
}
