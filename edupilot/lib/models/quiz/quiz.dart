import 'package:edupilot/models/quiz/difficulty.dart';
import 'package:edupilot/models/quiz/subject.dart';

class Quiz {

  // contructor
  Quiz({
    required this.id,
    required this.subject,
    required this.difficulty,
    required this.pointPerQuestion,
    required this.isActive,
  });

  // fields
  final String id;
  final Subject subject;
  final Difficulty difficulty;
  final int pointPerQuestion;
  final bool isActive;

}