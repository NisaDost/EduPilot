import 'package:edupilot/providers/achievement_provider.dart';
import 'package:edupilot/screens/profile/widgets/achievement/achievement_pop_up.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AchievementCard extends ConsumerStatefulWidget {
  const AchievementCard({super.key});

  @override
  ConsumerState<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends ConsumerState<AchievementCard> {
  @override
  Widget build(BuildContext context) {
  final achievements = ref.watch(achievementsProvider);

    return GridView.builder(
      itemCount: achievements.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.9,
      ), 
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AchievementPopUp(achievement: achievements[index]),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryAccent,
                foregroundColor: AppColors.backgroundColor,
                radius: 36,
                child: Hero(
                  tag: achievements[index].id,
                  child: Icon(achievements[index].icon, size: 54),
                ),
              ),
              const SizedBox(height: 6),
              XSmallText(achievements[index].name, AppColors.primaryAccent),
            ],
          ),
        );

      }
    );
  }
}