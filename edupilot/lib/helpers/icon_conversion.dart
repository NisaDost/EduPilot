import 'package:flutter/material.dart';

class IconConversion {

  getIconFromString(String icon) {
    switch (icon) {
      case 'Icons.calculate':
        return Icons.calculate;
      case 'Icons.science':
        return Icons.science;
      case 'Icons.history':
        return Icons.history;
      case 'Icons.terrain':
        return Icons.terrain;
      case 'Icons.language':
        return Icons.language;
      default:
        return Icons.menu_book_outlined;
    }
  }
}