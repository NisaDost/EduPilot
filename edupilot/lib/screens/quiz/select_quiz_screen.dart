import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/subject.dart';
import 'package:edupilot/screens/quiz/widgets/quiz_card.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectQuizScreen extends StatefulWidget {
  const SelectQuizScreen({required this.lesson, super.key});

  final Lesson lesson;

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
    const double topBarHeight = 96;

    // Filter subjects related to this lesson
    final lessonSubjects = allSubjects.where((s) => s.lesson.name == widget.lesson.name).toList();
    final subjectNames = ['Tümü'] + lessonSubjects.map((s) => s.name).toList();

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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      dropdownColor: AppColors.primaryAccent,
                      borderRadius: BorderRadius.circular(16),
                      isExpanded: true,
                      items: subjectNames.map((subjectName) {
                        return DropdownMenuItem<String>(
                          value: subjectName,
                          child: StyledHeading(subjectName, AppColors.backgroundColor),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value == 'Tümü' ? null : value;
                        });
                      },
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
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledTitle(
                    widget.lesson.name.length < 12
                        ? widget.lesson.name
                        : widget.lesson.name.substring(0, 11),
                    AppColors.successColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt, color: AppColors.primaryColor, size: 32),
                      StyledHeading('1.205', AppColors.textColor),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Hadi, soru çözüp puan toplayalım!',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.titleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
