class SimulationDTO {
  final String id;
  final String name;
  final int studyDuration;
  final int breakDuration;

  SimulationDTO({
    required this.id,
    required this.name,
    required this.studyDuration,
    required this.breakDuration,
  });

  factory SimulationDTO.fromJson(Map<String, dynamic> json) {
    return SimulationDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      studyDuration: json['studyDuration'] as int,
      breakDuration: json['breakDuration'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studyDuration': studyDuration,
      'breakDuration': breakDuration,
    };
  }
}