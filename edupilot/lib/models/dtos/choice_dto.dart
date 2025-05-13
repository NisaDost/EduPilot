class ChoiceDTO {
  final String choiceId;
  final String choiceContent;
  final bool isCorrect;

  ChoiceDTO({
    required this.choiceId,
    required this.choiceContent,
    required this.isCorrect,
  });

  factory ChoiceDTO.fromJson(Map<String, dynamic> json) {
    return ChoiceDTO(
      choiceId: json['choiceId'] as String,
      choiceContent: json['choiceContent'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cchoiceId': choiceId,
      'choiceContent': choiceContent,
      'isCorrect': isCorrect,
    };
  }
}
