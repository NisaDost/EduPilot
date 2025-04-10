import 'package:edupilot/models/quiz/lesson.dart';

class Quiz {

  // contructor
  Quiz({
    required this.lesson,
    required this.pointPerQuestion,
    required this.isFav,
  });

  // fields
  final Lesson lesson;
  final int pointPerQuestion;
  final bool isFav;
}


