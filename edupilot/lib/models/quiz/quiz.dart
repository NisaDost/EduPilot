import 'package:edupilot/models/quiz/difficulty.dart';
import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/subject.dart';
import 'package:flutter/material.dart';

class Quiz {

  // contructor
  Quiz({
    required this.id,
    required this.lesson,
    required this.subject,
    required this.description,
    required this.duration,
    required this.questionCount,
    required this.difficulty,
    required this.grade,
    required this.icon
  });

  // fields
  final String id;
  final Lesson lesson;
  final Subject subject;
  final String description;
  final Duration duration;
  final int questionCount;
  final Difficulty difficulty;
  final int grade;
  final Icon icon;
}