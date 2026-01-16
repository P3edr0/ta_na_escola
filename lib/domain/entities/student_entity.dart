class StudentEntity {
  final String id;
  final String guardianId;

  final String name;
  final String? schoolYear;
  final String? schoolId;
  final int age;
  final String? image;
  final String? schoolName;
  final String? schoolImage;
  StudentEntity({
    required this.id,
    required this.guardianId,
    required this.name,
    required this.age,
    this.image,
    this.schoolId,
    required this.schoolName,
    this.schoolYear,
    this.schoolImage,
  });
}
