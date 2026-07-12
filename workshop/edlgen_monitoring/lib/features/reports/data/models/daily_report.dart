/// รายงานการผลิตรายวัน จาก GET /api/v1/reports/daily (Day 5 Feature 3)
/// ต้องมี toJson ด้วย เพราะถูกเก็บลง sqflite เป็น payload JSON
class DailyReport {
  const DailyReport({
    required this.id,
    required this.plantId,
    required this.plantName,
    required this.reportDate,
    required this.energyMwh,
    required this.peakMw,
    required this.availability,
    required this.waterLevelM,
  });

  final int id;
  final int plantId;
  final String plantName;
  final String reportDate; // 'YYYY-MM-DD'
  final double energyMwh;
  final double peakMw;
  final double availability;
  final double waterLevelM;

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        id: json['id'] as int,
        plantId: json['plant_id'] as int,
        plantName: json['plant_name'] as String,
        reportDate: json['report_date'] as String,
        energyMwh: (json['energy_mwh'] as num).toDouble(),
        peakMw: (json['peak_mw'] as num).toDouble(),
        availability: (json['availability'] as num).toDouble(),
        waterLevelM: (json['water_level_m'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'plant_id': plantId,
        'plant_name': plantName,
        'report_date': reportDate,
        'energy_mwh': energyMwh,
        'peak_mw': peakMw,
        'availability': availability,
        'water_level_m': waterLevelM,
      };
}
