import 'package:ta_na_escola/shared/utils/enums/event_type.dart';
import 'package:ta_na_escola/shared/utils/enums/exclusivity_type.dart';

import '../../shared/utils/enums/agenda_type.dart';

class CalendarEntity {
  CalendarEntity({
    required this.id,
    required this.monthReference,
    required this.description,
    required this.date,
    required this.agendaType,
  });

  String id;
  int monthReference;
  String description;
  DateTime date;
  AgendaType agendaType;
}

class EventEntity extends CalendarEntity {
  EventEntity({
    required super.id,
    required super.monthReference,

    required super.description,
    required super.date,
    super.agendaType = AgendaType.event,
    required this.exclusivity,
    required this.eventType,
  });

  ExclusivityType exclusivity;
  EventType eventType;
}

class NotationEntity extends CalendarEntity {
  NotationEntity({
    required super.id,
    required super.monthReference,

    required super.description,
    required super.date,
    super.agendaType = AgendaType.notation,
    required this.resume,
  });

  String resume;
}
