import 'package:edupilot/screens/home/quiz_card.dart';
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

            for (int i = 0; i < 8; i++)
            // ders kartları
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Icon (Mathematical Grid)
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Icon(Icons.calculate, size: 120, color: AppColors.backgroundColor),
                              ],
                            ),
                          ),

                          // Text Section (Matematik & Quiz Points)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardTitle('MATEMATİK', AppColors.backgroundColor),
                                SizedBox(height: 8),
                                Text('Bu quizde soru başına',
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 14,
                                    ),
                                ),
                                Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 14,
                                          textBaseline: TextBaseline.alphabetic,
                                        ),
                                        children: [
                                          TextSpan(text: '20'),
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle, // Center icon vertically
                                            child: Icon(Icons.bolt, color: AppColors.backgroundColor, size: 16),
                                          ),
                                          WidgetSpan(child: SizedBox(width: 3)),
                                          TextSpan(text: 'kazanabilirsin!'),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Right Section (Full tappable area as button)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // TODO: Handle button tap
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 53, bottom: 53, left: 10, right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Icon(Icons.arrow_forward_ios, size: 40, color: AppColors.backgroundColor),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
