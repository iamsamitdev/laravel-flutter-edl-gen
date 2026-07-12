import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// การ์ดแสดงค่าสถิติ 1 ค่า เช่น กำลังผลิตรวม (MW), ความถี่ระบบ (Hz)
/// generic พอที่ Dashboard และหน้ารายงานใช้ตัวเดียวกันได้ (Day 2 Module 5)
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    this.color,
    this.trend, // ค่า % เปลี่ยนแปลง เช่น +2.4 หรือ -1.1 (null = ไม่แสดง)
    this.onTap, // แตะการ์ดเพื่อดูรายละเอียด (null = แตะไม่ได้)
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color? color;
  final double? trend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = color ?? theme.colorScheme.primary;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // แถวบน: ไอคอนในวงกลมสีจาง + ชื่อค่า
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 20, color: accent),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis, // กัน overflow บนจอแคบ
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // แถวล่าง: ตัวเลขใหญ่ (ฟอนต์ Inter เสมอ) + หน่วย + แนวโน้ม
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: AppTheme.numberStyle(
                        fontSize: 24,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(unit, style: theme.textTheme.bodySmall),
                  ),
                  const Spacer(),
                  if (trend != null) _TrendChip(trend: trend!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ชิปแสดงแนวโน้มขึ้น/ลง - private widget ประกอบภายใน (Composition)
class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.trend});

  final double trend;

  @override
  Widget build(BuildContext context) {
    final up = trend >= 0;
    final color = up ? AppColors.success : AppColors.critical;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(up ? Icons.trending_up : Icons.trending_down, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          '${up ? '+' : ''}${trend.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
