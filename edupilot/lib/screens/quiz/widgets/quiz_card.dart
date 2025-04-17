import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:edupilot/providers/quiz_provider.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard({
    required this.lesson,
    this.subjectFilter,
    super.key,
  });

  final Lesson lesson;
  final String? subjectFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allQuizzesInLesson = ref.watch(activeQuizzesProvider).where((q) {
      final sameLesson = q.subject.lesson.name == lesson.name;
      final matchesSubject = subjectFilter == null || q.subject.name == subjectFilter;
      return sameLesson && matchesSubject;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (Quiz quiz in allQuizzesInLesson)
            Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledHeading(quiz.subject.name, AppColors.backgroundColor),
                  SizedBox(height: 4),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      CardText('Bu quizden ${quiz.pointPerQuestion}', AppColors.titleColor),
                      Icon(Icons.bolt, color: AppColors.titleColor, size: 16),
                      CardText('kazanabilirsin!', AppColors.titleColor),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // sınıf - süre
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.school,color: AppColors.backgroundColor, size: 24),
                              const SizedBox(width: 8),
                              CardText('8. Sınıf', AppColors.textColor)
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.timer, color: AppColors.backgroundColor, size: 24),
                              const SizedBox(width: 8),
                              CardText('20 dk', AppColors.textColor)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 24),
                      // soru sayısı - zorluk
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.assignment, color: AppColors.backgroundColor, size: 24),
                              const SizedBox(width: 8),
                              CardText('25 soru', AppColors.textColor)
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.signal_cellular_alt_outlined, color: AppColors.backgroundColor, size: 24),
                              const SizedBox(width: 8),
                              CardText(quiz.difficulty.name, AppColors.textColor)
                            ],
                          )
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      // başla tuşu
                      FilledButton(
                        onPressed: () {}, 
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor
                        ),
                        child: StyledHeading('Başla', AppColors.backgroundColor),
                      )
                    ],
                  )
                ]
              ),
            ),
        ],
      ),
    );
  }
}