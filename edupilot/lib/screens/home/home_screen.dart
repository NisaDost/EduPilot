import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/providers/lesson_provider.dart';
import 'package:edupilot/screens/home/widgets/lesson_card.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  final void Function(Lesson) onLessonTap;

  const HomeScreen({required this.onLessonTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);
    // final favLessons = ref.watch(favLessonsProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hoş Geldin ve hızlı bilgi ekranı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeText('Hoş Geldin, USER!', AppColors.successColor),
                    const SizedBox(height: 8),
                    XSmallText('Bugün nasıl çalışmak istersin?', AppColors.textColor),
                    const SizedBox(height: 8),
                    // puan bilgisi ve iconu
                    Row(
                      children: [
                        Icon(Icons.bolt, 
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        LargeBodyText('1205', AppColors.textColor),
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
                        LargeBodyText('5. Gün', AppColors.textColor),
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
          ),
          // ders kartları
          Container(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return LessonCard(
                  lesson: lessons[index],
                  onTap: () => onLessonTap(lessons[index])
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
