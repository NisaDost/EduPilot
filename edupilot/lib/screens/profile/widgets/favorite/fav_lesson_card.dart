import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class FavLessonCard extends StatelessWidget {
  const FavLessonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoriteLessonDTO>>(
      future: StudentsApiHandler().getFavoriteLessons(),
      builder: (BuildContext context, AsyncSnapshot<List<FavoriteLessonDTO>> studentSnapshot) {
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (studentSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${studentSnapshot.error}'));
        } else if (!studentSnapshot.hasData) {
          return const Center(child: Text('Favori ders bulunamadı.'));
        }
        final List<FavoriteLessonDTO> lessons = studentSnapshot.data!;
        return Row(
          children: List.generate(lessons.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 170),
                    child: Card(
                      color: AppColors.primaryAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(IconConversion().getIconFromString(lessons[index].lessonIcon), size: 96, color: AppColors.backgroundColor),
                            MediumBodyText(lessons[index].lessonName, AppColors.backgroundColor)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
