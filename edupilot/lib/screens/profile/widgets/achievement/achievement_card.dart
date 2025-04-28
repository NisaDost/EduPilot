import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/profile/widgets/achievement/achievement_pop_up.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AchievementCard extends ConsumerStatefulWidget {
  const AchievementCard({
    super.key,
    required this.student,
  });

  final StudentDTO student;

  @override
  ConsumerState<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends ConsumerState<AchievementCard> {
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      itemCount: widget.student.studentAchievements!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.9,
      ), 
      itemBuilder: (context, index) {
        if (widget.student.studentAchievements!.isEmpty) {
          return const Center(child: Text('Henüz bir başarı kazanmadınız.'));
        }
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AchievementPopUp(achievement: widget.student.studentAchievements![index]),
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
                  tag: widget.student.studentAchievements![index].achievementId,
                  child: Icon(IconConversion().getIconFromString(widget.student.studentAchievements![index].achievementIcon), size: 54),
                ),
              ),
              const SizedBox(height: 6),
              XSmallText(widget.student.studentAchievements![index].achievementName, AppColors.primaryAccent),
            ],
          ),
        );

      }
    );
  }
}