import 'package:flutter/material.dart';

enum Lesson {
  math(
    icon: Icons.calculate
  ),
  geometry(
    icon: Icons.architecture
  ),
  physics(
    icon: Icons.engineering
  ),
  chemistry(
    icon: Icons.science
  ),
  biology(
    icon: Icons.biotech
  ),
  history(
    icon: Icons.history_edu
  ),
  geography(
    icon: Icons.terrain
  ),
  philosophy(
    icon: Icons.psychology_alt
  ),
  religion(
    icon: Icons.self_improvement
  ),  
  turkish(
    icon: Icons.menu_book
  ),
  english(
    icon: Icons.language
  );

  const Lesson({
    required this.icon
  });
  
  final IconData? icon;

}
