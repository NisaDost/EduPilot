import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyComparisonGraph extends StatelessWidget {
  final List<int> weekTotals;

  const WeeklyComparisonGraph({super.key, required this.weekTotals});

  @override
  Widget build(BuildContext context) {
    if (weekTotals.length < 2) {
      return const Center(child: Text("Yeterli veri yok"));
    }

    final lastIndex = weekTotals.length - 1;
    final thisWeek = weekTotals[lastIndex];      // Latest week
    final lastWeek = weekTotals[lastIndex - 1];  // One week before
    final diff = thisWeek - lastWeek;

    final message = diff >= 0
        ? 'Bu hafta geçen haftaya göre $diff soru daha fazla çözdün!'
        : 'Bu hafta geçen haftaya göre ${-diff} soru daha az çözdün!';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 50, // 50% width
            child: SizedBox(
              height: 120,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        weekTotals.length,
                        (i) => FlSpot(i.toDouble(), weekTotals[i].toDouble()),
                      ),
                      isCurved: false,
                      color: AppColors.secondaryColor,
                      barWidth: 4,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          final isLast = index == weekTotals.length - 1;
                          return FlDotCirclePainter(
                            radius: 8,
                            color: isLast ? AppColors.primaryAccent : AppColors.secondaryColor,
                            strokeWidth: 2,
                            strokeColor: AppColors.backgroundColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const Expanded(flex: 15, child: SizedBox()), // 15% width
          Expanded(
            flex: 35, // 35% width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                XLargeText('$thisWeek', AppColors.textColor),
                const SizedBox(height: 4),
                MediumText(message, AppColors.titleColor, textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
