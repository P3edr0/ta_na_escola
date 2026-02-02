import 'dart:core';

class DataAgendaEntity {
  final String studentId;
  final String schoolId;
  final String token;

  final int? month;

  DataAgendaEntity({
    required this.studentId,
    required this.schoolId,
    required this.token,
    this.month,
  });

  DataAgendaEntity copyWith({
    String? studentId,
    String? schoolId,
    String? token,

    int? month,
  }) {
    return DataAgendaEntity(
      studentId: studentId ?? this.studentId,
      schoolId: schoolId ?? this.schoolId,
      token: token ?? this.token,

      month: month ?? this.month,
    );
  }
}
