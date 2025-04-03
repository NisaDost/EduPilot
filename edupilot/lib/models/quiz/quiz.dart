import 'package:edupilot/models/quiz/lesson.dart';

class Quiz {

  // contructor
  Quiz({
    required this.lesson,
    required this.pointPerQuestion,
  });

  // fields
  final Lesson lesson;
  final int pointPerQuestion;
}


