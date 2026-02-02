import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/usecases/calendar/get_agenda_by_month_usecase.dart';

import '../../../../domain/entities/calendar_entity.dart';
import '../../../../domain/entities/teste_vai_bugar.dart';

class CalendarController extends ChangeNotifier {
  CalendarController({required this.getAgendaByMonthUsecase});
  final GetAgendaByMonthUsecase getAgendaByMonthUsecase;

  ScrollController scrollController = ScrollController();
  bool calendarLoading = false;
  bool calendarPageLoading = true;
  String? exception;
  List<Widget> monthsWidgets = [];
  Widget? month;
  List<CalendarEntity> agenda = [];
  Map<int, List<CalendarEntity>> allMonthsAgenda = {};
  int currentMonthIndex = 0;
  int currentAgendaIndex = 1;
  Widget? get currentMonthWidget => monthsWidgets[currentMonthIndex];

  ////////////// GET

  bool get hasError => exception != null;

  ////////////// FUNCTIONS

  void setCalendarPageLoading([bool? newCalendarPageLoading]) {
    if (newCalendarPageLoading != null) {
      calendarPageLoading = newCalendarPageLoading;
      notifyListeners();
      return;
    }
    calendarPageLoading = !calendarPageLoading;
    notifyListeners();
  }

  void setCalendarLoading([bool? newCalendarLoading]) {
    if (newCalendarLoading != null) {
      calendarLoading = newCalendarLoading;
      notifyListeners();
      return;
    }
    calendarLoading = !calendarLoading;
    notifyListeners();
  }

  setCurrentMonthWidget(int index) {
    currentMonthIndex = index;
    month = monthsWidgets[currentMonthIndex];

    setCurrentAgendaIndex(index + 1);
  }

  setCurrentAgendaIndex(int index) {
    currentAgendaIndex = index;
    if (allMonthsAgenda.containsKey(currentAgendaIndex)) {
      agenda = allMonthsAgenda[currentAgendaIndex]!;
    } else {
      agenda = [];
    }
    notifyListeners();
  }

  onTapNextMonth() {
    if (currentMonthIndex < 11) {
      currentMonthIndex++;
      currentAgendaIndex++;

      month = monthsWidgets[currentMonthIndex];
      agenda = allMonthsAgenda[currentAgendaIndex] ?? [];
      notifyListeners();
    }
  }

  onTapPrevMonth() {
    if (currentMonthIndex > 0) {
      currentMonthIndex--;

      currentAgendaIndex--;
      agenda = allMonthsAgenda[currentAgendaIndex] ?? [];
      month = monthsWidgets[currentMonthIndex];
      notifyListeners();
    }
  }

  startCalendarPage() {
    monthsWidgets.clear();
    agenda.clear();
    allMonthsAgenda.clear();
    currentMonthIndex = 0;
    calendarPageLoading = true;
    notifyListeners();
  }

  Future<void> getAgenda({required DataAgendaEntity data}) async {
    final response = await getAgendaByMonthUsecase(data: data);
    response.fold(
      (newException) {
        exception = 'Falha ao buscar notificações';
        log(newException.message, name: 'AGENDA ERROR');
        agenda.clear();
      },
      (newAgenda) {
        exception = null;
        if (newAgenda.isNotEmpty) {
          newAgenda.sort((a, b) => a.date.day.compareTo(b.date.day));
          log('Nova AGENDA', name: 'Mes ${newAgenda.first.monthReference}');

          final monthRef = newAgenda.first.monthReference;
          allMonthsAgenda.putIfAbsent(monthRef, () => newAgenda);
        } else {
          log('Nova AGENDA VAZIA', name: 'Mes ${data.month}');
        }
      },
    );
  }

  // Future<void> getNewAgendaMonth({required DataAgendaEntity data}) async {
  //   setCalendarPageLoading();
  //   final response = await getAgendaByMonthUsecase(data: data);
  //   response.fold(
  //     (newException) {
  //       exception = 'Falha ao buscar notificações';
  //       log(newException.message, name: 'NOTIFICATION CATEGORY ERROR');
  //       setCalendarPageLoading();
  //     },
  //     (newAgenda) {
  //       agenda = [...newAgenda];
  //       final monthRef = newAgenda.first.monthReference;
  //       allMonthsAgenda.putIfAbsent(monthRef, () => newAgenda);
  //       setCalendarPageLoading();
  //     },
  //   );
  // }
}
