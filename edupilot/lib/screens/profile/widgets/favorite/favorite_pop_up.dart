import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';
import 'package:edupilot/shared/styled_text.dart';

class FavoritePopUp extends StatefulWidget {
  const FavoritePopUp({
    super.key,
    required this.onSave,
  });

  final VoidCallback onSave;

  @override
  State<FavoritePopUp> createState() => _FavoritePopUpState();
}

class _FavoritePopUpState extends State<FavoritePopUp> {
  late List<LessonsByGradeDTO> allLessons;
  late Set<String> favoriteLessonIds = {};

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      allLessons = await LessonsApiHandler().getLessonsByGrade();
      final favs = await StudentsApiHandler().getFavoriteLessons();
      favoriteLessonIds = favs.map((f) => f.lessonId).toSet();
    } catch (e) {
      hasError = true;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return const Center(child: Text('Bir hata oluştu'));
    }

    return AlertDialog(
      title: MediumBodyText('Favori Ders Ekle', AppColors.titleColor),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: ListView.builder(
          itemCount: allLessons.length,
          itemBuilder: (context, index) {
            final lesson = allLessons[index];
            final isFavorite = favoriteLessonIds.contains(lesson.id);

            return ListTile(
              title: XSmallBodyText(lesson.name, AppColors.textColor),
              trailing: SizedBox(
                width: 48,
                height: 48,
                child: Heart(
                  isFavorite: isFavorite,
                  defaultColor: const Color.fromRGBO(200, 200, 220, 1),
                  onTap: () {
                    setState(() {
                      if (isFavorite) {
                        favoriteLessonIds.remove(lesson.id);
                      } else {
                        favoriteLessonIds.add(lesson.id);
                      }
                    });
                  },
                ),
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
          onPressed: () async {
            final success = await StudentsApiHandler().updateFavoriteLessons(favoriteLessonIds.toList());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: XSmallBodyText(
                  success ? 'Favori dersler başarıyla kaydedildi.' : 'Favori dersler kaydedilemedi.',
                  AppColors.textColor,
                ),
                backgroundColor: success ? AppColors.successColor : AppColors.dangerColor,
              ),
            );
            if (success) {
              widget.onSave();
            }
            Navigator.pop(context);
          },
          child: XSmallText('Kaydet', AppColors.primaryColor),
        ),
      ],
    );
  }
}
