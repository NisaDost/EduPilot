import 'package:edupilot/models/quiz/lesson.dart';

class Quiz {

  // contructor
  Quiz({
    required this.lesson,
    required this.pointPerQuestion,
    this.isfav,
  });

  // fields
  final Lesson lesson;
  final int pointPerQuestion;
  final bool? isfav;
}


