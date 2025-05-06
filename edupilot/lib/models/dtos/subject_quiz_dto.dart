class SubjectQuizDTO {
  final String subjectId;
  final String quizId;

  const SubjectQuizDTO({
    required this.subjectId,
    required this.quizId,
  });

  factory SubjectQuizDTO.fromJson(Map<String, dynamic> json) {
    return SubjectQuizDTO(
      subjectId: json['subjectId'] as String,
      quizId: json['quizId'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'quizId': quizId,
    };
  }
}