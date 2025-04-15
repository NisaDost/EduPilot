import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/screens/quiz/widgets/lesson_card.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectLessonScreen extends StatelessWidget {
  final void Function(Lesson) onLessonTap;

  const SelectLessonScreen({super.key, required this.onLessonTap});

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 96;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: topBarHeight),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LessonCard(onLessonTap: onLessonTap),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledTitle('8. Sınıf', AppColors.successColor),
                  CardTitle('Tüm Dersler Listesi', AppColors.textColor),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Derslere ait quizleri görüntülemek için kartlara tıklayınız.',
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

