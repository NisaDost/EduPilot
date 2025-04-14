import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavLessonCard extends ConsumerWidget {
  const FavLessonCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(favLessonsProvider);

    return Row(
      children: List.generate(lessons.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 170),
                child: Card(
                  color: AppColors.secondaryAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(lessons[index].icon, size: 96, color: AppColors.backgroundColor),
                        CardTitle(lessons[index].name, AppColors.backgroundColor)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Heart(lesson: lessons[index], defaultColor: AppColors.backgroundColor),
              ),
            ],
          ),
        );
      }),
    );
  }
}
