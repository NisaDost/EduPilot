class SupervisorStudentsInfoDTO {
  final String studentId;
  final String studentFirstName;
  final String? studentMiddleName;
  final String studentLastName;
  final int studentGrade;

  const SupervisorStudentsInfoDTO({
    required this.studentId,
    required this.studentFirstName,
    this.studentMiddleName,
    required this.studentLastName,
    required this.studentGrade
  });

  factory SupervisorStudentsInfoDTO.fromJson(Map<String, dynamic> json) => SupervisorStudentsInfoDTO(
        studentId: json['studentId'] as String,
        studentFirstName: json['studentFirstName'] as String,
        studentMiddleName: (json['studentMiddleName']) as String?,
        studentLastName: json['studentLastName'] as String,
        studentGrade: json['studentGrade'] as int,
      );

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'studentFirstName': studentFirstName,
        'studentMiddleName': studentMiddleName,
        'studentLastName': studentLastName,
        'studentGrade': studentGrade,
      };
}