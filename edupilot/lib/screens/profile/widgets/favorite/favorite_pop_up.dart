import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/profile/widgets/heart.dart';
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
  final Set<String> selectedIds = {}; // Store selected quiz IDs

  @override
  Widget build(BuildContext context) {
    final notFavorites = ref.watch(notFavLessonsProvider);

    return AlertDialog(
      title: CardTitle('Favori Ders Ekle', AppColors.titleColor),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: ListView.builder(
          itemCount: notFavorites.length,
          itemBuilder: (context, index) {
            final lesson = notFavorites[index];
            final isSelected = selectedIds.contains(lesson.id);

            return ListTile(
              title: StyledText(lesson.name, AppColors.textColor),
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
          child: CardText('Kapat', AppColors.textColor),
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
          child: CardText('Kaydet', AppColors.primaryColor),
        ),
      ],
    );
  }
}
