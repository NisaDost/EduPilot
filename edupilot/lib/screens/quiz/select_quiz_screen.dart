import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SelectQuizScreen extends StatelessWidget {
  const SelectQuizScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)), 
          ),
          child: Row(
            children: [
              Text(lesson.name)
            ],
          ),
        )
      ],
    );
  }
}