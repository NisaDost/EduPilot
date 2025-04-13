import 'package:flutter/material.dart';

class Achievement {

  Achievement({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  final String id;
  final String name;
  final IconData? icon;
  final String description;
}