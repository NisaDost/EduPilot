import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/profile/widgets/achievement/achievement_card.dart';
import 'package:edupilot/screens/profile/widgets/add_supervisor_pop_up.dart';
import 'package:edupilot/screens/profile/widgets/avatar/avatar_pop_up.dart';
import 'package:edupilot/screens/profile/widgets/favorite/fav_lesson_card.dart';
import 'package:edupilot/screens/profile/widgets/favorite/favorite_pop_up.dart';
import 'package:edupilot/screens/profile/widgets/institution_list_pop_up.dart';
import 'package:edupilot/screens/profile/widgets/supervisors_list_pop_up.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onRefreshStudent});

  final VoidCallback onRefreshStudent;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<StudentDTO> _studentFuture;

  @override
  void initState() {
    super.initState();
    _studentFuture = StudentsApiHandler().getLoggedInStudent();
  }

  void _refreshStudent() {
    setState(() {
      _studentFuture = StudentsApiHandler().getLoggedInStudent();
    });
    widget.onRefreshStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldMessengerContext) {
        return FutureBuilder<StudentDTO>(
          future: _studentFuture,
          builder: (BuildContext context, AsyncSnapshot<StudentDTO> studentSnapshot) {
            if (studentSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.primaryColor,
                  rightDotColor: AppColors.secondaryColor,
                  size: 72,
                ),
              );
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
                    // Kişisel bilgiler + avatar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        color: AppColors.backgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Kişisel bilgiler
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LargeBodyText(
                                  '${student.firstName} ${student.middleName != '' ? '${student.middleName!.substring(0, 1)}. ' : ''}${student.lastName}',
                                  AppColors.titleColor,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.school_rounded, color: AppColors.titleColor, size: 36),
                                    const SizedBox(width: 12),
                                    SmallBodyText('${student.grade}. Sınıf', AppColors.textColor),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.bolt, color: AppColors.primaryColor, size: 36),
                                    const SizedBox(width: 12),
                                    SmallBodyText(student.points.toString(), AppColors.primaryAccent),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.local_fire_department, color: AppColors.secondaryColor, size: 36),
                                    const SizedBox(width: 12),
                                    SmallBodyText('${student.dailyStreakCount}. Gün', AppColors.secondaryAccent),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProfileScreenButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => SupervisorsListPopUp(
                                            supervisorsList: student.studentSupervisors
                                                ?.map((s) => s.supervisorName)
                                                .toList(),
                                          ),
                                        );
                                      },
                                      color: AppColors.primaryColor,
                                      child: SmallText('Danışmanlarım', AppColors.backgroundColor),
                                    ),
                                    const SizedBox(width: 8),
                                    ProfileScreenButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => InstitutionListPopUp(
                                            institutionName: student.institutionName,
                                          ),
                                        );
                                      },
                                      color: AppColors.primaryColor,
                                      child: SmallText('Okulum', AppColors.backgroundColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ProfileScreenButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AddSupervisorPopUp(
                                          onSave: () async {
                                            _refreshStudent();
                                          },
                                        ),
                                      );
                                    },
                                    color: AppColors.secondaryColor,
                                    child: SmallText('Danışman Ekle', AppColors.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Avatar
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
                                      child: Image.asset(
                                        'assets/img/avatar/${student.avatar}',
                                        fit: BoxFit.cover,
                                        width: 144,
                                        height: 144,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: () async {
                                        final selectedAvatar = await showDialog(
                                          context: context,
                                          builder: (context) => AvatarPopUp(
                                            onSave: () {
                                              _refreshStudent();
                                            },
                                          ),
                                        );
                                        if (selectedAvatar != null) {
                                          final success = await StudentsApiHandler()
                                              .updateAvatar(selectedAvatar);
                                          if (success) {
                                            ScaffoldMessenger.of(scaffoldMessengerContext)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Avatar başarıyla güncellendi'),
                                                backgroundColor: AppColors.successColor,
                                              ),
                                            );
                                            _refreshStudent();
                                          }
                                        }
                                      },
                                      child: SmallText(
                                        'Avatarını Değiştir',
                                        AppColors.backgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Favori Dersler
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 4,
                            offset: const Offset(4, 4),
                          ),
                        ],
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
                                      onSave: _refreshStudent,
                                      scaffoldMessengerContext: scaffoldMessengerContext,
                                    ),
                                  );
                                },
                                color: AppColors.secondaryColor,
                                child: SmallText('Düzenle', AppColors.backgroundColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 175,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FavLessonCard(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Başarımlar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                          bottom: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 4,
                            offset: const Offset(4, 0),
                          ),
                        ],
                        color: AppColors.backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumBodyText('Başarımlar', AppColors.titleColor),
                          const SizedBox(height: 12),
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
      },
    );
  }
}
