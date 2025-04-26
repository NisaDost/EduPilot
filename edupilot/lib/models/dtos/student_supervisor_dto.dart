class StudentSupervisorDTO {
  final String supervisorId;
  final String supervisorName;

  const StudentSupervisorDTO({
    required this.supervisorId,
    required this.supervisorName,
  });

  factory StudentSupervisorDTO.fromJson(Map<String, dynamic> json) =>
      StudentSupervisorDTO(
        supervisorId: json['SupervisorId'] as String,
        supervisorName: json['SupervisorName'] as String,
      );

  Map<String, dynamic> toJson() => {
        'SupervisorId': supervisorId,
        'SupervisorName': supervisorName,
      };
}