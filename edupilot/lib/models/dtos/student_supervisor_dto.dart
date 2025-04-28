class StudentSupervisorDTO {
  final String supervisorId;
  final String supervisorName;

  const StudentSupervisorDTO({
    required this.supervisorId,
    required this.supervisorName,
  });

  factory StudentSupervisorDTO.fromJson(Map<String, dynamic> json) =>
      StudentSupervisorDTO(
        supervisorId: json['supervisorId'] as String,
        supervisorName: json['supervisorName'] as String,
      );

  Map<String, dynamic> toJson() => {
        'supervisorId': supervisorId,
        'supervisorName': supervisorName,
      };
}