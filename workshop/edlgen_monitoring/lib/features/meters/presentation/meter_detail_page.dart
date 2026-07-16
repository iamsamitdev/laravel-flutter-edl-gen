import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_header.dart';

/// Meter detail: ค่าที่อ่านใหญ่ + สถานะ + ค่าก่อนหน้า/ผลต่าง/ผู้บันทึก/เวลา
/// (รับค่าผ่าน route extra จากหน้า MeterPage - ข้อมูลจำลองบางส่วน)
class MeterDetailPage extends StatelessWidget {
  const MeterDetailPage({
    super.key,
    required this.meterId,
    this.meterCode = 'MTR-0042',
    this.readingKwh = 15230.5,
    this.recordedFor,
  });

  final int meterId;
  final String meterCode;
  final double readingKwh;
  final DateTime? recordedFor;

  @override
  Widget build(BuildContext context) {
    final userName = authController.user?.name ?? '-';
    final time = recordedFor ?? DateTime.now();
    final previous = readingKwh - 118.2; // ค่าก่อนหน้า (จำลองสำหรับดีไซน์)

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            title: meterCode,
            subtitle: context.tr('md_meter'),
            onBack: () => context.pop(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('md_reading'),
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        readingKwh.toStringAsFixed(1),
                        style: AppTheme.numberStyle(
                            fontSize: 36, color: Colors.white),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 7, left: 6),
                        child: Text('kWh',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14)),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          context.tr('mtr_confirm'),
                          style: const TextStyle(
                            color: AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _Row(context.tr('md_prev'),
                        '${previous.toStringAsFixed(1)} kWh'),
                    _Row(context.tr('md_diff'),
                        '+${(readingKwh - previous).toStringAsFixed(1)} kWh'),
                    _Row(context.tr('md_by'), userName),
                    _Row(context.tr('md_time'),
                        DateFormat('dd/MM/yyyy HH:00').format(time)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.numberStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
