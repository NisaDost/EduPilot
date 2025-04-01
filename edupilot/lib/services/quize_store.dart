import 'package:edupilot/models/quiz/quiz.dart';
import 'package:flutter/material.dart';

class QuizeStore extends ChangeNotifier {
  final List<Quiz> _quizes = [];

  get quizes => _quizes;
}