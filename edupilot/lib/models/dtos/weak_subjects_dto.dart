class WeakSubjectsDTO {
  final String studentId;
  final String subjectId;
  final String subjectName;

  const WeakSubjectsDTO({
    required this.studentId,
    required this.subjectId,
    required this.subjectName
  });

  factory WeakSubjectsDTO.fromJson(Map<String, dynamic> json) => WeakSubjectsDTO(
        studentId: json['studentId'] as String,
        subjectId: json['subjectId'] as String,
        subjectName: json['subjectName'] as String,
  );
  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'subjectId': subjectId,
        'subjectName': subjectName,
      };
}