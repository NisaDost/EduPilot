import 'package:flutter/material.dart';

class IconConversion {

  getIconFromString(String icon) {
    switch (icon) {
      case 'Icons.calculate':
        return Icons.calculate;
      case 'Icons.science':
        return Icons.science;
      case 'Icons.history_edu':
        return Icons.history_edu;
      case 'Icons.terrain':
        return Icons.terrain;
      case 'Icons.language':
        return Icons.language;
      case 'Icons.engineering':
        return Icons.engineering;
      case 'Icons.self_improvement':
        return Icons.self_improvement;
      case 'Icons.menu_book':
        return Icons.menu_book;
      case 'Icons.architecture':
        return Icons.architecture;
      case 'Icons.biotech':
        return Icons.biotech;
      case 'Icons.psychology_alt':
        return Icons.psychology_alt;
      case 'Icons.military_tech=outlined':
        return Icons.military_tech_outlined;
      case 'Icons.stars_outlined':
        return Icons.stars_outlined;
      case 'Icons.emoji_events':
        return Icons.emoji_events;
      default:
        return Icons.menu_book_outlined;
    }
  }
}