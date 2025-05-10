import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class LessonCard extends StatelessWidget {
  final FavoriteLessonDTO lesson;
  final VoidCallback? onTap;

  const LessonCard({
    super.key,
    required this.lesson,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Lesson Icon
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              IconConversion().getIconFromString(lesson.lessonIcon),
              size: 112,
              color: AppColors.backgroundColor,
            ),
          ),

          // Lesson Name & Quiz Points
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LargeBodyText(lesson.lessonName, AppColors.backgroundColor),
                const SizedBox(height: 12),
                SmallBodyText('Quizleri görmek için tıkla.', AppColors.backgroundColor)
              ],
            ),
          ),

          // Right Side Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 53, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                ),
                child: Icon(Icons.arrow_forward_ios, size: 40, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
