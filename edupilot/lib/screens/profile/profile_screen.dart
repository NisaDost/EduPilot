import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/profile/widgets/achievement/achievement_card.dart';
import 'package:edupilot/screens/profile/widgets/favorite/fav_lesson_card.dart';
import 'package:edupilot/screens/profile/widgets/favorite/favorite_pop_up.dart';
import 'package:edupilot/services/students_api_handler.dart';
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
    return FutureBuilder<StudentDTO>(
      future: StudentsApiHandler().getLoggedInStudent(),
      builder: (BuildContext context, AsyncSnapshot studentSnapshot) {
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (studentSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${studentSnapshot.error}'));
        } else if (!studentSnapshot.hasData) {
          return const Center(child: Text('Öğrenci bulunamadı.'));
        }
        final StudentDTO student = studentSnapshot.data!;
        
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LargeBodyText(
                              '${student.firstName} ${student.middleName != null 
                              ? '${student.middleName!.substring(0,1)}. '
                              : ''}${student.lastName}', 
                              AppColors.titleColor),
                            Row(
                              children: [
                                Icon(Icons.school_rounded, color: AppColors.titleColor, size: 36),
                                const SizedBox(width: 12),
                                XSmallBodyText('${student.grade}. Sınıf', AppColors.textColor)
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.bolt, color: AppColors.primaryColor, size: 36),
                                const SizedBox(width: 12),
                                XSmallBodyText(student.points.toString(), AppColors.primaryAccent),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.local_fire_department, color: AppColors.secondaryColor, size: 36),
                                const SizedBox(width: 12),
                                XSmallBodyText('${student.dailyStreakCount}. Gün', AppColors.secondaryAccent),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 ProfileScreenButton(
                                  onPressed: () {}, 
                                  color: AppColors.primaryColor,
                                  child: XSmallText('Danışmanlarım', AppColors.backgroundColor), 
                                ),
                                const SizedBox(width: 8),
                                 ProfileScreenButton(
                                  onPressed: () {}, 
                                  color: AppColors.primaryColor,
                                  child: XSmallText('Okulum', AppColors.backgroundColor), 
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ProfileScreenButton(
                                onPressed: () {}, 
                                color: AppColors.secondaryColor,
                                child: XSmallText('Danışman Ekle', AppColors.backgroundColor), 
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                  
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
                                  child: Image.asset('assets/img/avatar/${student.avatar}', 
                                    fit: BoxFit.cover,
                                    width: 144,
                                    height: 144,
                                  ),
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
                          ProfileScreenButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => FavoritePopUp(
                                  onSave: () {
                                    setState(() {});
                                  },
                                ),
                              );
                            }, 
                            color: AppColors.secondaryColor,
                            child: XSmallText('Düzenle', AppColors.backgroundColor),
                          ),
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16)),
                    color: AppColors.backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumBodyText('Başarımlar', AppColors.titleColor),
                      SizedBox(height: 12),
                      AchievementCard(student: student),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}