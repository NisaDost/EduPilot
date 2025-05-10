import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonCard extends ConsumerWidget {
  final void Function(LessonsByGradeDTO) onLessonTap;

  const LessonCard({super.key, required this.onLessonTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<LessonsByGradeDTO>>(
        future: LessonsApiHandler().getLessonsByGrade(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available.'));
          }

          final lessons = snapshot.data!;
          return GridView.builder(
            itemCount: lessons.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return GestureDetector(
                onTap: () => onLessonTap(lesson),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    children: [
                        Icon(
                          IconConversion().getIconFromString(lesson.icon), 
                          color: AppColors.backgroundColor, 
                          size: 72
                      ),
                      const SizedBox(height: 10),
                      SmallText(
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
          );
        },
      ),
    );
  }
}
