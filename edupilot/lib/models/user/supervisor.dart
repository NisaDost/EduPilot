import 'package:edupilot/models/user/student.dart';

class Supervisor {
  Supervisor({
    required this.id,
    this.institutionName,
    this.student,
  });

  final String id;
  final String? institutionName;
  final List<Student>? student;
}