import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// สถานะการทำงานของโรงไฟฟ้า/เครื่องกำเนิดไฟฟ้า (Day 2 Module 5)
enum PlantStatus {
  online('st_normal', 'เดินเครื่องปกติ'),
  offline('st_offline', 'หยุดเดินเครื่อง'),
  maintenance('st_maint', 'ซ่อมบำรุง'),
  watch('st_watch', 'เฝ้าระวัง');

  const PlantStatus(this.labelKey, this.description);

  final String labelKey;    // คีย์แปลภาษาใน assets/i18n
  final String description;

  /// สีประจำสถานะ - รวม logic สีไว้ที่เดียว (DRY)
  Color get color => switch (this) {
        PlantStatus.online => AppColors.success,
        PlantStatus.offline => AppColors.critical,
        PlantStatus.maintenance => AppColors.warning,
        PlantStatus.watch => AppColors.goldDark,
      };

  static PlantStatus fromString(String value) => switch (value) {
        'online' => PlantStatus.online,
        'maintenance' => PlantStatus.maintenance,
        'watch' => PlantStatus.watch,
        _ => PlantStatus.offline,
      };
}

/// ป้ายสถานะทรงแคปซูล: จุดสี + ข้อความ ใช้ได้ทั้งใน Card, ListTile, AppBar
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    this.compact = false,
    this.label,
  });

  final PlantStatus status;
  final bool compact; // โหมดย่อ: แสดงเฉพาะจุดสี (ใช้ในพื้นที่แคบ)
  final String? label; // ข้อความ override (แปลภาษาแล้ว)

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: status.color, shape: BoxShape.circle),
    );

    if (compact) return Tooltip(message: status.description, child: dot);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // กว้างเท่าเนื้อหา ไม่กินเต็มแถว
        children: [
          dot,
          const SizedBox(width: 6),
          Text(
            label ?? status.name,
            style: TextStyle(
              color: status.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
