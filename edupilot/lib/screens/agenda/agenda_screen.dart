import 'package:edupilot/models/dtos/solved_question_count_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/profile/widgets/supervisors_list_pop_up.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  late Future<StudentDTO> _studentFuture;
  final List<Map<String, dynamic>> _weeks = [];
  late Map<String, dynamic> _selectedWeek;

  @override
  void initState() {
    super.initState();
    _studentFuture = StudentsApiHandler().getLoggedInStudent();

    final now = DateTime.now();
    for (int i = 0; i < 3; i++) {
      final monday = getStartOfWeek(now.subtract(Duration(days: i * 7)));
      final sunday = getEndOfWeek(monday);
      final label = '${formatDate(monday)} - ${formatDate(sunday)}';

      _weeks.add({
        'label': label,
        'start': monday,
        'end': sunday,
      });
    }
    _selectedWeek = _weeks[0];
  }

  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  DateTime getEndOfWeek(DateTime startOfWeek) {
    return startOfWeek.add(const Duration(days: 6));
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<List<SolvedQuestionCountDTO>> _fetchWeekData() {
    return StudentsApiHandler().getSolvedQuestionCountPerWeek(
      _selectedWeek['start'],
      _selectedWeek['end'],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 112;

    return FutureBuilder<List<SolvedQuestionCountDTO>>(
      future: _fetchWeekData(),
      builder: (BuildContext context, AsyncSnapshot solvedQuestionCountSnapshot) {
        if (solvedQuestionCountSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
            ),
          );
        } else if (solvedQuestionCountSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${solvedQuestionCountSnapshot.error}'));
        } else if (!solvedQuestionCountSnapshot.hasData) {
          return const Center(child: Text('Veri bulunamadı.'));
        }

        final List<SolvedQuestionCountDTO> solvedQuestionCounts = solvedQuestionCountSnapshot.data!;

        // Group counts by day
        Map<String, int> dailyTotals = {};
        for (var item in solvedQuestionCounts) {
          final dateKey = formatDate(item.entryDate);
          dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0) + item.count;
        }

        final List<Widget> dayWidgets = [];
        final startDate = _selectedWeek['start'] as DateTime;
        final today = DateTime.now();

        for (int i = 0; i < 7; i++) {
          final currentDate = startDate.add(Duration(days: i));
          final isToday = currentDate.day == today.day &&
                          currentDate.month == today.month &&
                          currentDate.year == today.year;

          final dateKey = formatDate(currentDate);
          final solvedCount = dailyTotals[dateKey] ?? 0;
          final weekday = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'][i];

          dayWidgets.add(
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyDetailScreen(date: currentDate),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primaryAccent : AppColors.backgroundAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MediumBodyText('$weekday - $dateKey', isToday ? AppColors.backgroundColor : AppColors.titleColor),
                    MediumBodyText('$solvedCount soru', AppColors.successColor),
                  ],
                ),
              ),
            ),
          );
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: topBarHeight),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: AppColors.backgroundAccent,
                  child: Column(
                    children: [
                      // Weekly Container
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.backgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MediumText('Haftalık Soru Sayısı', AppColors.textColor),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColors.primaryAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Map<String, dynamic>>(
                                  borderRadius: BorderRadius.circular(16),
                                  isExpanded: true,
                                  dropdownColor: AppColors.primaryAccent,
                                  value: _selectedWeek,
                                  iconEnabledColor: AppColors.backgroundColor,
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  items: _weeks.map((week) {
                                    return DropdownMenuItem<Map<String, dynamic>>(
                                      value: week,
                                      child: MediumBodyText(week['label'], AppColors.backgroundColor),
                                    );
                                  }).toList(),
                                  onChanged: (Map<String, dynamic>? newWeek) {
                                    if (newWeek != null) {
                                      setState(() {
                                        _selectedWeek = newWeek;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...dayWidgets,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Top Bar
            Column(
              children: [
                Container(
                  height: topBarHeight,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LargeBodyText('Ajanda', AppColors.successColor),
                          FutureBuilder<StudentDTO>(
                            future: _studentFuture,
                            builder: (context, studentSnapshot) {
                              if (studentSnapshot.connectionState == ConnectionState.waiting) {
                                return LoadingAnimationWidget.flickr(
                                  leftDotColor: AppColors.primaryColor,
                                  rightDotColor: AppColors.secondaryColor,
                                  size: 48,
                                );
                              } else if (studentSnapshot.hasError) {
                                return const Text('Hata');
                              } else if (!studentSnapshot.hasData) {
                                return const Text('Yok');
                              }

                              final student = studentSnapshot.data!;
                              return AgendaScreenButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SupervisorsListPopUp(
                                      supervisorsList: student.studentSupervisors
                                              ?.map((s) => s.supervisorName)
                                              .toList() ??
                                          [],
                                    ),
                                  );
                                },
                                color: AppColors.secondaryColor,
                                child: SmallBodyText('Danışmanlarım', AppColors.backgroundColor),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'İlerlemene ait bütün istatistikleri burada bulabilirsin.',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Placeholder screen — replace with your own
class DailyDetailScreen extends StatelessWidget {
  final DateTime date;
  const DailyDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detay - ${date.day}/${date.month}/${date.year}')),
      body: Center(
        child: Text('Burada detaylar olacak.'),
      ),
    );
  }
}
