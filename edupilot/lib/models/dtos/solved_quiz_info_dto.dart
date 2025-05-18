import 'package:edupilot/models/difficulty.dart';

class SolvedQuizInfoDTO {
  final String quizId;
  final String subjectId;
  final String subjectName;
  final Difficulty difficulty;
  final int trueCount;
  final int falseCount;
  final int emptyCount;
  final int totalQuestionCount;
  final int earnedPoints;
  final int duration;
  final DateTime solvedDate;

  SolvedQuizInfoDTO({
    required this.quizId,
    required this.subjectId,
    required this.subjectName,
    required this.difficulty,
    required this.trueCount,
    required this.falseCount,
    required this.emptyCount,
    required this.totalQuestionCount,
    required this.earnedPoints,
    required this.duration,
    required this.solvedDate,
  });

  factory SolvedQuizInfoDTO.fromJson(Map<String, dynamic> json) => SolvedQuizInfoDTO(
        quizId: json['quizId'] as String,
        subjectId: json['subjectId'] as String,
        subjectName: json['subjectName'] as String,
        difficulty: Difficulty.values[json['difficulty'] as int],
        trueCount: json['trueCount'] as int,
        falseCount: json['falseCount'] as int,
        emptyCount: json['emptyCount'] as int,
        totalQuestionCount: json['totalQuestionCount'] as int,
        earnedPoints: json['earnedPoints'] as int,
        duration: json['duration'] as int,
        solvedDate: DateTime.parse(json['solvedDate']),
      );
  Map<String, dynamic> toJson() => {
        'quizId': quizId,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'difficulty': Difficulty.values.indexOf(difficulty),
        'trueCount': trueCount,
        'falseCount': falseCount,
        'emptyCount': emptyCount,
        'totalQuestionCount': totalQuestionCount,
        'earnedPoints': earnedPoints,
        'duration': duration,
        'solvedDate': solvedDate,
      };
}