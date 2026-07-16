import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/alert_tile.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../data/models/incident.dart';

/// Incident detail: badge สถานะ + รูป + ตารางข้อมูล + timeline 4 ขั้น
/// โหลดข้อมูลใน initState แล้ว setState
class IncidentDetailPage extends StatefulWidget {
  const IncidentDetailPage({super.key, required this.incidentId});

  final int incidentId;

  @override
  State<IncidentDetailPage> createState() => _IncidentDetailPageState();
}

class _IncidentDetailPageState extends State<IncidentDetailPage> {
  Incident? _incident; // null = กำลังโหลด
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _incident = null;
      _error = null;
    });
    try {
      final incident =
          await incidentRepository.fetchIncident(widget.incidentId);
      if (!mounted) return;
      setState(() => _incident = incident);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
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

    final inc = _incident;
    if (inc == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final severity = AlertSeverity.fromString(inc.severity);
    final statusIndex = switch (inc.status) {
      'open' => 0,
      'investigating' => 2,
      _ => 3,
    };
    return ListView(
            padding: EdgeInsets.zero,
            children: [
              GradientHeader(
                title: inc.title,
                subtitle: '#INC-${inc.id.toString().padLeft(4, '0')}',
                onBack: () => context.pop(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge ความรุนแรง + สถานะ
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 4),
                          decoration: BoxDecoration(
                            color: severity.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            context.tr(severity.labelKey),
                            style: TextStyle(
                              color: severity.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.infoBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            inc.status,
                            style: const TextStyle(
                              color: AppColors.info,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // รูปแนบ
                    if (inc.photoUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          inc.photoUrl!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            height: 180,
                            color: AppColors.border,
                            child: const Center(
                              child: HugeIcon(
                                  icon:
                                      HugeIcons.strokeRoundedImageNotFound01),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    // ตารางข้อมูล
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _InfoRow(context.tr('det_plant'),
                                inc.plantName ?? '-'),
                            _InfoRow(
                                context.tr('det_by'), inc.reportedBy ?? '-'),
                            _InfoRow(
                              context.tr('det_time'),
                              inc.occurredAt != null
                                  ? DateFormat('dd/MM/yyyy HH:mm')
                                      .format(inc.occurredAt!.toLocal())
                                  : '-',
                            ),
                            _InfoRow(
                              context.tr('det_coord'),
                              inc.latitude != null
                                  ? '${inc.latitude!.toStringAsFixed(4)}, ${inc.longitude!.toStringAsFixed(4)}'
                                  : '-',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(context.tr('f_desc'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 6),
                    Text(inc.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    Text(context.tr('det_timeline'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 12),
                    // Timeline 4 ขั้น: Reported → Acknowledged → In progress → Resolved
                    for (final (i, key) in [
                      'tl_reported',
                      'tl_ack',
                      'tl_prog',
                      'tl_resolved',
                    ].indexed)
                      _TimelineStep(
                        label: context.tr(key),
                        done: i <= statusIndex,
                        isLast: i == 3,
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13.5)),
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep(
      {required this.label, required this.done, required this.isLast});

  final String label;
  final bool done;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = done ? AppColors.success : AppColors.textSubtle;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              HugeIcon(
                icon: done
                    ? HugeIcons.strokeRoundedCheckmarkCircle02
                    : HugeIcons.strokeRoundedCircle,
                size: 20,
                color: color,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: done
                        ? AppColors.success.withValues(alpha: 0.4)
                        : AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: done ? FontWeight.w600 : FontWeight.w400,
                color: done
                    ? Theme.of(context).textTheme.bodyMedium?.color
                    : AppColors.textSubtle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
