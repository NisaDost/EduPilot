import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/screens/intro/intro_swipe_screen.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CollapseMenu extends StatelessWidget {
  const CollapseMenu({
    super.key,
    required this.onAllLessonsTap,
    required this.onProfileTap,
    required this.onQuizAnalysysTap,
    });

  final VoidCallback onAllLessonsTap;
  final VoidCallback onProfileTap;
  final VoidCallback onQuizAnalysysTap;

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
        return Container(
          color: AppColors.primaryAccent,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // name-surname
              LargeText(
                '${student.firstName} ${student.middleName!.isNotEmpty 
              ? '${student.middleName} '
              : ''}${student.lastName}', AppColors.backgroundColor),
              const SizedBox(height: 12),
              // icon - grade - points - streak
              Row(
                children: [
                  // icon
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 64,
                        child: Image.asset('assets/img/avatar/${student.avatar}')
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // grade - points - streak
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // grade
                      Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppColors.backgroundColor),
                          const SizedBox(width: 16),
                          SmallBodyText("${student.grade}. Sınıf", AppColors.backgroundColor)
                        ],
                      ),
                      const SizedBox(height: 4),
                      // points
                      Row(
                        children: [
                          Icon(Icons.bolt, color: AppColors.primaryColor),
                          const SizedBox(width: 16),
                          SmallBodyText("${student.points}", AppColors.backgroundColor)
                        ],
                      ),
                      const SizedBox(height: 4),
                      //streak
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, color: AppColors.secondaryColor),
                          const SizedBox(width: 16),
                          SmallBodyText("${student.dailyStreakCount}", AppColors.backgroundColor)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _buttonWidget('Profil', onProfileTap),
              _buttonWidget('Tüm Dersler', onAllLessonsTap),
              _buttonWidget('Quiz Analizlerin', onQuizAnalysysTap),
              _buttonWidget('Tanıtım Sayfası', () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const IntroSwipeScreen()
                  )
                )
              ),

              Expanded(child: SizedBox()),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    StudentSession.clearStudentId();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ));
                  }, 
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SmallBodyText('Çıkış Yap', AppColors.backgroundColor),
                ),
              ),
            ],
          ),
        );
      },
    );  
  }

  _buttonWidget(String text, VoidCallback onPressed) {
    return Column(
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CollapseMenuButton(
            onPressed: onPressed, 
            child: SmallBodyText(text, AppColors.backgroundColor),
          ),
        ),
      ],
    );
  }
}