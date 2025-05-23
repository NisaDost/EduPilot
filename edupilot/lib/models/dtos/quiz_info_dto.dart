import 'package:edupilot/models/difficulty.dart';

class QuizInfoDTO {
  final String id;
  final String subjectId;
  final Difficulty difficulty;
  final int duration;
  final int pointPerQuestion;
  final bool isActive;
  final int questionCount;

  QuizInfoDTO({
    required this.id,
    required this.subjectId,
    required this.difficulty,
    required this.duration,
    required this.pointPerQuestion,
    required this.isActive,
    required this.questionCount,
  });

  factory QuizInfoDTO.fromJson(Map<String, dynamic> json) => QuizInfoDTO(
        id: json['id'] as String,
        subjectId: json['subjectId'] as String,
        difficulty: Difficulty.values[json['difficulty'] as int],
        duration: json['duration'] as int,
        pointPerQuestion: json['pointPerQuestion'] as int,
        isActive: json['isActive'] as bool,
        questionCount: json['questionCount'] as int,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'difficulty': Difficulty.values.indexOf(difficulty),
        'duration': duration,
        'pointPerQuestion': pointPerQuestion,
        'isActive': isActive,
        'questionCount': questionCount,
      };
}