import 'package:edupilot/screens/profile/widgets/achievement/achievement_card.dart';
import 'package:edupilot/screens/profile/widgets/favorite/fav_lesson_card.dart';
import 'package:edupilot/screens/profile/widgets/favorite/favorite_pop_up.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: AppColors.backgroundAccent,
        child: Column(
          children: [
            // kişisel bilgiler + avatar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                color: AppColors.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // kişisel bilgiler
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeBodyText('Name Surname', AppColors.titleColor),
                      Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppColors.titleColor, size: 36),
                          const SizedBox(width: 12),
                          XSmallBodyText('8. Sınıf', AppColors.textColor)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.bolt, color: AppColors.primaryColor, size: 36),
                          const SizedBox(width: 12),
                          XSmallBodyText('1205', AppColors.primaryAccent),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, color: AppColors.secondaryColor, size: 36),
                          const SizedBox(width: 12),
                          XSmallBodyText('9. Gün', AppColors.secondaryAccent),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ProfileScreenButton(
                        onPressed: () {}, 
                        color: AppColors.secondaryColor,
                        child: XSmallText('Kurum Bilgisi Ekle', AppColors.backgroundColor), 
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
                              child: XSmallText('Avatarını Değiştir', AppColors.backgroundColor)
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            // favori dersler
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.backgroundColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediumBodyText('Favori Dersler', AppColors.titleColor),
                      Row(
                        children: [
                          ProfileScreenButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const FavoritePopUp(),
                              );
                            }, 
                            color: AppColors.primaryColor,
                            child: XSmallText('Favori Ders Ekle', AppColors.backgroundColor), 
                          ),
                          const SizedBox(width: 8),
                          ProfileScreenButton(
                            onPressed: () {}, 
                            color: AppColors.successColor,
                            child: XSmallText('Kaydet', AppColors.backgroundColor), 
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
            const SizedBox(height: 12),
            // başarımlar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: AppColors.backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediumBodyText('Başarımlar', AppColors.titleColor),
                  SizedBox(height: 12),
                  AchievementCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}