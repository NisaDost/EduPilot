import 'package:edupilot/providers/achievement_provider.dart';
import 'package:edupilot/screens/profile/widgets/fav_lesson_card.dart';
import 'package:edupilot/shared/styled_button.dart';
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
    // final allQuizzes = ref.watch(quizzesProvider);
    // final favLessons = ref.watch(favQuizzesProvider);
    final achievements = ref.watch(achievementsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: const Color.fromRGBO(200, 200, 220, 1),
        child: Column(
          children: [
            // kişisel bilgiler + avatar
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              color: AppColors.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // kişisel bilgiler
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledTitle('Name Surname', AppColors.titleColor),
                      Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppColors.titleColor, size: 36),
                          const SizedBox(width: 12),
                          StyledText('8. Sınıf', AppColors.textColor)
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
                      SizedBox(height: 8),
                      ProfileScreenButton(
                        onPressed: () {}, 
                        color: AppColors.secondaryColor,
                        child: CardText('Kurum Bilgisi Ekle', AppColors.backgroundColor), 
                      )
                      ],
                  ),
              
                  // avatar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: AppColors.secondaryColor,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 72,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/img/avatar/avatar1.png'),
                            ),
                            
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {}, 
                              child: CardText('Avatarını Değiştir', AppColors.backgroundColor)
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            // favori dersler
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardTitle('Favori Dersler', AppColors.titleColor),
                      Row(
                        children: [
                          ProfileScreenButton(
                            onPressed: () {}, 
                            color: AppColors.primaryColor,
                            child: CardText('Favori Ders Ekle', AppColors.backgroundColor), 
                          ),
                          SizedBox(width: 8),
                          ProfileScreenButton(
                            onPressed: () {}, 
                            color: AppColors.successColor,
                            child: CardText('Kaydet', AppColors.backgroundColor), 
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 175, // or whatever fits your card height
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FavLessonCard(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // başarımlar
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitle('Başarımlar', AppColors.titleColor),
                  // GridView.builder(
                  //   itemCount: achievements.length,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     mainAxisSpacing: 12,
                  //     crossAxisSpacing: 12,
                  //     childAspectRatio: 0.9,
                  //   ), 
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       padding: EdgeInsets.all(10),
                  //       color: AppColors.primaryAccent,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Icon(achievements[index].icon, size: 50),
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}