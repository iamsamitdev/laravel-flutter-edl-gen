/// สรุปภาพรวมจาก GET /api/v1/dashboard/summary (Day 3)
class DashboardSummary {
  const DashboardSummary({
    required this.totalPowerMw,
    required this.onlinePlants,
    required this.totalPlants,
    required this.alertCount,
    this.updatedAt,
  });

  final double totalPowerMw;
  final int onlinePlants;
  final int totalPlants;
  final int alertCount;
  final DateTime? updatedAt;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalPowerMw: (json['total_power_mw'] as num).toDouble(),
      onlinePlants: json['online_plants'] as int,
      totalPlants: json['total_plants'] as int,
      alertCount: json['alert_count'] as int,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }
}
