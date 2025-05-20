import 'package:edupilot/models/dtos/supervisor_dto.dart';
import 'package:edupilot/models/dtos/supervisor_info_dto.dart';
import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/services/supervisors_api_handler.dart';
import 'package:edupilot/sessions/supervisor_session.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class SupervisorHomeScreen extends StatefulWidget {
  const SupervisorHomeScreen({super.key});

  @override
  State<SupervisorHomeScreen> createState() => _SupervisorHomeScreenState();
}

class _SupervisorHomeScreenState extends State<SupervisorHomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAccent,
      body: SafeArea(
        child: FutureBuilder<SupervisorDTO>(
          future: SupervisorsApiHandler().getSupervisor(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Bir hata oluştu (get): ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (snapshot.hasData) {
              final supervisor = snapshot.data!;
              final fullName = '${supervisor.firstName} ${supervisor.middleName!.isNotEmpty ? '${supervisor.middleName} ${supervisor.lastName}' : supervisor.lastName}';

              return FutureBuilder<SupervisorInfoDTO>(
                future: SupervisorsApiHandler().getSupervisorInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Bir hata oluştu (info): ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final supervisorInfo = snapshot.data!;
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Header
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 60),
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(75),
                                            blurRadius: 4,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                                      ),
                                      child: Text(
                                        'Selam $fullName 👋',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.backgroundColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(75),
                                            blurRadius: 4,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/img/logo/logo_horizontal.png',
                                        height: 60,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 32),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildInfoCard(
                                    title: 'Senin Kodun',
                                    content: supervisor.uniqueCode.toString(),
                                    icon: Icons.qr_code_2_rounded,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildInfoCard(
                                    title: 'Kayıtlı Olduğun Okul',
                                    content: supervisorInfo.institutionName != null ? supervisorInfo.institutionName.toString() : 'Herhangi bir okula kayıtlı değilsin.',
                                    icon: Icons.school_rounded,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildInfoCard(
                                    title: 'Kayıtlı Öğrencilerin',
                                    icon: Icons.co_present,
                                    customContent: supervisorInfo.students == null || supervisorInfo.students!.isEmpty
                                        ? const Text('Herhangi bir öğrenciye atanmadın.')
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Expanded(child: Text('Öğrenci Adı', style: TextStyle(fontWeight: FontWeight.bold))),
                                                  SizedBox(width: 16),
                                                  Text('Sınıfı', style: TextStyle(fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              ...supervisorInfo.students!.map((student) {
                                                final fullName = '${student.studentFirstName}'
                                                    '${student.studentMiddleName != null && student.studentMiddleName!.isNotEmpty ? ' ${student.studentMiddleName}' : ''}'
                                                    ' ${student.studentLastName}';

                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Text(fullName)),
                                                      SizedBox(width: 16),
                                                      Text(student.studentGrade.toString()),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.dangerColor,
                              foregroundColor: AppColors.backgroundColor,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                            ),
                            onPressed: () {
                              SupervisorSession.clearSupervisorId();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ));
                            },
                            child: LargeBodyText('Çıkış Yap', AppColors.backgroundColor),
                          ),
                        ),
                      ],
                    );

                  }
                  return const SizedBox.shrink();
                }
              );
            } else {
              return const Center(child: Text('Veri bulunamadı.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    String? content,
    IconData? icon,
    Widget? customContent,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 40, color: AppColors.primaryColor),
          if (icon != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textColor.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                customContent ??
                    Text(
                      content ?? '',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
