import 'package:edupilot/models/difficulty.dart';
import 'package:edupilot/models/dtos/solved_question_dto.dart';

class SolvedQuizDTO {
  final String id;
  final String subjectId;
  final Difficulty difficulty;
  final int pointPerQuestion;
  final int duration;
  final int questionCount;
  final List<SolvedQuestionDTO> questions;

  SolvedQuizDTO({
    required this.id,
    required this.subjectId,
    required this.difficulty,
    required this.pointPerQuestion,
    required this.duration,
    required this.questionCount,
    required this.questions,
  });

  factory SolvedQuizDTO.fromJson(Map<String, dynamic> json) => SolvedQuizDTO(
        id: json['id'] as String,
        subjectId: json['subjectId'] as String,
        difficulty: Difficulty.values[json['difficulty'] as int],
        pointPerQuestion: json['pointPerQuestion'] as int,
        duration: json['duration'] as int,
        questionCount: json['questionCount'] as int,
        questions: (json['questions'] as List<dynamic>)
            .map((e) => SolvedQuestionDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'difficulty': Difficulty.values.indexOf(difficulty),
        'pointPerQuestion': pointPerQuestion,
        'duration': duration,
        'questionCount': questionCount,
        'questions': questions.map((e) => e.toJson()).toList(),
      };
}