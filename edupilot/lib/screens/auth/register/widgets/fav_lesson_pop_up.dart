import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edupilot/theme.dart';
import 'package:edupilot/shared/styled_text.dart';

class FavLessonPopUp extends ConsumerStatefulWidget {
  final int selectedGrade;

  const FavLessonPopUp({super.key, required this.selectedGrade});

  @override
  ConsumerState<FavLessonPopUp> createState() => _FavoritePopUpState();
}

class _FavoritePopUpState extends ConsumerState<FavLessonPopUp> {
  final Set<String> selectedIds = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LessonsByGradeDTO>>(
      future: StudentsApiHandler().getNotFavLessons(),
      builder: (BuildContext context, AsyncSnapshot notFavLessonSnapshot) {
        if (notFavLessonSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (notFavLessonSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${notFavLessonSnapshot.error}'));
        } else if (!notFavLessonSnapshot.hasData) {
          return const Center(child: Text('Öğrenci bulunamadı.'));
        }
        final List<LessonsByGradeDTO> notFavLessons = notFavLessonSnapshot.data!;

        return AlertDialog(
          title: MediumBodyText('Favori Ders Ekle', AppColors.titleColor),
          content: SizedBox(
            width: double.maxFinite,
            height: 350,
            child: notFavLessons.isEmpty
                ? Center(child: XSmallBodyText('Bu sınıfa uygun ders bulunamadı.', AppColors.textColor))
                : ListView.builder(
                    itemCount: notFavLessons.length,
                    itemBuilder: (context, index) {
                      final lesson = notFavLessons[index];
                      final isSelected = selectedIds.contains(lesson.id);

                      return ListTile(
                        title: XSmallBodyText(lesson.name, AppColors.textColor),
                        trailing: IconButton(
                          icon: Heart(lesson: lesson, defaultColor: const Color.fromRGBO(200, 200, 220, 1)),
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                selectedIds.remove(lesson.id);
                              } else {
                                selectedIds.add(lesson.id);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: XSmallText('Kapat', AppColors.textColor),
            ),
            TextButton(
              onPressed: () {
                final allLessons = ref.read(lessonsProvider);
                for (final lesson in allLessons) {
                  if (selectedIds.contains(lesson.id)) {
                    lesson.toggleIsFav();
                  }
                }
                ref.invalidate(notFavLessonsProvider);
                ref.invalidate(favLessonsProvider);
                Navigator.of(context).pop();
              },
              child: XSmallText('Kaydet', AppColors.primaryColor),
            ),
          ],
        );
      },
    );
  }
}