import 'package:edupilot/models/dtos/supervisor_students_info_dto.dart';

class SupervisorInfoDTO {
  final List<SupervisorStudentsInfoDTO>? students;
  final String? institutionId;
  final String? institutionName;

  const SupervisorInfoDTO({
    this.students,
    this.institutionId,
    this.institutionName
  });

  factory SupervisorInfoDTO.fromJson(Map<String, dynamic> json) => SupervisorInfoDTO(
        students: (json['students'] as List<dynamic>?)
            ?.map((e) => SupervisorStudentsInfoDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
        institutionId: json['institutionId'] as String?,
        institutionName: json['institutionName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'students': students?.map((e) => e.toJson()).toList(),
        'institutionId': institutionId,
        'institutionName': institutionName,
      };
}