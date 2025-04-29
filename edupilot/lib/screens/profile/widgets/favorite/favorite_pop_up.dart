import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edupilot/theme.dart';
import 'package:edupilot/shared/styled_text.dart';

class FavoritePopUp extends ConsumerStatefulWidget {
  const FavoritePopUp({super.key});

  @override
  ConsumerState<FavoritePopUp> createState() => _FavoritePopUpState();
}

class _FavoritePopUpState extends ConsumerState<FavoritePopUp> {
  final Set<String> selectedIds = {}; // Store selected lessons IDs

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LessonsByGradeDTO>>(
      future: StudentsApiHandler().getNotFavLessons(),
      builder: (BuildContext context, AsyncSnapshot notFavoritesSnapshot) {
        if (notFavoritesSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (notFavoritesSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${notFavoritesSnapshot.error}'));
        } else if (!notFavoritesSnapshot.hasData) {
          return const Center(child: Text('Favori olmayan ders bulunamadı.'));
        }
        final List<LessonsByGradeDTO> notFavorites = notFavoritesSnapshot.data!;

        return AlertDialog(
          title: MediumBodyText('Favori Ders Ekle', AppColors.titleColor),
          content: SizedBox(
            width: double.maxFinite,
            height: 350,
            child: ListView.builder(
              itemCount: notFavorites.length,
              itemBuilder: (context, index) {
                final notFavlesson = notFavorites[index];
                final isSelected = selectedIds.contains(notFavlesson.id);

                return ListTile(
                  title: XSmallBodyText(notFavlesson.name, AppColors.textColor),
                  trailing: IconButton(
                    icon: Heart(lesson: notFavlesson, defaultColor: const Color.fromRGBO(200, 200, 220, 1)),
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          selectedIds.remove(notFavlesson.id);
                        } else {
                          selectedIds.add(notFavlesson.id);
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
                    lesson.toggleIsFav(); // Apply favoriting here
                  }
                }
                ref.invalidate(notFavLessonsProvider); // refresh
                ref.invalidate(favLessonsProvider);
                Navigator.of(context).pop();
              },
              child: XSmallText('Kaydet', AppColors.primaryColor),
            ),
          ],
        );
      }
    );
  }
}
