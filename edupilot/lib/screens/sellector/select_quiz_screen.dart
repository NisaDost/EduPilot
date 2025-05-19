import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/subject_dto.dart';
import 'package:edupilot/screens/sellector/widgets/quiz_card.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectQuizScreen extends StatefulWidget {
  const SelectQuizScreen({required this.lesson, super.key});

  final LessonsByGradeDTO lesson;

  @override
  State<SelectQuizScreen> createState() => _SelectQuizScreenState();
}

class _SelectQuizScreenState extends State<SelectQuizScreen> {
  String? selectedSubject; // null = all subjects

  @override
  void didUpdateWidget(covariant SelectQuizScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the filter if the lesson changes
    if (oldWidget.lesson.name != widget.lesson.name) {
      setState(() {
        selectedSubject = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get all subjects from the lesson
    return FutureBuilder<List<SubjectDTO>>(
      future: LessonsApiHandler().getSubjectsByLessonId(widget.lesson.id),
      builder: (BuildContext context, AsyncSnapshot subjectSnapshot) {
        if (subjectSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ));
        } else if (subjectSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${subjectSnapshot.error}'));
        } else if (!subjectSnapshot.hasData) {
          return const Center(child: Text('Konu bulunamadı.'));
        }
        final List<SubjectDTO> subjects = subjectSnapshot.data!;

        const double topBarHeight = 90;

        // Filter subjects related to this lesson
        final subjectNames = ['Tümü'] + subjects.map((s) => s.name).toList();

        // Defensive fallback in case selectedSubject no longer exists
        final String dropdownValue = subjectNames.contains(selectedSubject) ? selectedSubject ?? 'Tümü' : 'Tümü';

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
                                  selectedSubject = value == 'Tümü' ? null : value;
                                });
                              },
                              // CLOSED view rendering
                              selectedItemBuilder: (context) {
                                return subjectNames.map((subjectName) {
                                  return ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 24, maxHeight: 96),
                                    child: Center(
                                      child: LargeText(
                                        subjectName,
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
                              items: subjectNames.map((subjectName) {
                                return DropdownMenuItem<String>(
                                  value: subjectName,
                                  alignment: Alignment.centerLeft,
                                  child: LargeText(
                                    subjectName,
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
                      child: QuizCard(
                        key: ValueKey(selectedSubject ?? 'all'),
                        lesson: widget.lesson,
                        subjectFilter: selectedSubject,
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
                  boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeBodyText(
                        widget.lesson.name.length < 12
                            ? widget.lesson.name
                            : widget.lesson.name.substring(0, 11),
                        AppColors.successColor,
                      ),
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
                                  size: 72,
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
                  SmallText('Hadi, soru çözüp puan toplayalım!',  AppColors.titleColor),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
