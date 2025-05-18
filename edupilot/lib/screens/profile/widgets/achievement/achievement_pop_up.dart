import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/student_achievement_dto.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';

class AchievementPopUp extends StatelessWidget {
  final StudentAchievementDTO achievement;

  const AchievementPopUp({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondaryAccent,
              radius: 48,
              child: Hero(
                tag: achievement.achievementId,
                child: Icon(
                  IconConversion().getIconFromString(achievement.achievementIcon),
                  color: AppColors.backgroundColor,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: 16),
            LargeBodyText(achievement.achievementName, AppColors.titleColor, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            SmallBodyText(achievement.achievementDescription, AppColors.textColor, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: SmallBodyText('Kapat', AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
