import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/quiz_dto.dart';
import 'package:edupilot/models/dtos/subject_dto.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
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

  final LessonsByGradeDTO lesson;
  final String? subjectFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final allQuizzesInLesson = ref.watch(activeQuizzesProvider).where((q) {
    //   final sameLesson = q.subject.lesson.name == lesson.name;
    //   final matchesSubject = subjectFilter == null || q.subject.name == subjectFilter;
    //   return sameLesson && matchesSubject;
    // }).toList();

    return FutureBuilder<List<SubjectDTO>>(
        future: LessonsApiHandler().getSubjectsByLessonId(lesson.id),
        builder: (BuildContext context, AsyncSnapshot subjectSnapshot) {
          if (subjectSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (subjectSnapshot.hasError) {
            return Center(child: Text('Hata oluştu: ${subjectSnapshot.error}'));
          } else if (!subjectSnapshot.hasData) {
            return const Center(child: Text('Konu bulunamadı.'));
          }
          final List<SubjectDTO> subjects = subjectSnapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (SubjectDTO subject in subjects)
                  if (subject.quizzes.isNotEmpty) 
                    // if (subjectFilter == null || subject.name == subjectFilter)
                    FutureBuilder<QuizDTO>(
                      future: QuizzesApiHandler().getQuizzesBySubjectId(subject.id),
                      builder: (context, quizSnapshot) {
                        if (quizSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (quizSnapshot.hasError) {
                          return Center(child: Text('Hata oluştu: ${quizSnapshot.error}'));
                        } else if (!quizSnapshot.hasData) {
                          return const Center(child: Text('Quiz bulunamadı.'));
                        }
                        final QuizDTO quiz = quizSnapshot.data!;
                        return _quizCardWidget(subject, quiz);
                      },
                    ),
              ],
            ),
        );
      }
    );
  }

  _quizCardWidget(SubjectDTO subject, QuizDTO quiz) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeText(subject.name, AppColors.backgroundColor),
          SizedBox(height: 4),
          Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              XSmallText('Bu quizden ${quiz.pointPerQuestion}', AppColors.titleColor),
              Icon(Icons.bolt, color: AppColors.titleColor, size: 16),
              XSmallText('kazanabilirsin!', AppColors.titleColor),
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
                      XSmallText('${subject.grade}. Sınıf', AppColors.textColor)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, color: AppColors.backgroundColor, size: 24),
                      const SizedBox(width: 8),
                      XSmallText('20 dk', AppColors.textColor)
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
                      XSmallText('${quiz.questions.length} soru', AppColors.textColor)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt_outlined, color: AppColors.backgroundColor, size: 24),
                      const SizedBox(width: 8),
                      XSmallText(
                        quiz.difficulty.index == 0 
                        ? 'Kolay' 
                        : quiz.difficulty.index == 1
                          ? 'Orta' 
                          : 'Zor', 
                        AppColors.textColor)
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
                child: LargeText('Başla', AppColors.backgroundColor),
              )
            ],
          )
        ]
      ),
    );
  }
}