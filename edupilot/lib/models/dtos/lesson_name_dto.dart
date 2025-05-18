class LessonNameDTO {
  final String lessonId;
  final String lessonName;

  const LessonNameDTO({
    required this.lessonId,
    required this.lessonName,
  });

  factory LessonNameDTO.fromJson(Map<String, dynamic> json) =>
      LessonNameDTO(
        lessonId: json['lessonId'] as String,
        lessonName: json['lessonName'] as String,
      );

  Map<String, dynamic> toJson() => {
        'lessonId': lessonId,
        'lessonName': lessonName,
      };
}