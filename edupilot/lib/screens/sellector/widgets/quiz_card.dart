import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/quiz_info_dto.dart';
import 'package:edupilot/models/dtos/subject_dto.dart';
import 'package:edupilot/models/dtos/subject_quiz_dto.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    required this.lesson,
    this.subjectFilter,
    super.key,
  });

  final LessonsByGradeDTO lesson;
  final String? subjectFilter;

  @override
  Widget build(BuildContext context) {

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
                  if (subject.quizzes.isNotEmpty && (subjectFilter == null || subject.name == subjectFilter)) 
                    // if (subjectFilter == null || subject.name == subjectFilter)
                      for (SubjectQuizDTO quiz in subject.quizzes)
                        FutureBuilder<QuizInfoDTO>(
                          future: QuizzesApiHandler().getQuizInfo(quiz.quizId),
                          builder: (context, quizSnapshot) {
                            if (quizSnapshot.connectionState == ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              );
                            } else if (quizSnapshot.hasError) {
                              return Center(child: Text('Hata oluştu: ${quizSnapshot.error}'));
                            } else if (!quizSnapshot.hasData) {
                              return const Center(child: Text('Quiz bulunamadı.'));
                            }
                            final QuizInfoDTO quiz = quizSnapshot.data!;
                            return _quizCardWidget(subject, quiz);
                          },
                        ),
              ],
            ),
        );
      }
    );
  }

  _quizCardWidget(SubjectDTO subject, QuizInfoDTO quiz) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LargeText(subject.name, AppColors.backgroundColor),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SmallText('Bu quizden doğru cevap başına',  AppColors.textColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText('${quiz.pointPerQuestion}', AppColors.backgroundColor),
                  Icon(Icons.bolt, color: AppColors.backgroundColor, size: 16),
                  SmallText('kazanabilirsin!', AppColors.textColor),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          _buildLine(),
          const SizedBox(height: 12),
          
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
                      SmallBodyText('${subject.grade}. Sınıf', AppColors.textColor)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, color: AppColors.backgroundColor, size: 24),
                      const SizedBox(width: 8),
                      SmallText('${quiz.duration} dk', AppColors.textColor)
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
                      SmallText('${quiz.questionCount} soru', AppColors.textColor)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt_outlined, color: AppColors.backgroundColor, size: 24),
                      const SizedBox(width: 8),
                      SmallText(
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
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FilledButton(
                  onPressed: () {}, 
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: LargeText('Başla', AppColors.backgroundColor),
                ),
              )
            ],
          )
        ]
      ),
    );
  }
  Widget _buildLine() {
    return Container(
      width: double.infinity,
      height: 1.15,
      color: AppColors.backgroundColor,
    );
  }
}