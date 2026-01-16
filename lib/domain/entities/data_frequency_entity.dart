import 'dart:core';

class DataFrequencyEntity {
  final String studentId;
  final String schoolId;
  final String token;
  final String? startFilterDate;
  final String? finalFilterDate;
  final List<int> pages;
  DataFrequencyEntity({
    required this.studentId,
    required this.schoolId,
    required this.token,
    this.startFilterDate,
    this.finalFilterDate,
    required this.pages,
  });

  DataFrequencyEntity copyWith({
    String? studentId,
    String? schoolId,
    String? token,
    String? startFilterDate,
    String? finalFilterDate,
    List<int>? pages,
  }) {
    return DataFrequencyEntity(
      studentId: studentId ?? this.studentId,
      schoolId: schoolId ?? this.schoolId,
      token: token ?? this.token,
      startFilterDate: startFilterDate ?? this.startFilterDate,
      finalFilterDate: finalFilterDate ?? this.finalFilterDate,
      pages: pages ?? this.pages,
    );
  }
}
