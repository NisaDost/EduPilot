import 'package:flutter/material.dart';

class LessonsByGradeDTO {

  final String id;
  final String name;
  final String icon;

  const LessonsByGradeDTO({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory LessonsByGradeDTO.fromJson(Map<String, dynamic> json) =>
      LessonsByGradeDTO(
        id: json['Id'] as String,
        name: json['Name'] as String,
        icon: json['Icon'] as String,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Icon': icon,
      };
}