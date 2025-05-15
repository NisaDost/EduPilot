class QuizResultDTO {
  final int trueCount;
  final int falseCount;
  final int emptyCount;
  final int totalCount;
  final int earnedPoints;

  const QuizResultDTO({
    required this.trueCount,
    required this.falseCount,
    required this.emptyCount,
    required this.totalCount,
    required this.earnedPoints,
  });

  factory QuizResultDTO.fromJson(Map<String, dynamic> json) => QuizResultDTO(
        trueCount: json['trueCount'] as int,
        falseCount: json['falseCount'] as int,
        emptyCount: json['emptyCount'] as int,
        totalCount: json['totalCount'] as int,
        earnedPoints: json['earnedPoints'] as int,
      );
  Map<String, dynamic> toJson() => {
        'trueCount': trueCount,
        'falseCount': falseCount,
        'emptyCount': emptyCount,
        'totalCount': totalCount,
        'earnedPoints': earnedPoints,
      };
}