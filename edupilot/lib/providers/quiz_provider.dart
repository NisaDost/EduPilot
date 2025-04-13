import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_provider.g.dart';

// dart run build_runner watch

List<Quiz> allQuizzes = [
  Quiz(id: '1', lesson: Lesson.math, pointPerQuestion: Lesson.math.point),
  Quiz(id: '2', lesson: Lesson.geometry, pointPerQuestion: Lesson.geometry.point),
  Quiz(id: '3', lesson: Lesson.physics, pointPerQuestion: Lesson.physics.point),
  Quiz(id: '4', lesson: Lesson.chemistry, pointPerQuestion: Lesson.chemistry.point),
  Quiz(id: '5', lesson: Lesson.biology, pointPerQuestion: Lesson.biology.point),
  Quiz(id: '6', lesson: Lesson.turkish, pointPerQuestion: Lesson.turkish.point),
  Quiz(id: '7', lesson: Lesson.geography, pointPerQuestion: Lesson.geography.point),
  Quiz(id: '8', lesson: Lesson.history, pointPerQuestion: Lesson.history.point),
  Quiz(id: '9', lesson: Lesson.religion, pointPerQuestion: Lesson.religion.point),
  Quiz(id: '10', lesson: Lesson.philosophy, pointPerQuestion: Lesson.philosophy.point),
  Quiz(id: '11', lesson: Lesson.english, pointPerQuestion: Lesson.english.point),
];

@riverpod
class QuizNotifier extends _$QuizNotifier {

  // inital value
  @override
  Set<Quiz> build() {
    return const {};
  }
}

// generated providers

@riverpod
List<Quiz> quizzes(ref) {
  return allQuizzes;
}

@riverpod
List<Quiz> favQuizzes(ref) {
  return allQuizzes.where((q) => q.isFav).toList();
}

@riverpod
List<Quiz> nonFavQuizzes(ref) {
  return allQuizzes.where((q) => !q.isFav).toList();
}