import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/calendar/pick_custom_range.dart';
import 'package:ta_na_escola/domain/entities/calendar_entity.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/calendar/store/controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/enums/agenda_type.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

import '../../../../../components/app_bar/app_bar.dart';
import '../../../../../components/avatar/avatar_border.dart';
import '../../../../../components/loadings/loading.dart';
import '../../../../../responsiveness/responsive.dart';
import '../../../../../shared/utils/app_assets.dart';
import '../../../../../theme/colors.dart';
import '../../../components/badges/agenda_type_marker.dart';
import '../../../components/cards/agenda_card.dart';
import '../../../components/dialogs/error_dialog.dart';
import '../../../domain/entities/teste_vai_bugar.dart';
import '../home/controller/controller.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final LoginController loginController;
  late final CalendarController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = context.read<CalendarController>();
      final today = DateTime.now();

      loginController = context.read<LoginController>();
      final homeController = context.read<HomeController>();
      controller.startCalendarPage();

      final user = loginController.user!;
      final student = homeController.selectedStudent!;

      final List<Future<void>> futures = [];
      for (var i = 1; i < 13; i++) {
        final data = DataAgendaEntity(
          studentId: student.guardianId,
          schoolId: student.schoolId!,
          token: user.token,
          month: i,
        );

        futures.add(controller.getAgenda(data: data));
      }

      try {
        await Future.wait(futures);
      } catch (exception) {
        log(exception.toString(), name: 'AGENDA ERROR');
        await ErrorDialog.show(
          'Atenção',
          'Não foi possível buscar os dados do calendário',
          context,
        );
      }

      for (var i = 1; i < 13; i++) {
        final startDate = DateTime(today.year, i);
        controller.setCurrentAgendaIndex(i);

        buildMonthGrid(
          agenda: controller.agenda,
          monthCalendarDate: startDate,
          context: context,
        );
      }

      controller.setCurrentMonthWidget(today.month - 1);
      controller.setCalendarPageLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CalendarController>(
          builder: (context, controller, child) {
            if (controller.calendarPageLoading) {
              return TnePageLoading();
            }

            final HomeController homeController = context
                .read<HomeController>();

            final student = homeController.selectedStudent;
            final calendar = controller.month!;
            final agenda = controller.agenda;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,

                        color: secondaryColor,
                        child: Image.asset(
                          TneAppAssets.backgroundOverall,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TneAppBar(title: 'Calendário'),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: Responsive.getSize(96),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: Responsive.getSize(40)),

                              TneCalendar(
                                month: calendar,
                                monthNumber: controller.currentAgendaIndex,
                                onTapNextMonth: controller.onTapNextMonth,
                                onTapPrevMonth: controller.onTapPrevMonth,
                                isProjection: false,
                              ),

                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Responsive.getSize(16),
                                    horizontal: Responsive.getSize(24),
                                  ),
                                  itemCount: agenda.length,
                                  shrinkWrap: true,

                                  itemBuilder: (context, index) {
                                    final dayAgenda = agenda[index];

                                    return AgendaCard(
                                      key: ValueKey('${dayAgenda.id}_$index}'),
                                      agenda: dayAgenda,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: Responsive.getSize(590),
                        left: 0,
                        right: 0,
                        top: Responsive.getSize(-20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),

                            Expanded(
                              child: TneAvatarBorder(
                                image: NetworkImage(student!.image!),
                                radius: 30,
                                hasBottomPadding: true,
                                color: accentColor,
                              ),
                            ),

                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  buildMonthGrid({
    required DateTime monthCalendarDate,
    required List<CalendarEntity> agenda,
    required BuildContext context,
  }) {
    final List<Widget> tempDays = [];
    final firstDayOfMonth = DateTime(
      monthCalendarDate.year,
      monthCalendarDate.month,
    );
    final daysInMonth = DateTime(
      monthCalendarDate.year,
      monthCalendarDate.month + 1,
      0,
    ).day;
    final today = DateTime.now().normalize();
    final firstWeekday = firstDayOfMonth.weekday + 1;

    if (firstWeekday != 8) {
      for (int i = 1; i < firstWeekday; i++) {
        tempDays.add(const SizedBox());
      }
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final currentAgenda = agenda
          .where((element) => element.date.day == day)
          .toList();

      int events = 0;
      int notations = 0;
      for (var index = 0; index < currentAgenda.length; index++) {
        if (currentAgenda[index].agendaType.isEvent) {
          events++;
        } else {
          notations++;
        }
      }

      final List<Widget> agendaMarkers = [];

      if (events > 0 && notations > 0) {
        agendaMarkers.addAll([
          AgendaTypeMarker(color: AgendaType.event.getColor()),
          AgendaTypeMarker(color: AgendaType.notation.getColor()),
        ]);
      } else if (events > 0) {
        final handledEvents = events > 2 ? 2 : 1;
        for (var i = 0; i < handledEvents; i++) {
          agendaMarkers.add(
            AgendaTypeMarker(color: AgendaType.event.getColor()),
          );
        }
      } else if (notations > 0) {
        final handledNotations = notations > 2 ? 2 : 1;
        for (var i = 0; i < handledNotations; i++) {
          agendaMarkers.add(
            AgendaTypeMarker(color: AgendaType.notation.getColor()),
          );
        }
      }

      if (agendaMarkers.isEmpty) {
        agendaMarkers.add(AgendaTypeMarker(color: transparent));
      }
      final date = DateTime(
        monthCalendarDate.year,
        monthCalendarDate.month,
        day,
      );

      final bool isToday = date.normalize().isAtSameMomentAs(today);

      if (isToday) {
        tempDays.add(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSize(4)),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.toString(),

                  style: TneFontStyle.bodyLargeSec,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: agendaMarkers,
              ),
            ],
          ),
        );
      } else {
        tempDays.add(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Responsive.getSize(4)),

                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Text(
                  day.toString(),

                  style: TneFontStyle.bodyLargeSec,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: agendaMarkers,
              ),
            ],
          ),
        );
      }
    }

    final handledMonth = GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: tempDays,
    );

    controller.monthsWidgets.add(handledMonth);
  }
}
