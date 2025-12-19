import '../../domain/entities/student_entity.dart';

class StudentMapper {
  static StudentEntity fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      id: map['idAluno'].toString(),
      guardianId: map['idPessoaAluno'].toString(),
      name: map['nomeAluno'],
      age: map['idade'],
      image: map['imagemAluno'],
      schoolName: map['nomeEscola'],
      schoolImage: map['imagemEscola'],
      schoolYear: map['anoLetivo'].toString(),
    );
  }
}
