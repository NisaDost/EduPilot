import 'package:flutter/material.dart';

enum Lesson {
  math(
    name: 'Matematik',
    icon: Icons.calculate,
    point: 30
  ),
  geometry(
    name: 'Geometri',
    icon: Icons.architecture,
    point: 25
  ),
  physics(
    name: 'Fizik',
    icon: Icons.engineering,
    point: 25
  ),
  chemistry(
    name: 'Kimya',
    icon: Icons.science,
    point: 25
  ),
  biology(
    name: 'Biyoloji',
    icon: Icons.biotech,
    point: 25
  ),
  history(
    name: 'Tarih',
    icon: Icons.history_edu,
    point: 20
  ),
  geography(
    name: 'Coğrafya',
    icon: Icons.terrain,
    point: 20
  ),
  philosophy(
    name: 'Felsefe',
    icon: Icons.psychology_alt,
    point: 20
  ),
  religion(
    name: 'Din Kültürü ve Ahlak Bilgisi',
    icon: Icons.self_improvement,
    point: 20
  ),  
  turkish(
    name: 'Türkçe',
    icon: Icons.menu_book,
    point: 30
  ),
  english(
    name: 'İngilizce',
    icon: Icons.language,
    point: 20
  );

  const Lesson({
    required this.name,
    required this.icon,
    required this.point,
  });
  
  final String name;
  final IconData? icon;
  final int point;

}
