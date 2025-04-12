import 'package:edupilot/providers/quiz_provider.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final allQuizzes = ref.watch(quizzesProvider);
    final favLessons = ref.watch(favQuizzesProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // kişisel bilgiler + favori dersler listesi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledTitle('Name Surname', AppColors.titleColor),
              Row(
                children: [
                  Icon(Icons.school_rounded, color: AppColors.titleColor, size: 36),
                  SizedBox(width: 12),
                  StyledText('8. Sınıf', AppColors.textColor),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.bolt, color: AppColors.primaryColor, size: 36),
                  SizedBox(width: 12),
                  StyledText('1205', AppColors.primaryAccent),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.local_fire_department, color: AppColors.secondaryColor, size: 36),
                  SizedBox(width: 12),
                  StyledText('9. Gün', AppColors.secondaryAccent),
                ],
              ),

              Expanded(child: SizedBox()),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(200, 200, 200, 1),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  children: [
                    StyledText('Favori Dersler Listesi', AppColors.secondaryColor),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 182.4, // burayı incele !!!
                      child: Column(
                        children: favLessons.map((favLesson) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardText(favLesson.lesson.name, AppColors.primaryColor),
                              FilledButton(
                                onPressed: () {
                                  ref.read(quizNotifierProvider.notifier)
                                    .toggleFav(favLesson);
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.dangerColor,
                                  minimumSize: Size(6,12),
                                  padding: EdgeInsets.all(5)
                                ),
                                child: Icon(Icons.remove)
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Favori Ders Ekle'),
                              content: SizedBox(
                                width: 300,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: allQuizzes.map((quiz) {
                                    final isSelected = favLessons.any((f) => f.lesson.name == quiz.lesson.name);
                                    return CheckboxListTile(
                                      title: Text(quiz.lesson.name),
                                      value: isSelected,
                                      onChanged: (checked) {
                                        ref.read(quizNotifierProvider.notifier).toggleFav(quiz);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      }, 
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        backgroundColor: AppColors.successColor
                      ),
                      child: CardText('Favori Ders Ekle', AppColors.backgroundColor)
                    ),
                  ],
                ),
              ),
            ],
          ),
          // avatar değiştir + bişiler
          Column(
            children: [
              CircleAvatar(
                radius: 64,
                //backgroundColor: Colors.transparent,
                child: Image.asset('assets/img/avatar/avatar1.png'),
              ),
              SizedBox(height: 8),
              FilledButton(
                onPressed: () {}, 
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  backgroundColor: AppColors.secondaryColor
                ),
                child: CardText('Avatarını Değiştir', AppColors.backgroundColor)
              ),
            ],
          )
        ],
      )
    );
  }
}
