import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'status_badge.dart';

/// ระดับความรุนแรงของเหตุขัดข้อง (ตรงกับ enum severity ฝั่ง Laravel)
enum AlertSeverity {
  low('sev_low', AppColors.success, Icons.info_outline),
  medium('sev_med', AppColors.warning, Icons.warning_amber),
  high('sev_high', Color(0xFFEA7317), Icons.error_outline),
  critical('sev_crit', AppColors.critical, Icons.error);

  const AlertSeverity(this.labelKey, this.color, this.icon);

  final String labelKey;
  final Color color;
  final IconData icon;

  static AlertSeverity fromString(String value) => switch (value) {
        'low' => AlertSeverity.low,
        'medium' => AlertSeverity.medium,
        'high' => AlertSeverity.high,
        _ => AlertSeverity.critical,
      };
}

/// แถวแจ้งเตือนเหตุขัดข้อง 1 รายการ ใช้ทั้ง Dashboard และหน้าแจ้งเตือน (DRY)
class AlertTile extends StatelessWidget {
  const AlertTile({
    super.key,
    required this.title,
    required this.plantName,
    required this.time,
    required this.severity,
    required this.severityLabel,
    this.plantStatus,
    this.onTap,
  });

  final String title;
  final String plantName;
  final String time;
  final AlertSeverity severity;
  final String severityLabel; // ข้อความแปลภาษาแล้ว
  final PlantStatus? plantStatus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: severity.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(severity.icon, color: severity.color),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              plantName,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          if (plantStatus != null) ...[
            const SizedBox(width: 8),
            StatusBadge(status: plantStatus!, compact: true), // Composition
          ],
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            severityLabel,
            style: TextStyle(
              fontSize: 11,
              color: severity.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
