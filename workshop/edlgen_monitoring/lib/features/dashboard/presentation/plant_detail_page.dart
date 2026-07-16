import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../data/models/plant.dart';

/// Plant detail: การ์ด output + ค่าสด + พลังงานวันนี้/ความพร้อมจ่าย + กราฟ
/// โหลดข้อมูลใน initState แล้ว setState (pattern เดียวกับทุกหน้า)
class PlantDetailPage extends StatefulWidget {
  const PlantDetailPage({super.key, required this.plantId});

  final int plantId;

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  PlantDetail? _detail; // null = กำลังโหลด
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _detail = null;
      _error = null;
    });
    try {
      final detail =
          await dashboardRepository.fetchPlantDetail(widget.plantId);
      if (!mounted) return;
      setState(() => _detail = detail);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_error != null) {
      return SafeArea(
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon:
                    const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft02),
              ),
            ),
            ErrorBanner(
              message: _error!,
              retryLabel: context.tr('retry'),
              onRetry: _load,
            ),
          ],
        ),
      );
    }

    final d = _detail;
    if (d == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientHeader(
              title: d.plant.name,
              subtitle: d.plant.province,
              onBack: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.tr('pd_output'),
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12)),
                          Text(
                            '${d.plant.currentOutputMw.toStringAsFixed(1)} MW',
                            style: AppTheme.numberStyle(
                                fontSize: 32, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(
                      status: PlantStatus.fromString(d.plant.status),
                      label: context
                          .tr(PlantStatus.fromString(d.plant.status).labelKey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: StatCard(
                            title: context.tr('pd_energy_today'),
                            value: d.energyTodayMwh.toStringAsFixed(0),
                            unit: 'MWh',
                            icon: HugeIcons.strokeRoundedBatteryCharging01,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: StatCard(
                            title: context.tr('pd_uptime'),
                            value: d.plant.loadFactor.toStringAsFixed(0),
                            unit: '%',
                            icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: StatCard(
                            title: context.tr('dash_freq'),
                            value: d.frequencyHz.toStringAsFixed(2),
                            unit: 'Hz',
                            icon: HugeIcons.strokeRoundedDashboardSpeed01,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: StatCard(
                            title: context.tr('dash_volt'),
                            value: d.voltageKv.toStringAsFixed(1),
                            unit: 'kV',
                            icon: HugeIcons.strokeRoundedPlug01,
                            color: AppColors.goldDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(context.tr('dash_chart'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: 180,
                        child: d.readings.isEmpty
                            ? Center(child: Text(context.tr('dash_waiting')))
                            : LineChart(
                                LineChartData(
                                  gridData:
                                      const FlGridData(drawVerticalLine: false),
                                  borderData: FlBorderData(show: false),
                                  titlesData: const FlTitlesData(
                                    topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: [
                                        for (var i = 0;
                                            i < d.readings.length;
                                            i++)
                                          FlSpot(
                                              i.toDouble(),
                                              d.readings[
                                                      d.readings.length - 1 - i]
                                                  .outputMw),
                                      ],
                                      isCurved: true,
                                      barWidth: 3,
                                      color: AppColors.primary,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: AppColors.primary
                                            .withValues(alpha: 0.12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
