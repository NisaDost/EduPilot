import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';
import 'package:edupilot/shared/styled_text.dart';

class FavLessonPopUp extends StatefulWidget {
  const FavLessonPopUp({
    super.key,
    required this.selectedGrade,
    required this.selectedLessons,
  });

  final int selectedGrade;
  final List<String> selectedLessons;

  @override
  State<FavLessonPopUp> createState() => _FavoritePopUpState();
}

class _FavoritePopUpState extends State<FavLessonPopUp> {
  late List<LessonsByGradeDTO> allLessons;
  late Set<String> favoriteLessonIds = {};

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    favoriteLessonIds = widget.selectedLessons.toSet();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      allLessons = await LessonsApiHandler().getLessonsByGradeForRegister(widget.selectedGrade);
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
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: allLessons.length,
            itemBuilder: (context, index) {
              final lesson = allLessons[index];
              final isFavorite = favoriteLessonIds.contains(lesson.id);
          
              return ListTile(
                title: SmallBodyText(lesson.name, AppColors.textColor),
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: SmallText('Kapat', AppColors.textColor),
        ),
        TextButton(
          onPressed: () {
            final success = favoriteLessonIds.isNotEmpty;

            Navigator.pop<Set<String>>(context, favoriteLessonIds);

            // Delay any UI calls until after dialog is dismissed
            Future.delayed(Duration.zero, () {
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: SmallBodyText(
                      'Favori dersler başarıyla kaydedildi.',
                      AppColors.textColor,
                    ),
                    backgroundColor: AppColors.successColor,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: SmallBodyText(
                      'Favori dersler kaydedilemedi.',
                      AppColors.textColor,
                    ),
                    backgroundColor: AppColors.dangerColor,
                  ),
                );
              }
            });
          },
          child: SmallText('Kaydet', AppColors.primaryColor),
        ),
      ],
    );
  }
}
