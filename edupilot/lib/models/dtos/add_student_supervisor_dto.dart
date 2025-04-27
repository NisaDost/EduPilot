class AddStudentSupervisorDTO {
  final String? supervisorName;
  final int? supervisorUniqueCode;

  const AddStudentSupervisorDTO({
    this.supervisorName,
    this.supervisorUniqueCode,
  });

  factory AddStudentSupervisorDTO.fromJson(Map<String, dynamic> json) =>
      AddStudentSupervisorDTO(
        supervisorName: json['SupervisorName'] as String?,
        supervisorUniqueCode: json['SupervisorUniqueCode'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'SupervisorName': supervisorName,
        'SupervisorUniqueCode': supervisorUniqueCode,
      };
}