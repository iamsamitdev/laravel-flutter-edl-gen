/// ค่ามิเตอร์ 1 รายการ (Day 5 Feature 5)
/// isPending = true คือรายการ Optimistic ที่ยังรอ Server ยืนยัน (id ติดลบ)
class MeterReading {
  const MeterReading({
    required this.id,
    required this.plantId,
    required this.meterCode,
    required this.readingKwh,
    required this.recordedFor,
    this.isPending = false,
  });

  final int id;
  final int plantId;
  final String meterCode;
  final double readingKwh;
  final DateTime recordedFor;
  final bool isPending;

  factory MeterReading.fromJson(Map<String, dynamic> json) => MeterReading(
        id: json['id'] as int,
        plantId: json['plant_id'] as int,
        meterCode: json['meter_code'] as String,
        readingKwh: (json['reading_kwh'] as num).toDouble(),
        recordedFor: DateTime.parse(json['recorded_for'] as String),
      );
}
