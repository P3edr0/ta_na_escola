import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';
import 'package:ta_na_escola/domain/usecases/student/fetch_student_usecase.dart';

class HomeController extends ChangeNotifier {
  HomeController({required this.fetchStudentUsecase});
  final FetchStudentUsecase fetchStudentUsecase;
  List<StudentEntity> students = [];
  StudentEntity? selectedStudent;
  String? exception;

  bool loading = false;
  ////////////// GET
  bool get hasError => exception != null;

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

  void setSelectedStudent(StudentEntity newSelectedStudent) {
    selectedStudent = newSelectedStudent;
    notifyListeners();
  }

  Future<void> fetchStudent({required String token}) async {
    setLoading();

    final response = await fetchStudentUsecase(token: token);
    response.fold(
      (newException) {
        exception = newException.message;
        setLoading();
      },
      (newStudents) {
        students = [...newStudents];
        if (students.isNotEmpty) {
          exception = null;

          setSelectedStudent(students.first);
        } else {
          exception =
              'Você não possui dependentes cadastrados\n Entre em contato com a escola.';
        }
        setLoading();
      },
    );
  }
}
