import 'package:edupilot/screens/auth/login/login_screen.dart';
import 'package:edupilot/screens/auth/register/register_screen_1.dart';
import 'package:edupilot/screens/supervisor/auth/supervisor_login_screen.dart';
import 'package:edupilot/screens/supervisor/auth/supervisor_register_screen.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundAccent,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                        color: AppColors.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset('assets/img/logo/logo_horizontal.png', height: 48),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: XLargeText('Hoş Geldin!', AppColors.backgroundColor),
                    )
                  ],
                ),
              ),

              // Intro box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: AppColors.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: MediumText(
                          'Türkiye\'nin Yenilikçi Öğrenci Başarı Takip Uygulaması EduPilot\'a Hoş Geldin!',
                          AppColors.textColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        'assets/img/mascots/intro_mascot.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Student Section
              Container(
                margin: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: AppColors.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MediumBodyText('Öğrenciler İçin', AppColors.textColor),
                      const SizedBox(height: 16),
                      MediumText('Zaten hesabın var mı?', AppColors.textColor),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 96),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: LargeText('Giriş Yap', AppColors.backgroundColor),
                      ),
                      const SizedBox(height: 24),
                      MediumText('Veya hesap oluştur!', AppColors.textColor),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen1()));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryAccent,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 96),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: LargeText('Kayıt Ol', AppColors.backgroundColor),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Supervisor Section
              Container(
                margin: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: AppColors.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MediumBodyText('Danışmanlar İçin', AppColors.textColor),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupervisorLoginScreen()));
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.secondaryAccent,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: LargeText('Giriş Yap', AppColors.backgroundColor),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupervisorRegisterScreen()));
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: LargeText('Kayıt Ol', AppColors.backgroundColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Footer
              Container(
                padding: const EdgeInsets.only(right: 8, bottom: 8, top: 2),
                color: AppColors.primaryColor,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MediumBodyText('EduPilot', AppColors.backgroundColor),
                    Icon(Icons.copyright, color: AppColors.backgroundColor, size: 16),
                    MediumBodyText(DateTime.now().year.toString(), AppColors.backgroundColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}