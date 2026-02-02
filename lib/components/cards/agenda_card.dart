import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

import '../../domain/entities/calendar_entity.dart';
import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';
import '../badges/agenda_type_marker.dart';
import '../badges/badge.dart';

class AgendaCard extends StatefulWidget {
  const AgendaCard({super.key, required this.agenda});
  final CalendarEntity agenda;

  @override
  State<AgendaCard> createState() => _AgendaCardState();
}

class _AgendaCardState extends State<AgendaCard> {
  EventEntity? event;
  NotationEntity? notation;
  @override
  void initState() {
    super.initState();
    if (widget.agenda.agendaType.isEvent) {
      event = widget.agenda as EventEntity;
      notation = null;
    } else {
      notation = widget.agenda as NotationEntity;
      event = null;
    }
    log(widget.agenda.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (event != null) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: Responsive.getSize(10)),
        padding: EdgeInsets.all(Responsive.getSize(8)),
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: Responsive.getSize(65),
              child: Column(
                children: [
                  Text(
                    event!.date.day.toString(),
                    style: TneFontStyle.h3Bold.copyWith(color: blueGrey),
                  ),
                  TneBadge(
                    label: TneDateFormat.getWeekdayAbbreviation(event!.date),
                  ),
                ],
              ),
            ),
            // SizedBox(width: Responsive.getSize(10)),
            AgendaTypeMarker(
              color: event!.agendaType.getColor(),
              topMargin: 10,
            ),

            SizedBox(width: Responsive.getSize(5)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Responsive.getSize(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event!.description, style: TneFontStyle.small),
                    Text(
                      TneDateFormat.getHour(event!.date),
                      style: TneFontStyle.small.copyWith(color: accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.getSize(10)),
      padding: EdgeInsets.all(Responsive.getSize(8)),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: Responsive.getSize(65),
            child: Column(
              children: [
                Text(
                  notation!.date.day.toString(),
                  style: TneFontStyle.h3Bold.copyWith(color: blueGrey),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                TneBadge(
                  label: TneDateFormat.getWeekdayAbbreviation(notation!.date),
                ),
              ],
            ),
          ),
          // SizedBox(width: Responsive.getSize(10)),
          AgendaTypeMarker(
            color: notation!.agendaType.getColor(),
            topMargin: 10,
          ),
          SizedBox(width: Responsive.getSize(5)),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Responsive.getSize(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notation!.resume,
                    style: TneFontStyle.small,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                  SizedBox(height: Responsive.getSize(4)),
                  Text(
                    TneDateFormat.getHour(notation!.date),
                    style: TneFontStyle.small.copyWith(color: accentColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
