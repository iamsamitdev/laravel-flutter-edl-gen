import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../logic/power_providers.dart';

/// การ์ด Real-time บน gradient header: MW ใหญ่ + ป้าย LIVE + ชิป Hz/kV/น้ำ
/// ตัวเลขขยับทุก 3 วินาทีจาก StreamProvider (Day 5 Feature 2)
class LivePowerCard extends ConsumerWidget {
  const LivePowerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(latestPowerReadingProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: live.when(
        loading: () => Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.tr('dash_waiting'),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
        error: (e, _) => Row(
          children: [
            const Icon(Icons.wifi_off, color: Colors.white70, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                context.tr('dash_ws_error'),
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
        data: (r) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.tr('dash_total'),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.5,
                    ),
                  ),
                ),
                // ป้าย LIVE จุดแดงกะพริบตามข้อมูลใหม่
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.signalRed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 3, backgroundColor: Colors.white),
                      SizedBox(width: 5),
                      Text('LIVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  r.powerMw.toStringAsFixed(1),
                  style: AppTheme.numberStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(width: 6),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('MW',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _MetricChip(
                    label: context.tr('dash_freq'),
                    value: '${r.frequency.toStringAsFixed(2)} Hz'),
                const SizedBox(width: 8),
                _MetricChip(
                    label: context.tr('dash_volt'),
                    value: '${r.voltageKv.toStringAsFixed(1)} kV'),
                const SizedBox(width: 8),
                _MetricChip(label: context.tr('dash_water'), value: '198.4 m'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7), fontSize: 10.5),
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(value,
                style: AppTheme.numberStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
