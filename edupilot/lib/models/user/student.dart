import 'package:edupilot/models/user/supervisor.dart';
import 'package:edupilot/models/user/user.dart';

class Student {

  Student({
    required this.id,
    required this.user,
    this.institutionName,
    this.supervisor,
  });

  final String id;
  final User user;
  final String? institutionName;
  final Supervisor? supervisor;
}