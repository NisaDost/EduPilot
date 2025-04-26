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
            achievementId: json['AchievementId'] as String,
            achievementName: json['AchievementName'] as String,
            achievementIcon: json['AchievementIcon'] as String,
            achievementDescription: json['AchievementDescription'] as String,
        );

    Map<String, dynamic> toJson() => {
          'AchievementId': achievementId,
          'AchievementName': achievementName,
          'AchievementIcon': achievementIcon,
          'AchievementDescription': achievementDescription,
        };
}