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
import 'package:intl/intl.dart';

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
      _weeks.add({'label': label, 'start': monday, 'end': sunday});
    }
    _selectedWeek = _weeks[0];
  }

  DateTime getStartOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));
  DateTime getEndOfWeek(DateTime startOfWeek) =>
      startOfWeek.add(const Duration(days: 6));

  String formatDate(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date);

  Future<List<SolvedQuestionCountDTO>> _fetchWeekData() {
    return StudentsApiHandler().getSolvedQuestionCountPerWeek(
      _selectedWeek['start'],
      _selectedWeek['end'],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 112;
    final DateTime today = DateTime.now();
    final weekdays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cts', 'Paz'];

    return FutureBuilder<List<SolvedQuestionCountDTO>>(
      future: _fetchWeekData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Veri bulunamadı.'));
        }

        final solvedCounts = snapshot.data!;
        Map<String, int> dateToCount = {};
        for (var dto in solvedCounts) {
          final key = formatDate(dto.entryDate);
          dateToCount[key] = (dateToCount[key] ?? 0) + dto.count;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.backgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LargeText('Haftalık Soru Sayısı', AppColors.textColor),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.primaryAccent,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Map<String, dynamic>>(
                                  borderRadius: BorderRadius.circular(16),
                                  isExpanded: true,
                                  value: _selectedWeek,
                                  dropdownColor: AppColors.primaryAccent,
                                  iconEnabledColor: AppColors.backgroundColor,
                                  style: TextStyle(color: AppColors.backgroundColor),
                                  items: _weeks.map((week) {
                                    return DropdownMenuItem<Map<String, dynamic>>(
                                      value: week,
                                      child: MediumBodyText(
                                        week['label'],
                                        AppColors.backgroundColor,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newWeek) {
                                    if (newWeek != null) {
                                      setState(() => _selectedWeek = newWeek);
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(7, (index) {
                                final currentDay = _selectedWeek['start'].add(Duration(days: index));
                                final formattedDate = formatDate(currentDay);
                                final isToday = formattedDate == formatDate(today);
                                final isFuture = currentDay.isAfter(today);
                                final count = isFuture ? '-' : (dateToCount[formattedDate]?.toString() ?? '-');

                                final bgColor = isToday
                                    ? AppColors.primaryColor
                                    : AppColors.backgroundAccent;

                                final topColor = isToday
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryAccent;

                                return GestureDetector(
                                  onTap: isFuture
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DailyDetailScreen(date: currentDay),
                                            ),
                                          );
                                        },
                                  child: Container(
                                    width: 48,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: bgColor,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: topColor,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Center(
                                            child: Text(
                                              weekdays[index],
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.backgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Text(
                                            '$count',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.titleColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Top bar
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
                          } else if (studentSnapshot.hasError || !studentSnapshot.hasData) {
                            return const Text('Danışman bulunamadı');
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
        );
      },
    );
  }
}

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
