import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_services.dart';
import '../../../core/widgets/alert_tile.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/skeletons.dart';
import '../../../core/widgets/status_badge.dart';
import '../../incidents/data/models/incident.dart';

/// Notifications: จัดกลุ่มวันนี้/เมื่อวาน จากรายการเหตุขัดข้องจริงใน API
/// โหลดข้อมูลใน initState แล้ว setState
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Incident>? _incidents; // null = กำลังโหลด
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _incidents = null;
      _error = null;
    });
    try {
      final incidents = await incidentRepository.fetchIncidents();
      if (!mounted) return;
      setState(() => _incidents = incidents);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: context.tr('ntf_title'),
            onBack: () => context.pop(),
          ),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (_error != null) {
      return ErrorBanner(
        message: _error!,
        retryLabel: context.tr('retry'),
        onRetry: _load,
      );
    }

    final list = _incidents;
    if (list == null) {
      return const Column(
        children: [
          SizedBox(height: 8),
          ListTileSkeleton(),
          ListTileSkeleton(),
          ListTileSkeleton(),
        ],
      );
    }

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
          for (final incident in today) _tile(context, incident),
        ],
        if (earlier.isNotEmpty) ...[
          _GroupHeader(context.tr('ntf_yesterday')),
          for (final incident in earlier) _tile(context, incident),
        ],
      ],
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
        onTap: () => context.push('/incidents/detail/${incident.id}'),
      ),
    );
  }
}

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
