import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_provider.g.dart';

List<Quiz> allQuizzes = [
  Quiz(lesson: Lesson.math, pointPerQuestion: Lesson.math.point, isfav: true),
  Quiz(lesson: Lesson.geometry, pointPerQuestion: Lesson.geometry.point),
  Quiz(lesson: Lesson.physics, pointPerQuestion: Lesson.physics.point, isfav: true),
  Quiz(lesson: Lesson.chemistry, pointPerQuestion: Lesson.chemistry.point),
  Quiz(lesson: Lesson.biology, pointPerQuestion: Lesson.biology.point),
  Quiz(lesson: Lesson.turkish, pointPerQuestion: Lesson.turkish.point),
  Quiz(lesson: Lesson.geography, pointPerQuestion: Lesson.geography.point),
  Quiz(lesson: Lesson.history, pointPerQuestion: Lesson.history.point, isfav: true),
  Quiz(lesson: Lesson.religion, pointPerQuestion: Lesson.religion.point),
  Quiz(lesson: Lesson.philosophy, pointPerQuestion: Lesson.philosophy.point),
  Quiz(lesson: Lesson.english, pointPerQuestion: Lesson.english.point),
];

// generated providers
@riverpod
List<Quiz> quizzes(ref) {
  return allQuizzes;
}