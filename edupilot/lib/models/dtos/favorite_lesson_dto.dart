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
            lessonId: json['LessonId'] as String,
            lessonName: json['LessonName'] as String,
            lessonIcon: json['LessonIcon'] as String,
        );

    Map<String, dynamic> toJson() => {
          'LessonId': lessonId,
          'LessonName': lessonName,
          'LessonIcon': lessonIcon,
        };
}