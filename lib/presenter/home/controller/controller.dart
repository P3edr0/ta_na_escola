import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';
import 'package:ta_na_escola/domain/usecases/student/fetch_student_usecase.dart';

class HomeController extends ChangeNotifier {
  HomeController({required this.fetchStudentUsecase});
  final FetchStudentUsecase fetchStudentUsecase;
  List<StudentEntity> students = [];
  StudentEntity? selectedStudent;

  bool loading = false;
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

  void setSelectedStudent(StudentEntity newSelectedStudent) {
    selectedStudent = newSelectedStudent;
    notifyListeners();
  }

  Future<void> fetchStudent({required String token}) async {
    setLoading();

    final response = await fetchStudentUsecase(token: token);
    response.fold(
      (newException) {
        setLoading();
      },
      (newStudents) {
        students = [...newStudents];
        setSelectedStudent(students.first);
        setLoading();
      },
    );
  }
}
