import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/screens/quiz/widgets/quiz_card.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectQuizScreen extends StatelessWidget {
  const SelectQuizScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 86;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: topBarHeight),
          child: SingleChildScrollView(
            child: Column(
              children: [
                QuizCard(lesson: lesson)
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledTitle(
                    lesson.name.length < 12 
                      ? lesson.name 
                      : lesson.name.substring(0, 11), 
                    AppColors.successColor),
                  SizedBox(height: 8),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.bolt, color: AppColors.primaryColor, size: 32),
                  StyledHeading('1205', AppColors.textColor)
                ],
              )            
            ],
          ),
        ),
      ],
    );
  }
}