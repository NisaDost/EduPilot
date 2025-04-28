import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';

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
        id: json['id'] as String,
        name: json['name'] as String,
        icon: json['icon'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
      };

  static fromFavoriteLessonDTO(FavoriteLessonDTO lesson) {
    return LessonsByGradeDTO(
      id: lesson.lessonId,
      name: lesson.lessonName,
      icon: lesson.lessonIcon,
    );
  }
}