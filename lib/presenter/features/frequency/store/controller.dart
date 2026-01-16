import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/data_frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/frequency_stats_entity.dart';
import 'package:ta_na_escola/domain/usecases/student/get_frequency_usecase.dart';
import 'package:ta_na_escola/shared/utils/enums/fault_type.dart';
import 'package:ta_na_escola/shared/utils/enums/frequency_menu_type.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

import '../../../../domain/usecases/student/get_filtered_frequency_usecase.dart';

class FrequencyController extends ChangeNotifier {
  FrequencyController({
    required this.getFrequencyUsecase,

    required this.getFilteredFrequencyUsecase,
  });
  final GetFrequencyUsecase getFrequencyUsecase;
  final GetFilteredFrequencyUsecase getFilteredFrequencyUsecase;
  FrequencyEntity? todayFrequency;
  List<FrequencyEntity> latestFrequencies = [];
  List<FrequencyEntity> filteredFrequencies = [];
  FaultType faultType = FaultType.health;
  FrequencyMenuType frequencyMenuType = FrequencyMenuType.latest;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController finalDateController = TextEditingController();
  final TextEditingController faultDateController = TextEditingController();
  final TextEditingController faultJustifyController = TextEditingController();
  FrequencyStatsEntity? frequencyStats;
  bool loading = false;
  bool filterLoading = false;
  String? exception;
  ////////////// GET

  ////////////// FUNCTIONS

  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      loading = newLoading;
      notifyListeners();
      return;
    }
    loading = !loading;
    notifyListeners();
  }

  void setFilterLoading([bool? newLoading]) {
    if (newLoading != null) {
      filterLoading = newLoading;
      notifyListeners();
      return;
    }
    filterLoading = !filterLoading;
    notifyListeners();
  }

  void startPage() {
    todayFrequency = null;
    latestFrequencies = [];
    filteredFrequencies = [];
    faultType = FaultType.health;
    frequencyMenuType = FrequencyMenuType.latest;
    startDateController.clear();
    finalDateController.clear();
    faultDateController.clear();
    faultJustifyController.clear();

    notifyListeners();
  }

  Future<void> getFrequency({required DataFrequencyEntity data}) async {
    setLoading(true);

    final response = await getFrequencyUsecase(data: data);
    response.fold(
      (newException) {
        setLoading();
      },
      (newFrequencies) {
        calculateFrequencyStats(newFrequencies);
        final today = DateTime.now().normalize();
        if (newFrequencies.isNotEmpty) {
          final last = newFrequencies.first.day.normalize();

          if (today.isAtSameMomentAs(last)) {
            todayFrequency = newFrequencies.first;
            if (newFrequencies.length > 1) {
              latestFrequencies = [...newFrequencies.skip(1)];
            } else {
              latestFrequencies.clear();
            }
          } else {
            latestFrequencies = [...newFrequencies];
          }
          setLoading(false);
          return;
        }

        latestFrequencies = [...newFrequencies];
        setLoading(false);
      },
    );
  }

  Future<void> getFilteredFrequency({required DataFrequencyEntity data}) async {
    setFilterLoading();
    final startDate = TneDateFormat.ymd(startDateController.text);
    final finalDate = TneDateFormat.ymd(finalDateController.text);

    if (startDate == null || finalDate == null) {
      exception = 'Insira uma data válida';
      return;
    }
    final handledData = data.copyWith(
      startFilterDate: startDate,
      finalFilterDate: finalDate,
    );
    final response = await getFilteredFrequencyUsecase(data: handledData);
    response.fold(
      (newException) {
        exception = newException.message;
        setFilterLoading();
      },
      (newFrequencies) {
        exception = null;
        filteredFrequencies = [...newFrequencies];
        setFilterLoading();
      },
    );
  }

  void calculateFrequencyStats(List<FrequencyEntity> handledFrequencies) {
    if (handledFrequencies.isEmpty) {
      frequencyStats = FrequencyStatsEntity(
        presences: 0,
        absences: 0,
        presencesPercentage: 0,
        absencesPercentage: 0,
        total: 0,
      );
      notifyListeners();
      return;
    }
    int absents = 0;
    int frequencies = 0;
    double frequenciesPercentage = 0.0;
    double absentsPercentage = 0.0;
    int total = 0;

    for (final item in handledFrequencies) {
      if (item.entryTime == null && item.exitTime == null) {
        absents++;
      }
    }
    total = handledFrequencies.length;
    frequencies = total - absents;

    frequenciesPercentage = frequencies / total;
    absentsPercentage = absents / total;

    frequencyStats = FrequencyStatsEntity(
      presences: frequencies,
      absences: absents,
      presencesPercentage: frequenciesPercentage,
      absencesPercentage: absentsPercentage,
      total: total,
    );
    notifyListeners();
  }

  ////////////// SET
  setFrequencyMenuType() {
    if (frequencyMenuType.isLatest) {
      frequencyMenuType = FrequencyMenuType.custom;
    } else {
      frequencyMenuType = FrequencyMenuType.latest;
    }
    notifyListeners();
  }

  setFaultType(String newFaultType) {
    final handledFaultType = FaultType.translate(newFaultType);
    faultType = handledFaultType;
    notifyListeners();
  }
}
