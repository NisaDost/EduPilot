import 'package:flutter/material.dart';
class Lesson {

  // contructor
  Lesson({
    required this.id,
    required this.name,
    required this.icon,
    // required this.subject
    // required this.grade
  });

  // fields
  final String id;
  final String name;
  final IconData? icon;
  // final List<Subject> subject;
  // final List<int> grade;
  bool _isFav = false;

  // getters
  bool get isFav => _isFav;

  // methods
  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
