import 'package:flutter/material.dart';

enum Lesson {
  math(
    icon: Icon(Icons.calculate)
  ),
  geometry(
    icon: Icon(Icons.architecture)
  ),
  physics(
    icon: Icon(Icons.engineering)
  ),
  chemistry(
    icon: Icon(Icons.science)
  ),
  biology(
    icon: Icon(Icons.biotech)
  ),
  history(
    icon: Icon(Icons.history_edu)
  ),
  geography(
    icon: Icon(Icons.terrain)
  ),
  philosophy(
    icon: Icon(Icons.psychology_alt)
  ),
  religion(
    icon: Icon(Icons.self_improvement)
  ),  
  turkish(
    icon: Icon(Icons.menu_book)
  ),
  english(
    icon: Icon(Icons.language)
  );

  const Lesson({
    required this.icon
  });
  
  final Icon icon;

}
