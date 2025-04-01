import 'package:edupilot/models/quiz/quiz.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(this.quiz, {super.key});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryAccent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // ders iconu, ders adı, quiz ödülü gibi genel bilgiler
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // icon - ders adı - konusu
                Row(
                  children: [
                    Icon(quiz.lesson.icon),

                    // ders adı - konusu
                    Row(
                      children: [
                        StyledTitle(quiz.lesson.name.toUpperCase(), AppColors.backgroundColor),
                        const SizedBox(height: 8),
                        StyledHeading(quiz.subject.name),
                      ],
                    )
                  ],
                ),

                // quiz ödülü
                Row(

                ),
              ],
            ),

            // sınıfı, soru sayısı, süresi, zorluğu
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}