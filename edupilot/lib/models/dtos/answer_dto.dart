class AnswerDTO {
  final String questionId;
  final String? choiceId;

  const AnswerDTO({
    required this.questionId,
    required this.choiceId
  });

  factory AnswerDTO.fromJson(Map<String, dynamic> json) {
    return AnswerDTO(
      questionId: json['questionId'] as String,
      choiceId: json['choiceId'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'choiceId': choiceId,
    };
  }
}