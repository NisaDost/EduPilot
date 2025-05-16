import 'package:edupilot/models/dtos/choice_dto.dart';

class QuestionDTO {
  final String questionId;
  final String questionContent;
  final String? questionImage;
  final List<ChoiceDTO> choices;

  QuestionDTO({
    required this.questionId,
    required this.questionContent,
    this.questionImage,
    required this.choices,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    return QuestionDTO(
      questionId: json['questionId'] as String,
      questionContent: json['questionContent'] as String,
      questionImage: (json['questionImage'] as String).isEmpty ? null : json['questionImage'],
      choices: (json['choices'] as List<dynamic>)
        .map((e) => ChoiceDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionContent': questionContent,
      'questionImage': questionImage,
      'choices': choices,
    };
  }
}