import 'package:edupilot/shared/styled_app_bar.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Hoş Geldin ve hızlı bilgi ekranı
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledHeading('Hoş Geldin, USER!'),
                    Text('Bugün nasıl çalışmak istersin?', style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.jomhuria().fontFamily,
                        foreground: Paint()..color = AppColors.textColor,
                      )
                    ),

                    // puan bilgisi ve iconu
                    Row(
                      children: [
                        Icon(Icons.bolt, 
                          color: AppColors.primaryAccent,
                          size: 40,
                        ),
                        SizedBox(width: 12),
                        StyledTitle('1205', AppColors.primaryAccent),
                      ],
                    ),

                    // streak bilgisi ve iconu
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, 
                          color: AppColors.secondaryAccent,
                          size: 40,
                        ),
                        SizedBox(width: 12),
                        StyledTitle('5. Gün', AppColors.secondaryAccent),
                      ],
                    ),
                  ],
                ),

                // maskot resmi
                Expanded(
                  child: Image.asset('assets/img/mascots/demo_mascot.png',
                    height: 180,
                    width: 180,
                  ),
                ),
              ],
            ),

            // ders kartları
            Row(
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}
