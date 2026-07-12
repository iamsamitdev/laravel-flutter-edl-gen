import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/offline_banner.dart';
import '../../../core/widgets/skeletons.dart';
import '../../dashboard/logic/dashboard_providers.dart';
import '../logic/report_providers.dart';

/// Reports (Day 5 Feature 3): Offline banner + filter bar + การ์ดรายงานรายวัน
class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(dailyReportsProvider);
    final filter = ref.watch(reportFilterStateProvider);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: context.tr('rep_title'),
            subtitle: context.tr('rep_sub'),
            onBellTap: () => context.push('/notifications'),
          ),
          _FilterBar(filter: filter),
          Expanded(
            child: reportsAsync.when(
              loading: () => const Column(
                children: [
                  SizedBox(height: 8),
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                ],
              ),
              error: (e, _) => ErrorBanner(
                message: context.tr('rep_error'),
                retryLabel: context.tr('retry'),
                onRetry: () =>
                    ref.read(dailyReportsProvider.notifier).refresh(),
              ),
              data: (result) => Column(
                children: [
                  if (result.fromCache)
                    OfflineBanner(
                      title: context.tr('off_title'),
                      body: context.tr('off_body'),
                    ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          ref.read(dailyReportsProvider.notifier).refresh(),
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
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// แถบ Filter: ปุ่มช่วงวันที่ + Dropdown โรงผลิต
class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.filter});

  final ReportFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plants = ref.watch(plantListProvider).value ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => context.push('/reports/date-range'),
              icon: const Icon(Icons.calendar_month, size: 18),
              label: Text(
                filter.dateFrom != null
                    ? '${filter.dateFrom} → ${filter.dateTo}'
                    : context.tr('dr_title'),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<int?>(
              initialValue: filter.plantId,
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
                    value: null, child: Text(context.tr('rep_all_plants'))),
                for (final plant in plants)
                  DropdownMenuItem(value: plant.id, child: Text(plant.name)),
              ],
              onChanged: (value) => ref
                  .read(reportFilterStateProvider.notifier)
                  .setPlant(value),
            ),
          ),
        ],
      ),
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
