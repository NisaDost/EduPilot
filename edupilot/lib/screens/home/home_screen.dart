import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/home/widgets/lesson_card.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final StudentDTO student;
  final void Function(FavoriteLessonDTO) onLessonTap;
  final VoidCallback onRefreshStudent;

  const HomeScreen({
    super.key,
    required this.student,
    required this.onLessonTap, 
    required this.onRefreshStudent,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshStudent();
      },
      child: FutureBuilder<StudentDTO>(
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
            child: Column(
              children: [
                // Hoş Geldin ve hızlı bilgi ekranı
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LargeText('Hoş Geldin, ${student.firstName}!', AppColors.successColor),
                          const SizedBox(height: 8),
                          XSmallText('Bugün nasıl çalışmak istersin?', AppColors.textColor),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.bolt, 
                                color: AppColors.primaryColor,
                                size: 40,
                              ),
                              const SizedBox(width: 12),
                              LargeBodyText(student.points.toString(), AppColors.textColor),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.local_fire_department, 
                                color: AppColors.secondaryColor,
                                size: 40,
                              ),
                              const SizedBox(width: 12),
                              LargeBodyText('${student.dailyStreakCount}. Gün', AppColors.textColor),
                            ],
                          ),
                        ],
                      ),
                  
                      // maskot resmi
                      Expanded(
                        child: Image.asset(
                          'assets/img/mascots/demo_mascot.png',
                          height: 180,
                          width: 180,
                        ),
                      ),
                    ],
                  ),
                ),
                // ders kartları
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: student.favoriteLessons?.length ?? 0,
                    itemBuilder: (context, index) {
                      return LessonCard(
                        lesson: student.favoriteLessons![index],
                        onTap: () => onLessonTap(student.favoriteLessons![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}