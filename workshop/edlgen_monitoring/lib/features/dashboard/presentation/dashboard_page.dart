import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/skeletons.dart';
import '../../../core/widgets/status_badge.dart';
import '../../auth/logic/auth_cubit.dart';
import '../logic/dashboard_providers.dart';
import 'widgets/live_power_card.dart';
import 'widgets/power_chart.dart';

/// Dashboard (Day 3 Lab + Day 5 Feature 2):
/// greeting header + การ์ด Real-time + กราฟ 30 ค่า + รายการโรงผลิต
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plants = ref.watch(plantListProvider);
    final userName =
        context.watch<AuthCubit>().state.user?.name ?? 'Engineer';

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardSummaryProvider);
          await ref.read(plantListProvider.notifier).refresh();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientHeader(
              subtitle: context.tr('greet'),
              title: userName,
              onBellTap: () => context.push('/notifications'),
              child: const LivePowerCard(),
            ),
            // กราฟเส้น 30 ค่าล่าสุด
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('dash_chart'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      PowerChart(waitingText: context.tr('dash_waiting')),
                    ],
                  ),
                ),
              ),
            ),
            // หัวข้อรายการโรงผลิต
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.tr('dash_plants'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                  Text(
                    context.tr('dash_viewall'),
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // รายการโรงผลิต - AsyncValue 3 สถานะ (Day 3)
            plants.when(
              loading: () => const Column(
                children: [ListTileSkeleton(), ListTileSkeleton(), ListTileSkeleton()],
              ),
              error: (e, _) => ErrorBanner(
                message: '$e',
                retryLabel: context.tr('retry'),
                onRetry: () => ref.read(plantListProvider.notifier).refresh(),
              ),
              data: (list) => Column(
                children: [
                  for (final plant in list)
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: ListTile(
                        onTap: () => context.push('/dashboard/plant/${plant.id}'),
                        leading: CircleAvatar(
                          backgroundColor: plant.isOnline
                              ? const Color(0xFFDDF5E7)
                              : const Color(0xFFFDE3E4),
                          child: Icon(
                            Icons.bolt,
                            color: plant.status == 'online'
                                ? const Color(0xFF178A4C)
                                : const Color(0xFFD8232A),
                          ),
                        ),
                        title: Text(plant.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          '${plant.currentOutputMw.toStringAsFixed(1)} / '
                          '${plant.capacityMw.toStringAsFixed(0)} MW '
                          '(${plant.loadFactor.toStringAsFixed(0)}%)',
                          style: AppTheme.numberStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        trailing: StatusBadge(
                          status: PlantStatus.fromString(plant.status),
                          label: context.tr(
                              PlantStatus.fromString(plant.status).labelKey),
                        ),
                      ),
                    ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
