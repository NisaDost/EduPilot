class AddStudentSupervisorDTO {
  final String? supervisorName;
  final int? supervisorUniqueCode;

  const AddStudentSupervisorDTO({
    this.supervisorName,
    this.supervisorUniqueCode,
  });

  factory AddStudentSupervisorDTO.fromJson(Map<String, dynamic> json) =>
      AddStudentSupervisorDTO(
        supervisorName: json['supervisorName'] as String?,
        supervisorUniqueCode: json['supervisorUniqueCode'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'supervisorName': supervisorName,
        'supervisorUniqueCode': supervisorUniqueCode,
      };
}