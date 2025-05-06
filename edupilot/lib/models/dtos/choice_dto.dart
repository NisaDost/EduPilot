class ChoiceDTO {
  final String choiceContent;
  final bool isCorrect;

  ChoiceDTO({
    required this.choiceContent,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return {
      'choiceContent': choiceContent,
      'isCorrect': isCorrect,
    };
  }
  factory ChoiceDTO.fromJson(Map<String, dynamic> json) {
    return ChoiceDTO(
      choiceContent: json['choiceContent'],
      isCorrect: json['isCorrect'],
    );
  }
}
