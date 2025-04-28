class StudentAchievementDTO
{
    final String achievementId;
    final String achievementName;
    final String achievementIcon;
    final String achievementDescription;

    const StudentAchievementDTO({
        required this.achievementId,
        required this.achievementName,
        required this.achievementIcon,
        required this.achievementDescription,
    });

    factory StudentAchievementDTO.fromJson(Map<String, dynamic> json) =>
        StudentAchievementDTO(
            achievementId: json['achievementId'] as String,
            achievementName: json['achievementName'] as String,
            achievementIcon: json['achievementIcon'] as String,
            achievementDescription: json['achievementDescription'] as String,
        );

    Map<String, dynamic> toJson() => {
          'achievementId': achievementId,
          'achievementName': achievementName,
          'achievementIcon': achievementIcon,
          'achievementDescription': achievementDescription,
        };
}