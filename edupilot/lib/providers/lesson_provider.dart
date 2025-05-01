import 'package:edupilot/models/quiz/lesson.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'lesson_provider.g.dart';

// dart run build_runner watch

final favLessonsRefreshProvider = StateProvider<bool>((ref) => false);

List<Lesson> allLessons = [
  Lesson(id: '1', name: 'Matematik', icon: Icons.calculate, grade: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]),
  Lesson(id: '2', name: 'Geometri', icon: Icons.architecture, grade: [9, 10, 11, 12]),
  Lesson(id: '3', name: 'Fizik', icon: Icons.engineering, grade: [9, 10, 11, 12]),
  Lesson(id: '4', name: 'Kimya', icon: Icons.science, grade: [9, 10, 11, 12]),
  Lesson(id: '5', name: 'Biyoloji', icon: Icons.biotech, grade: [9, 10, 11, 12]),
  Lesson(id: '6', name: 'Tarih', icon: Icons.history_edu, grade: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]),
  Lesson(id: '7', name: 'Coğrafya', icon: Icons.terrain, grade: [9, 10, 11, 12]),
  Lesson(id: '8', name: 'Felsefe', icon: Icons.psychology_alt, grade: [9, 10, 11, 12]),
  Lesson(id: '9', name: 'Din Kültürü ve Ahlak Bilgisi', icon: Icons.self_improvement, grade: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]),
  Lesson(id: '10', name: 'Türkçe', icon: Icons.menu_book, grade: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]),
  Lesson(id: '11', name: 'İngilizce', icon: Icons.language, grade: [5, 6, 7, 8, 9, 10, 11, 12]),
];

@riverpod
class LessonNotifier extends _$LessonNotifier {

  // inital value
  @override
  Set<Lesson> build() {
    return const {};
  }
}

// generated providers

@riverpod
List<Lesson> lessons(ref) {
  return allLessons;
}

@riverpod
List<Lesson> favLessons(ref) {
  return allLessons.where((l) => l.isFav).toList();
}

@riverpod
List<Lesson> notFavLessons(ref) {
  return allLessons.where((l) => !l.isFav).toList();
}
