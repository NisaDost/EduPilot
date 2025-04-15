import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonCard extends ConsumerWidget {
  final void Function(Lesson) onLessonTap;

  const LessonCard({super.key, required this.onLessonTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: lessons.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return GestureDetector(
            onTap: () => onLessonTap(lesson),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: AppColors.secondaryColor,
              ),
              child: Column(
                children: [
                  Icon(lesson.icon, color: AppColors.backgroundColor, size: 72),
                  CardText(
                    lesson.name.length < 12
                        ? lesson.name
                        : '${lesson.name.substring(0, 9)}...',
                    AppColors.backgroundColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
