import 'package:edupilot/models/dtos/solved_question_count_dto.dart';
import 'package:edupilot/screens/agenda/widgets/agenda_header_responsive.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyDetailsScreen extends StatelessWidget {
  const DailyDetailsScreen({super.key, required this.date});

  final DateTime date;

  String _weekDay() {
    switch (date.weekday) {
      case 1:
        return 'Pazartesi';
      case 2:
        return 'Salı';
      case 3:
        return 'Çarşamba';
      case 4:
        return 'Perşembe';
      case 5:
        return 'Cuma';
      case 6:
        return 'Cumartesi';
      case 7:
        return 'Pazar';
      default:
        return '?';
    }
  }

  Future<List<SolvedQuestionCountDTO>> _loadDailySolvedQuestionData() async {
    final rawData = await StudentsApiHandler().getSolvedQuestionCountForDay(date);

    // Group and sum counts by lessonName
    final Map<String, int> grouped = {};
    for (var item in rawData) {
      grouped[item.lessonName] = (grouped[item.lessonName] ?? 0) + item.count;
    }

    // Convert back to a list of DTOs (you can use a new DTO class if needed)
    final List<SolvedQuestionCountDTO> combined = grouped.entries.map((entry) {
      return SolvedQuestionCountDTO(
        id: '', // Not important here
        studentId: '',
        lessonId: '',
        lessonName: entry.key,
        count: entry.value,
        entryDate: date,
        startOfWeek: date,
        endOfWeek: date,
      );
    }).toList();

    return combined;
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 104;
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: (topBarHeight + 16), right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 4,
                        offset: const Offset(4, 4),
                      ),
                    ],
                    color: AppColors.primaryAccent,
                  ),
                  child: LargeText('$formattedDate - ${_weekDay()}', AppColors.backgroundColor),
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: FutureBuilder<List<SolvedQuestionCountDTO>>(
                  future: _loadDailySolvedQuestionData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline_rounded, size: 64, color: AppColors.titleColor.withValues(alpha: 0.5)),
                          LargeText('Bu tarihte çözülmüş soru bulunmamakta.', AppColors.titleColor.withValues(alpha: 0.5), textAlign: TextAlign.center)
                        ],
                      ));
                    }

                    final data = snapshot.data!;

                    return ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(25),
                                blurRadius: 4,
                                offset: const Offset(4, 4),
                              ),
                            ],
                            border: Border.all(color: AppColors.primaryColor, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MediumText(item.lessonName, AppColors.textColor),
                              LargeText('${item.count}', AppColors.primaryColor),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        AgendaHeaderResponsive(
          topBarHeight: topBarHeight,
          title: 'Günlük Analiz',
          description: 'Seçtiğin günde kaç soru çözdüğünü burda görebilirsin',
        ),
      ],
    );
  }
}
