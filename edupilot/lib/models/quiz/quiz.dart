import 'package:edupilot/models/quiz/lesson.dart';

class Quiz {

  // contructor
  Quiz({
    required this.id,
    required this.lesson,
    required this.pointPerQuestion,
  });

  // fields
  final String id;
  final Lesson lesson;
  final int pointPerQuestion;
  bool _isFav = false;

  // getters
  bool get isFav => _isFav;

  // methods
  void toggleIsFav() {
    _isFav = !_isFav;
  }
}


