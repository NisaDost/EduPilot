import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/screens/analysys/widgets/solved_quiz_card.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuizAnalysysScreen extends StatefulWidget {
  const QuizAnalysysScreen({super.key});

  @override
  State<QuizAnalysysScreen> createState() => _SelectQuizScreenState();
}

class _SelectQuizScreenState extends State<QuizAnalysysScreen> {
  String? selectedLesson; // null = all subjects

  @override
  void didUpdateWidget(covariant QuizAnalysysScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the filter if the lesson changes
    // if (oldWidget.lesson.name != widget.lesson.name) {
      setState(() {
        selectedLesson = null;
      });
    //}
  }

  @override
  Widget build(BuildContext context) {
    // Get all subjects from the lesson
    return FutureBuilder<List<LessonsByGradeDTO>>(
      future: LessonsApiHandler().getLessonsByGrade(),
      builder: (BuildContext context, AsyncSnapshot lessonSnapshot) {
        if (lessonSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ));
        } else if (lessonSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${lessonSnapshot.error}'));
        } else if (!lessonSnapshot.hasData) {
          return const Center(child: Text('Ders bulunamadı.'));
        }
        final List<LessonsByGradeDTO> lessons = lessonSnapshot.data!;

        const double topBarHeight = 90;

        // Filter subjects related to this lesson
        final lessonNames = ['Tümü'] + lessons.map((s) => s.name).toList();

        // Defensive fallback in case selectedSubject no longer exists
        final String dropdownValue = lessonNames.contains(selectedLesson) ? selectedLesson ?? 'Tümü' : 'Tümü';

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: topBarHeight),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                      child: IntrinsicHeight(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryAccent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down, size: 40, color: AppColors.backgroundColor),
                              dropdownColor: AppColors.primaryAccent,
                              borderRadius: BorderRadius.circular(16),
                              isExpanded: true,
                              alignment: Alignment.center,
                              iconEnabledColor: AppColors.backgroundColor,
                              onChanged: (value) {
                                setState(() {
                                  selectedLesson = value == 'Tümü' ? null : value;
                                });
                              },
                              // CLOSED view rendering
                              selectedItemBuilder: (context) {
                                return lessonNames.map((lessonName) {
                                  return ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 24, maxHeight: 96),
                                    child: Center(
                                      child: LargeText(
                                        lessonName,
                                        AppColors.backgroundColor,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              // OPENED dropdown items
                              items: lessonNames.map((lessonName) {
                                return DropdownMenuItem<String>(
                                  value: lessonName,
                                  alignment: Alignment.centerLeft,
                                  child: LargeText(
                                    lessonName,
                                    AppColors.backgroundColor,
                                    textAlign: TextAlign.start,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: SolvedQuizCard(
                        key: ValueKey(selectedLesson ?? 'all'),
                        lessonFilter: selectedLesson,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: topBarHeight,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeBodyText('Analiz Ekranı' ,AppColors.successColor),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: AppColors.primaryColor, size: 32),
                          FutureBuilder<int>(
                            future: StudentsApiHandler().getLoggedInStudent().then((student) => student.points),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: LoadingAnimationWidget.flickr(
                                  leftDotColor: AppColors.primaryColor,
                                  rightDotColor: AppColors.secondaryColor,
                                  size: 18,
                                  ));
                              } else if (snapshot.hasError) {
                                return Text('Hata: ${snapshot.error}');
                              } else if (!snapshot.hasData) {
                                return Text('0', style: TextStyle(color: AppColors.textColor));
                              }
                              final int points = snapshot.data!;
                              return LargeText(points.toString(), AppColors.textColor);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SmallText('Hatalarımızı inceleyip gelişelim!',  AppColors.titleColor),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
