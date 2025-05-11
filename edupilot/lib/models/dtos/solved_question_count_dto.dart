class SolvedQuestionCountDTO {
  final String id;
  final String studentId;
  final String lessonId;
  final String lessonName;
  final int count;
  final DateTime entryDate;
  final DateTime startOfWeek;
  final DateTime endOfWeek;

  SolvedQuestionCountDTO({
    required this.id,
    required this.studentId,
    required this.lessonId,
    required this.lessonName,
    required this.count,
    required this.entryDate,
    required this.startOfWeek,
    required this.endOfWeek
  });

  factory SolvedQuestionCountDTO.fromJson(Map<String, dynamic> json) {
    return SolvedQuestionCountDTO(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      lessonId: json['lessonId'] as String,
      lessonName: json['lessonName'] as String,
      count: json['count'] as int,
      entryDate: DateTime.parse(json['entryDate']),
      startOfWeek: DateTime.parse(json['startOfWeek']),
      endOfWeek: DateTime.parse(json['endOfWeek']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'lessonId': lessonId,
      'lessonName': lessonName,
      'count': count,
    'entryDate': entryDate.toIso8601String(),
    'startOfWeek': startOfWeek.toIso8601String(),
    'endOfWeek': endOfWeek.toIso8601String(),
    };
  }
}