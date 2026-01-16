import '../../domain/entities/student_entity.dart';

class StudentMapper {
  static StudentEntity fromMap(Map<String, dynamic> data) {
    return StudentEntity(
      id: data['idAluno'].toString(),
      guardianId: data['idPessoaAluno'].toString(),
      name: data['nomeAluno'],
      age: data['idade'],
      image: data['imagemAluno'],
      schoolName: data['nomeEscola'],
      schoolId: data['idEscola'].toString(),
      schoolImage: data['imagemEscola'],
      schoolYear: data['anoLetivo'].toString(),
    );
  }
}
