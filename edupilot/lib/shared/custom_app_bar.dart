import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMenuOpen;
  final VoidCallback onMenuToggle;
  final VoidCallback onProfileTap;

  const CustomAppBar({
    super.key,
    required this.isMenuOpen,
    required this.onMenuToggle,
    required this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+4);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentDTO>(
        future: StudentsApiHandler().getLoggedInStudent(),
        builder: (BuildContext context, AsyncSnapshot studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SmallText('Yükleniyor...', AppColors.titleColor));
          } else if (studentSnapshot.hasError) {
            return Center(child: Text('Hata oluştu: ${studentSnapshot.error}'));
          } else if (!studentSnapshot.hasData) {
            return const Center(child: Text('Öğrenci bulunamadı.'));
          }
          final StudentDTO student = studentSnapshot.data!;
          
          return AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // menu icon
                IconButton(
                  onPressed: onMenuToggle,
                  padding: const EdgeInsets.only(left: 0),
                  icon: isMenuOpen
                      ? Icon(
                          Icons.close,
                          color: AppColors.backgroundColor,
                          size: 40,
                        )
                      : Icon(
                          Icons.menu,
                          color: AppColors.backgroundColor,
                          size: 40,
                        ),
                ),
                // app name,
                LargeBodyText('EduPilot', AppColors.backgroundColor),
                // profile iccon
                TextButton(
                  onPressed: onProfileTap,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0)
                  ),
                  child: Image.asset('assets/img/avatar/${student.avatar}', width: 60, height: 60),
                ),
              ],
            ),
          );
        }
    );
  }
}