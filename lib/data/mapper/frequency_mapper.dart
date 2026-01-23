import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';
import 'package:ta_na_escola/shared/utils/handler/value_handler.dart';

import '../../domain/entities/frequency_entity.dart';

class FrequencyMapper {
  static FrequencyEntity fromMap(Map<String, dynamic> data) {
    late final DateTime? day;
    DateTime? entryTime;
    DateTime? exitTime;
    String? handledEntryTime;
    String? handledExitTime;
    bool didHaveClass = false;
    try {
      day = DateTime.tryParse(data['dia'].toString());
    } catch (e) {
      day = TneDateFormat.toDate(data['dia'].toString());
    }
    final times = List<Map<String, dynamic>>.from(data['entradaSaidas'] ?? []);

    for (var i = 0; i < times.length; i++) {
      if (i == 0) {
        entryTime = DateTime.tryParse(
          times[i]['dataHoraPassagem'].toString(),
        )!.subtract(Duration(hours: 6));
        handledEntryTime =
            '${entryTime.hour}:${TneValueHandler.smallNumberToShow(entryTime.minute)}';
      }
      if (i == 1) {
        exitTime = DateTime.tryParse(
          times[i]['dataHoraPassagem'].toString(),
        )!.subtract(Duration(hours: 6));
        handledExitTime =
            '${exitTime.hour}:${TneValueHandler.smallNumberToShow(exitTime.minute)}';
      }
    }
    if (data['aulaRealizada'] != null) {
      didHaveClass = data['aulaRealizada'];
    }
    return FrequencyEntity(
      day: day!,
      entryTime: handledEntryTime,
      exitTime: handledExitTime,
      didHaveClass: didHaveClass,
    );
  }
}
