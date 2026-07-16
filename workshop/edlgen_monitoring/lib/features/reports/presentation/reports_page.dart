import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/offline_banner.dart';
import '../../../core/widgets/skeletons.dart';
import '../../dashboard/data/models/plant.dart';
import '../data/report_repository.dart';
import 'date_range_page.dart';

/// Reports: Offline banner + filter bar + การ์ดรายงานรายวัน
/// เงื่อนไข filter (ช่วงวันที่ + โรงไฟฟ้า) เป็น state ของหน้านี้เอง
/// เปลี่ยน filter เมื่อไหร่ → เรียก _loadReports() ใหม่
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // ── เงื่อนไข filter ──
  String? _dateFrom; // 'YYYY-MM-DD'
  String? _dateTo;
  int? _plantId;

  // ── ผลลัพธ์ ──
  ReportResult? _result; // null = กำลังโหลด
  bool _hasError = false;
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
    _loadPlants();
  }

  Future<void> _loadReports() async {
    setState(() {
      _result = null;
      _hasError = false;
    });
    try {
      final result = await reportRepository.getDailyReports(
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        plantId: _plantId,
      );
      if (!mounted) return;
      setState(() => _result = result);
    } catch (_) {
      if (!mounted) return;
      setState(() => _hasError = true);
    }
  }

  Future<void> _loadPlants() async {
    try {
      final plants = await dashboardRepository.fetchPlants();
      if (!mounted) return;
      setState(() => _plants = plants);
    } catch (_) {
      // dropdown ว่างไปก่อน ไม่กระทบส่วนอื่น
    }
  }

  /// เปิดหน้าเลือกช่วงวันที่ แล้วรอรับค่ากลับมา (context.push คืนค่าได้)
  Future<void> _pickDateRange() async {
    final range = await context.push<DateRange>('/reports/date-range');
    if (range != null) {
      setState(() {
        _dateFrom = range.from;
        _dateTo = range.to;
      });
      _loadReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: context.tr('rep_title'),
            subtitle: context.tr('rep_sub'),
            onBellTap: () => context.push('/notifications'),
          ),
          // แถบ Filter: ปุ่มช่วงวันที่ + Dropdown โรงผลิต
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDateRange,
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar03, size: 18),
                    label: Text(
                      _dateFrom != null
                          ? '$_dateFrom → $_dateTo'
                          : context.tr('dr_title'),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<int?>(
                    initialValue: _plantId,
                    isDense: true,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    items: [
                      DropdownMenuItem(
                          value: null,
                          child: Text(context.tr('rep_all_plants'))),
                      for (final plant in _plants)
                        DropdownMenuItem(
                            value: plant.id, child: Text(plant.name)),
                    ],
                    onChanged: (value) {
                      setState(() => _plantId = value);
                      _loadReports();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (_hasError) {
      return ErrorBanner(
        message: context.tr('rep_error'),
        retryLabel: context.tr('retry'),
        onRetry: _loadReports,
      );
    }

    final result = _result;
    if (result == null) {
      return const Column(
        children: [
          SizedBox(height: 8),
          ListTileSkeleton(),
          ListTileSkeleton(),
          ListTileSkeleton(),
        ],
      );
    }

    return Column(
      children: [
        if (result.fromCache)
          OfflineBanner(
            title: context.tr('off_title'),
            body: context.tr('off_body'),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadReports,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              itemCount: result.reports.length,
              itemBuilder: (context, index) {
                final report = result.reports[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    title: Text(
                      '${report.plantName} · ${report.reportDate}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          _MiniStat(
                              label: context.tr('rep_energy'),
                              value:
                                  '${report.energyMwh.toStringAsFixed(0)} MWh'),
                          _MiniStat(
                              label: context.tr('rep_peak'),
                              value:
                                  '${report.peakMw.toStringAsFixed(1)} MW'),
                          _MiniStat(
                              label: context.tr('rep_water'),
                              value:
                                  '${report.waterLevelM.toStringAsFixed(1)} m'),
                        ],
                      ),
                    ),
                    trailing: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Text(value,
              style: AppTheme.numberStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              )),
        ],
      ),
    );
  }
}
