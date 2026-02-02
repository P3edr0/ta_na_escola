import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/buttons/circular_button.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';

class MonthCalendar extends StatefulWidget {
  const MonthCalendar({
    super.key,

    required this.monthWidget,
    required this.onTapNextMonth,
    required this.onTapPrevMonth,
    required this.monthNumber,
  });

  final Widget monthWidget;
  final int monthNumber;
  final void Function() onTapNextMonth;
  final void Function() onTapPrevMonth;
  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    DateTime today = DateTime.now();
    DateTime displayedMonth = DateTime(today.year, widget.monthNumber);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.getSize(8)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSize(8)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TneCircularButton(
                      onTap: widget.onTapPrevMonth,
                      size: Responsive.getSize(24),
                      child: Icon(
                        Icons.chevron_left_outlined,
                        color: secondaryColor,
                      ),
                    ),

                    Text(
                      TneDateFormat.calendarFormat(displayedMonth),
                      style: TneFontStyle.bodyLargeBold.copyWith(
                        color: secondaryColor,
                      ),
                    ),
                    TneCircularButton(
                      onTap: widget.onTapNextMonth,
                      size: Responsive.getSize(24),
                      child: Icon(
                        Icons.chevron_right_outlined,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.getSize(8)),
              SizedBox(
                width: size.width - Responsive.getSize(84),
                height: Responsive.getSize(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(child: Text('Dom', style: TneFontStyle.body)),
                    SizedBox(child: Text('Seg', style: TneFontStyle.body)),
                    SizedBox(child: Text('Ter', style: TneFontStyle.body)),
                    SizedBox(child: Text('Qua', style: TneFontStyle.body)),
                    SizedBox(child: Text('Qui', style: TneFontStyle.body)),
                    SizedBox(child: Text('Sex', style: TneFontStyle.body)),
                    SizedBox(child: Text('Sáb', style: TneFontStyle.body)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Divider(height: 2, color: grey),
              const SizedBox(height: 2),

              widget.monthWidget,
              SizedBox(height: Responsive.getSize(16)),
            ],
          ),
        ),
      ],
    );
  }
}
