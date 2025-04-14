import 'package:edupilot/screens/profile/widgets/heart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edupilot/providers/quiz_provider.dart';
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
    final notFavorites = ref.watch(nonFavQuizzesProvider);

    return AlertDialog(
      title: CardTitle('Favori Ders Ekle', AppColors.titleColor),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: ListView.builder(
          itemCount: notFavorites.length,
          itemBuilder: (context, index) {
            final quiz = notFavorites[index];
            final isSelected = selectedIds.contains(quiz.id);

            return ListTile(
              title: StyledText(quiz.lesson.name, AppColors.textColor),
              trailing: IconButton(
                icon: Heart(lesson: quiz, defaultColor: const Color.fromRGBO(200, 200, 220, 1)),
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedIds.remove(quiz.id);
                    } else {
                      selectedIds.add(quiz.id);
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
            final allQuizzes = ref.read(quizzesProvider);
            for (final quiz in allQuizzes) {
              if (selectedIds.contains(quiz.id)) {
                quiz.toggleIsFav(); // Apply favoriting here
              }
            }
            ref.invalidate(nonFavQuizzesProvider); // refresh
            ref.invalidate(favQuizzesProvider);
            Navigator.of(context).pop();
          },
          child: CardText('Kaydet', AppColors.primaryColor),
        ),
      ],
    );
  }
}
