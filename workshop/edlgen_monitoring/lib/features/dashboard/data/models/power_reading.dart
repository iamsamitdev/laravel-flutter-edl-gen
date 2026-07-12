/// ค่าการผลิตสด 1 ค่า จาก Reverb broadcast (event: power.reading.updated)
class PowerReading {
  const PowerReading({
    required this.plantId,
    required this.plantName,
    required this.powerMw,
    required this.frequency,
    required this.voltageKv,
    required this.recordedAt,
  });

  final int plantId;
  final String plantName;
  final double powerMw;
  final double frequency;
  final double voltageKv;
  final DateTime recordedAt;

  factory PowerReading.fromJson(Map<String, dynamic> json) {
    return PowerReading(
      plantId: json['plant_id'] as int,
      plantName: json['plant_name'] as String,
      // cast ผ่าน num กัน TypeError กรณี server ส่ง int มา
      powerMw: (json['power_mw'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      voltageKv: (json['voltage_kv'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
    );
  }
}
