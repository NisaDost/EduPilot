import 'package:flutter/material.dart';
import 'package:edupilot/models/achievement/achievement.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';

class AchievementPopUp extends StatelessWidget {
  final Achievement achievement;

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
              backgroundColor: AppColors.primaryAccent,
              radius: 48,
              child: Hero(
                tag: achievement.id,
                child: Icon(
                  achievement.icon,
                  color: AppColors.backgroundColor,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: 16),
            LargeBodyText(achievement.name, AppColors.titleColor),
            const SizedBox(height: 8),
            XSmallBodyText(achievement.description, AppColors.textColor),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: XSmallBodyText('Kapat', AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
