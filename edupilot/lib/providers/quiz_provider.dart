import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_provider.g.dart';

List<Quiz> allQuizzes = [
  Quiz(lesson: Lesson.math, pointPerQuestion: Lesson.math.point, isFav: true),
  Quiz(lesson: Lesson.geometry, pointPerQuestion: Lesson.geometry.point, isFav: true),
  Quiz(lesson: Lesson.physics, pointPerQuestion: Lesson.physics.point, isFav: false),
  Quiz(lesson: Lesson.chemistry, pointPerQuestion: Lesson.chemistry.point, isFav: true),
  Quiz(lesson: Lesson.biology, pointPerQuestion: Lesson.biology.point, isFav: false),
  Quiz(lesson: Lesson.turkish, pointPerQuestion: Lesson.turkish.point, isFav: false),
  Quiz(lesson: Lesson.geography, pointPerQuestion: Lesson.geography.point, isFav: true),
  Quiz(lesson: Lesson.history, pointPerQuestion: Lesson.history.point, isFav: false),
  Quiz(lesson: Lesson.religion, pointPerQuestion: Lesson.religion.point, isFav: false),
  Quiz(lesson: Lesson.philosophy, pointPerQuestion: Lesson.philosophy.point, isFav: true),
  Quiz(lesson: Lesson.english, pointPerQuestion: Lesson.english.point, isFav: false),
];

// generated providers
@riverpod
List<Quiz> quizzes(ref) {
  return allQuizzes;
}