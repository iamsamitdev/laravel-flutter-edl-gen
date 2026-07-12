import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/alert_tile.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/skeletons.dart';
import '../../../core/widgets/status_badge.dart';
import '../../incidents/data/incident_repository.dart';
import '../../incidents/data/models/incident.dart';

/// Notifications: จัดกลุ่มวันนี้/เมื่อวาน จากรายการเหตุขัดข้องจริงใน API
/// แถว critical แตะแล้วไปหน้า incident detail (ตามดีไซน์หน้า 14)
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incidents = ref.watch(_incidentListProvider);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: context.tr('ntf_title'),
            onBack: () => context.pop(),
          ),
          Expanded(
            child: incidents.when(
              loading: () => const Column(
                children: [
                  SizedBox(height: 8),
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                ],
              ),
              error: (e, _) => ErrorBanner(
                message: '$e',
                retryLabel: context.tr('retry'),
                onRetry: () => ref.invalidate(_incidentListProvider),
              ),
              data: (list) {
                final today = <Incident>[];
                final earlier = <Incident>[];
                final now = DateTime.now();
                for (final incident in list) {
                  final at = incident.occurredAt?.toLocal();
                  if (at != null &&
                      at.year == now.year &&
                      at.month == now.month &&
                      at.day == now.day) {
                    today.add(incident);
                  } else {
                    earlier.add(incident);
                  }
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    if (today.isNotEmpty) ...[
                      _GroupHeader(context.tr('ntf_today')),
                      for (final incident in today)
                        _tile(context, incident),
                    ],
                    if (earlier.isNotEmpty) ...[
                      _GroupHeader(context.tr('ntf_yesterday')),
                      for (final incident in earlier)
                        _tile(context, incident),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, Incident incident) {
    final severity = AlertSeverity.fromString(incident.severity);
    final at = incident.occurredAt?.toLocal();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: AlertTile(
        title: incident.title,
        plantName: incident.plantName ?? '-',
        time: at != null
            ? '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}'
            : '-',
        severity: severity,
        severityLabel: context.tr(severity.labelKey),
        plantStatus:
            incident.status == 'resolved' ? PlantStatus.online : null,
        onTap: () => context.push('/incidents/${incident.id}'),
      ),
    );
  }
}

final _incidentListProvider = FutureProvider<List<Incident>>((ref) {
  return ref.watch(incidentRepositoryProvider).fetchIncidents();
});

class _GroupHeader extends StatelessWidget {
  const _GroupHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
    );
  }
}
