import 'package:edupilot/models/dtos/choice_dto.dart';

class QuestionDTO {
  final String questionContent;
  final String? questionImage;
  final List<ChoiceDTO> choices;

  QuestionDTO({
    required this.questionContent,
    this.questionImage,
    required this.choices,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    return QuestionDTO(
      questionContent: json['questionContent'],
      questionImage: (json['questionImage'] as String).isEmpty ? null : json['questionImage'],
      choices: (json['choices'] as List<dynamic>)
        .map((e) => ChoiceDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'questionContent': questionContent,
      'questionImage': questionImage,
      'choices': choices,
    };
  }
}