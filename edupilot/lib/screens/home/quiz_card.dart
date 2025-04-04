import 'package:edupilot/providers/quiz_provider.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allQuizes = ref.watch(quizesProvider);

    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: allQuizes.length,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemBuilder:(context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            color: AppColors.primaryAccent,
            child: Row(
              children: [
                // ders iconu
                Column(
                  children: [
                    Icon(allQuizes[index].lesson.icon, size: 140)
                  ],
                ),
                // ders adı - quiz puan bilgisi
                Column(
                  children: [
                    //ders adı
                    StyledTitle(allQuizes[index].lesson.name.toUpperCase(), AppColors.backgroundColor),
                    // quiz puan bilgisi
                    StyledText('Bu quizde doğru cevap başına'),
                    SizedBox(height: 8),
                    StyledText('${allQuizes[index].pointPerQuestion} ${Icon(Icons.bolt)} kazanabilirsin!')
                  ],
                ),

                // quizler listesine gitme butonu
                Column(
                  children: [
                    Container(
                      color: AppColors.backgroundColor.withValues(alpha: 0.05),
                      child: FilledButton(
                        onPressed: () {}, 
                        child: Icon(Icons.arrow_forward_ios,
                          size: 120,
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}