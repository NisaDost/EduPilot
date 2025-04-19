import 'package:edupilot/models/user/student.dart';

class Supervisor {
  Supervisor({
    required this.id,
    this.institutionName,
    this.student,
  });

  final String id;
  String? institutionName;
  List<Student>? student;
}