import 'package:edupilot/models/dtos/subject_quiz_dto.dart';

class SubjectDTO{
  final String id;
  final String lessonId;
  final String name;
  final int grade;
  final List<SubjectQuizDTO> quizzes;

  SubjectDTO({
    required this.id,
    required this.lessonId,
    required this.name,
    required this.grade,
    required this.quizzes,
  });

  factory SubjectDTO.fromJson(Map<String, dynamic> json) => SubjectDTO(
        id: json['id'] as String,
        lessonId: json['lessonId'] as String,
        name: json['name'] as String,
        grade: json['grade'] as int,
        quizzes: (json['quizzes'] as List<dynamic>)
            .map((e) => SubjectQuizDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lessonId': lessonId,
        'name': name,
        'grade': grade,
        'quizzes': quizzes.map((e) => e.toJson()).toList(),
      };
}