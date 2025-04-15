import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:edupilot/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allQuizzesInLesson = ref.watch(activeQuizzesProvider).where((q) => q.subject.lesson.name == lesson.name).toList();

    return Card(
      child: Column(
        children: [
          for (Quiz quiz in allQuizzesInLesson)
            Row(
              children: [
                Text(quiz.subject.name)
              ],
            )
        ],
      ),
    );
  }
}