import 'package:edupilot/screens/auth/register/register_screen_1.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundAccent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4, // How soft the shodow is
                  offset: Offset(0, 4), // Horizontal & Vertical offset
                ),
              ],
              color: AppColors.primaryColor
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
                        blurRadius: 4, // How soft the shodow is
                        offset: Offset(0, 4), // Horizontal & Vertical offset
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 54),
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
          Container(
            margin: const EdgeInsets.only(left: 12, top: 96, right: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Text side
                  Expanded(
                    child: CenterAlignedText('Türkiye\'nin Yenilikçi Öğrenci Başarı Takip Uygulaması EduPilot\'a Hoş Geldin!', AppColors.textColor),
                  ),
                  const SizedBox(width: 12), // spacing between text and image
                  // Image side
                  Image.asset(
                    'assets/img/mascots/demo_mascot.png',
                    height: 100, // set size as needed
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MediumText('Zaten hesabın var mı?', AppColors.textColor),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: LargeText('Giriş Yap', AppColors.backgroundColor)
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
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: LargeText('Kayıt Ol', AppColors.backgroundColor)
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.only(right: 8, bottom: 24, top: 2),
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
    );
  }
}