import 'package:edupilot/models/dtos/solved_quiz_info_dto.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SolvedQuizCard extends StatefulWidget {
  const SolvedQuizCard({
    this.lessonFilter,
    super.key,
  });

  final String? lessonFilter;

  @override
  State<SolvedQuizCard> createState() => _SolvedQuizCardState();
}

class _SolvedQuizCardState extends State<SolvedQuizCard> {
  Map<String, String> _subjectIdToLessonName = {};
  bool _loadingLessons = true;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    final lessons = await LessonsApiHandler().getLessonsByGrade();
    final mapping = <String, String>{};
    for (final lesson in lessons) {
      final subjects = await LessonsApiHandler().getSubjectsByLessonId(lesson.id);
      for (final subject in subjects) {
        mapping[subject.id] = lesson.name;
      }
    }
    setState(() {
      _subjectIdToLessonName = mapping;
      _loadingLessons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingLessons) {
      return Padding(
        padding: const EdgeInsets.all(16),
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
    }
    return FutureBuilder<List<SolvedQuizInfoDTO>>(
      future: QuizzesApiHandler().getSolvedQuizInfo(),
      builder: (BuildContext context, AsyncSnapshot solvedQuizzesSnapshot) {
        if (solvedQuizzesSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (solvedQuizzesSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${solvedQuizzesSnapshot.error}'));
        } else if (!solvedQuizzesSnapshot.hasData) {
          return const Center(child: Text('Konu bulunamadı.'));
        }

        final List<SolvedQuizInfoDTO> solvedQuizzes = solvedQuizzesSnapshot.data!;
        final filtered = solvedQuizzes.where((solvedQuiz) => widget.lessonFilter == null || _subjectIdToLessonName[solvedQuiz.subjectId] == widget.lessonFilter).toList();

        if (filtered.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 64, color: AppColors.titleColor.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  LargeText('Bu derste henüz çözdüğün bir quiz bulunmuyor.', AppColors.titleColor.withValues(alpha: 0.8), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: filtered.map((solvedQuiz) => _quizCardWidget(context, solvedQuiz)).toList(),
          ),
        );
      },
    );
  }

  Widget _quizCardWidget(BuildContext context, SolvedQuizInfoDTO solvedQuiz) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LargeText(solvedQuiz.subjectName, AppColors.backgroundColor),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallText('Bu quizden ', AppColors.textColor),
              SmallText('${solvedQuiz.earnedPoints}', AppColors.backgroundColor),
              Icon(Icons.bolt, color: AppColors.backgroundColor, size: 16),
              SmallText(' kazandın', AppColors.textColor),
            ],
          ),
          const SizedBox(height: 12),
          _buildLine(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.assignment, size: 24, color: AppColors.backgroundColor),
                            const SizedBox(width: 8),
                            SmallBodyText('${solvedQuiz.totalQuestionCount} Soru', AppColors.textColor),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(Icons.signal_cellular_alt_outlined, size: 24, color: AppColors.backgroundColor),
                            const SizedBox(width: 8),
                            SmallText(
                              solvedQuiz.difficulty.index == 0
                                  ? 'Kolay'
                                  : solvedQuiz.difficulty.index == 1
                                      ? 'Orta'
                                      : 'Zor',
                              AppColors.textColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.check_box, color: AppColors.successColor, size: 24),
                        const SizedBox(width: 8),
                        SmallText('${solvedQuiz.trueCount}/${solvedQuiz.totalQuestionCount}', AppColors.textColor),
                        const SizedBox(width: 16),
                        Icon(Icons.disabled_by_default_rounded, color: AppColors.dangerColor, size: 24),
                        const SizedBox(width: 8),
                        SmallText('${solvedQuiz.falseCount}/${solvedQuiz.totalQuestionCount}', AppColors.textColor),
                        const SizedBox(width: 16),
                        Icon(Icons.indeterminate_check_box, color: AppColors.titleColor, size: 24),
                        const SizedBox(width: 8),
                        SmallText('${solvedQuiz.emptyCount}/${solvedQuiz.totalQuestionCount}', AppColors.textColor),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: LargeText('Detay', AppColors.backgroundColor),
                  ),
                ),
              )
            ],
          )
        ],
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