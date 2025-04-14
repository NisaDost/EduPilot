import 'package:edupilot/providers/quiz_provider.dart';
import 'package:edupilot/screens/home/widgets/quiz_card.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(quizzesProvider);
    // final favQuizzes = ref.watch(favQuizzesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Hoş Geldin ve hızlı bilgi ekranı
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledHeading('Hoş Geldin, USER!', AppColors.titleColor),
                  const SizedBox(height: 8),
                  StyledText('Bugün nasıl çalışmak istersin?', AppColors.textColor),
                  const SizedBox(height: 8),
                  // puan bilgisi ve iconu
                  Row(
                    children: [
                      Icon(Icons.bolt, 
                        color: AppColors.primaryColor,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      StyledTitle('1205', AppColors.textColor),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // streak bilgisi ve iconu
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, 
                        color: AppColors.secondaryColor,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      StyledTitle('5. Gün', AppColors.textColor),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              return QuizCard(
                quiz: quizzes[index],
                onTap: () {
                  // Navigate to quiz page, etc.
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
