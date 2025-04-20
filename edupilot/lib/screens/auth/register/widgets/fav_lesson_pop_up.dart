import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
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
    final notFavorites = ref.watch(notFavLessonsProvider);
    final filteredLessons = notFavorites.where((lesson) => lesson.grade.contains(widget.selectedGrade)).toList();

    return AlertDialog(
      title: MediumBodyText('Favori Ders Ekle', AppColors.titleColor),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: filteredLessons.isEmpty
            ? Center(child: XSmallBodyText('Bu sınıfa uygun ders bulunamadı.', AppColors.textColor))
            : ListView.builder(
                itemCount: filteredLessons.length,
                itemBuilder: (context, index) {
                  final lesson = filteredLessons[index];
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
  }
}