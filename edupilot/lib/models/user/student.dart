import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/user/supervisor.dart';
import 'package:edupilot/models/user/user.dart';

class Student {

  Student({
    required this.id,
    required this.user,
    this.favLessons,
    this.institutionName,
    this.supervisor,
    required this.point,
  });

  final String id;
  final User user;
  List<Lesson>? favLessons;
  String? institutionName;
  List<Supervisor>? supervisor;
  int point = 0;
}