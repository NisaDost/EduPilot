import 'package:edupilot/models/dtos/solved_question_count_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/agenda/widgets/agenda_header.dart';
import 'package:edupilot/screens/agenda/widgets/weak_subjects_container.dart';
import 'package:edupilot/screens/agenda/widgets/weekly_comparison_graph.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key ,required this.onNavigateToAddQuestion, required this.onNavigateToDailyAnalysys});

  final VoidCallback onNavigateToAddQuestion;
  final void Function(DateTime date) onNavigateToDailyAnalysys;

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
    for (int i = 0; i < 5; i++) {
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
    final DateTime normalizedStart = DateTime(
      _selectedWeek['start'].year,
      _selectedWeek['start'].month,
      _selectedWeek['start'].day,
    );

    final DateTime normalizedEnd = DateTime(
      _selectedWeek['end'].year,
      _selectedWeek['end'].month,
      _selectedWeek['end'].day,
    );

    return StudentsApiHandler().getSolvedQuestionCountPerWeek(
      normalizedStart,
      normalizedEnd,
    );
  }

  Future<List<int>> _fetchWeekTotals() async {
    List<int> totals = [];
    for (var week in _weeks.reversed) {
      final normalizedStart = DateTime(week['start'].year, week['start'].month, week['start'].day);
      final normalizedEnd = DateTime(week['end'].year, week['end'].month, week['end'].day);
      final data = await StudentsApiHandler().getSolvedQuestionCountPerWeek(
        normalizedStart,
        normalizedEnd,
      );
      final total = data.fold(0, (sum, item) => sum + item.count);
      totals.add(total);
    }
    return totals;
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 4,
                              offset: const Offset(4, 4),
                            ),
                          ],
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
                                final isToday = currentDay.year == today.year &&
                                    currentDay.month == today.month &&
                                    currentDay.day == today.day;
                                final isFuture = currentDay.isAfter(today);
                                final count = isFuture ? '-' : (dateToCount[formattedDate]?.toString() ?? '0');

                                final bgColor = isToday
                                    ? AppColors.primaryAccent
                                    : AppColors.backgroundAccent;

                                final topColor = isToday
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryColor;

                                return GestureDetector(
                                  onTap: isFuture
                                      ? null
                                      : () => widget.onNavigateToDailyAnalysys(currentDay),
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
                                            borderRadius: const BorderRadius.all(Radius.circular(12))
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Center(
                                            child: Text(
                                              weekdays[index],
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: isToday ? AppColors.primaryAccent : AppColors.backgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6, bottom: 10),
                                          child: Text(
                                            count,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: isToday ? AppColors.backgroundColor : AppColors.titleColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 8),
                            FutureBuilder<List<int>>(
                              future: _fetchWeekTotals(),
                              builder: (context, graphSnapshot) {
                                if (graphSnapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (graphSnapshot.hasError || !graphSnapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                return WeeklyComparisonGraph(weekTotals: graphSnapshot.data!);
                              },
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: AgendaScreenButton(
                                onPressed: widget.onNavigateToAddQuestion, 
                                color: AppColors.secondaryColor,
                                child: LargeText('Çözdüğün Soru Sayısını Gir', AppColors.backgroundColor), 
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      WeakSubjectsContainer()
                    ],
                  ),
                ),
              ),
            ),
            AgendaHeader(studentFuture: _studentFuture),
          ],
        );
      },
    );
  }
}
