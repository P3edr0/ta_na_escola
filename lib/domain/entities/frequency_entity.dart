class FrequencyEntity {
  final DateTime day;
  final String? entryTime;
  final String? exitTime;
  final bool didHaveClass;

  FrequencyEntity({
    required this.day,
    this.didHaveClass = false,
    this.entryTime,
    this.exitTime,
  });
}
