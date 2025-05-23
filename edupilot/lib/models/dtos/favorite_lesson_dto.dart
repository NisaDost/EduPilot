import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';

class FavoriteLessonDTO
{
    final String lessonId;
    final String lessonName;
    final String lessonIcon;

    const FavoriteLessonDTO({
        required this.lessonId,
        required this.lessonName,
        required this.lessonIcon,
    });

    factory FavoriteLessonDTO.fromJson(Map<String, dynamic> json) =>
        FavoriteLessonDTO(
          lessonId: json['lessonId']?.toString() ?? '',
          lessonName: json['lessonName']?.toString() ?? '',
          lessonIcon: json['lessonIcon']?.toString() ?? '',
        );


    Map<String, dynamic> toJson() => {
          'lessonId': lessonId,
          'lessonName': lessonName,
          'lessonIcon': lessonIcon,
        };

    static FavoriteLessonDTO fromLessonsByGradeDTO(LessonsByGradeDTO lessons) {
      return FavoriteLessonDTO(
        lessonId: lessons.id,
        lessonName: lessons.name,
        lessonIcon: lessons.icon,
      );
    }
}