import 'package:ta_na_escola/domain/entities/calendar_entity.dart';
import 'package:ta_na_escola/shared/utils/enums/event_type.dart';
import 'package:ta_na_escola/shared/utils/enums/exclusivity_type.dart';

class AgendaMapper {
  static List<CalendarEntity> fromMap(Map<String, dynamic> data) {
    final events = List<Map<String, dynamic>>.from(data['eventos']);
    final notations = List<Map<String, dynamic>>.from(data['anotacoes']);
    final List<CalendarEntity> agenda = [];
    final int month = data['month'];
    String id;
    String description;
    DateTime? date;
    for (var event in events) {
      id = event['idEvento'].toString();
      description = event['descricaoEvento'];
      date = DateTime.parse(event['dataEvento']).subtract(Duration(hours: 6));
      EventType eventType = EventType.translate(event['tipoEvento']);
      ExclusivityType exclusivityType = ExclusivityType.translate(
        event['exclusividadeEvento'],
      );

      final handledEvent = EventEntity(
        id: id,
        monthReference: month,
        description: description,
        date: date,
        exclusivity: exclusivityType,
        eventType: eventType,
      );

      agenda.add(handledEvent);
    }
    id = '';
    description = '';
    date = null;

    for (var event in notations) {
      id = event['idAnotacao'].toString();
      description = event['descricaoAnotacao'];
      date = DateTime.parse(event['dataAnotacao']).subtract(Duration(hours: 6));
      String resume = event['resumoAnotacao'];

      final handledEvent = NotationEntity(
        id: id,
        monthReference: month,
        description: description,
        date: date,
        resume: resume,
      );

      agenda.add(handledEvent);
    }

    return agenda;
  }
}
