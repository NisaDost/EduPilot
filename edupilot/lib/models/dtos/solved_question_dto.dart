import 'package:edupilot/models/dtos/choice_dto.dart';

class SolvedQuestionDTO {
  final String questionContent;
  final String? questionImage;
  final String? selectedChoiceId;
  final List<ChoiceDTO> choices;

  SolvedQuestionDTO({
    required this.questionContent,
    this.questionImage,
    this.selectedChoiceId,
    required this.choices,
  });

  factory SolvedQuestionDTO.fromJson(Map<String, dynamic> json) {
    return SolvedQuestionDTO(
      questionContent: json['questionContent'] as String,
      questionImage: json['questionImage'] as String,
      selectedChoiceId: json['selectedChoiceId'] as String,
      choices: (json['choices'] as List<dynamic>)
        .map((e) => ChoiceDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'questionContent': questionContent,
      'questionImage': questionImage,
      'selectedChoiceId': selectedChoiceId,
      'choices': choices,
    };
  }
}