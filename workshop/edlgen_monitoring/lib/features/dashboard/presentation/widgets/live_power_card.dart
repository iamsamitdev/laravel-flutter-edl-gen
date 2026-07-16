import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/power_reading.dart';

/// การ์ด Real-time บน gradient header: MW ใหญ่ + ป้าย LIVE + ชิป Hz/kV/น้ำ
/// เป็น StatelessWidget รับข้อมูลจาก DashboardPage
/// (ค่ามาจากตัวจำลองในแอป - Timer สุ่มค่าทุก 3 วินาที)
/// - reading == null → กำลังรอค่าแรก
class LivePowerCard extends StatelessWidget {
  const LivePowerCard({super.key, this.reading});

  final PowerReading? reading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // สถานะกำลังรอข้อมูลค่าแรก
    final r = reading;
    if (r == null) {
      return Row(
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.tr('dash_waiting'),
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      );
    }

    // สถานะมีข้อมูล
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
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
