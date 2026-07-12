import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../logic/power_providers.dart';

/// กราฟเส้นกำลังผลิต 30 ค่าล่าสุด - เลื่อนขวาเรื่อย ๆ เมื่อมีค่าใหม่ (fl_chart)
class PowerChart extends ConsumerWidget {
  const PowerChart({super.key, this.waitingText = ''});

  final String waitingText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(powerHistoryProvider);

    if (history.isEmpty) {
      return SizedBox(
        height: 180,
        child: Center(
          child: Text(waitingText,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      );
    }

    final values = history.map((r) => r.powerMw).toList();
    final minY = (values.reduce((a, b) => a < b ? a : b) - 10).floorToDouble();
    final maxY = (values.reduce((a, b) => a > b ? a : b) + 10).ceilToDouble();

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppColors.border.withValues(alpha: 0.6),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < history.length; i++)
                  FlSpot(i.toDouble(), history[i].powerMw),
              ],
              isCurved: true,
              barWidth: 3,
              color: AppColors.primary,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}
