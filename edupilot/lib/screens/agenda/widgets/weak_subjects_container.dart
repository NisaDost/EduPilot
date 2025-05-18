import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class WeakSubjectsContainer extends StatefulWidget {
  const WeakSubjectsContainer({super.key});

  @override
  State<WeakSubjectsContainer> createState() => _WeakSubjectsContainerState();
}

class _WeakSubjectsContainerState extends State<WeakSubjectsContainer> {
  late Future<List<Map<String, String>>> _weakSubjectsWithLessons;

  @override
  void initState() {
    super.initState();
    _weakSubjectsWithLessons = _fetchWeakSubjectsWithLessonNames();
  }

  Future<List<Map<String, String>>> _fetchWeakSubjectsWithLessonNames() async {
    final weakSubjects = await StudentsApiHandler().getWeakSubjects();

    // Fetch lesson names in parallel for better performance
    return Future.wait(weakSubjects.map((subject) async {
      try {
        final lesson = await LessonsApiHandler().getLessonNameFromSubjectId(subject.subjectId);
        return {
          'lessonName': lesson.lessonName,
          'subjectName': subject.subjectName,
        };
      } catch (e) {
        return {
          'lessonName': 'Hata',
          'subjectName': subject.subjectName,
        };
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeBodyText('Zayıf Konular', AppColors.textColor),
          const SizedBox(height: 12),
          FutureBuilder<List<Map<String, String>>>(
            future: _weakSubjectsWithLessons,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Hata oluştu: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: const Text('Zayıf konu bulunamadı.'));
              }

              final data = snapshot.data!;

              return Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                border: TableBorder.symmetric(
                  inside: BorderSide(color: AppColors.primaryColor),
                  outside: BorderSide(color: AppColors.primaryColor)
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.primaryAccent),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: MediumBodyText('Ders', AppColors.backgroundColor),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: MediumBodyText('Konu', AppColors.backgroundColor),
                      ),
                    ],
                  ),
                  ...data.map((item) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SmallText(item['lessonName'] ?? '-', AppColors.textColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SmallText(item['subjectName'] ?? '-', AppColors.textColor),
                          ),
                        ],
                      )),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
