class FrequencyStatsEntity {
  final int presences;
  final int absences;
  final double presencesPercentage;
  final double absencesPercentage;
  final int total;

  FrequencyStatsEntity({
    required this.presences,
    required this.absences,
    required this.presencesPercentage,
    required this.absencesPercentage,
    required this.total,
  });
}
