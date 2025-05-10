import 'package:edupilot/models/difficulty.dart';
import 'package:edupilot/models/dtos/question_dto.dart';

class QuizDTO {
  final String subjectId;
  final Difficulty difficulty;
  final int pointPerQuestion;
  final int duration;
  final List<QuestionDTO> questions;

  QuizDTO({
    required this.subjectId,
    required this.difficulty,
    required this.pointPerQuestion,
    required this.duration,
    required this.questions,
  });

  factory QuizDTO.fromJson(Map<String, dynamic> json) => QuizDTO(
        subjectId: json['subjectId'] as String,
        difficulty: Difficulty.values[json['difficulty'] as int],
        pointPerQuestion: json['pointPerQuestion'] as int,
        duration: json['duration'] as int,
        questions: (json['questions'] as List<dynamic>)
            .map((e) => QuestionDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'subjectId': subjectId,
        'difficulty': Difficulty.values.indexOf(difficulty),
        'pointPerQuestion': pointPerQuestion,
        'duration': duration,
        'questions': questions.map((e) => e.toJson()).toList(),
      };
}