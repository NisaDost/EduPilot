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

  Map<String, dynamic> toJson() {
    return {
      'questionContent': questionContent,
      'questionImage': questionImage,
      'choices': choices,
    };
  }

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    return QuestionDTO(
      questionContent: json['questionContent'],
      questionImage: json['questionImage'],
      choices: List<ChoiceDTO>.from(json['choices']),
    );
  }
}