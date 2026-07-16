/// โรงไฟฟ้า จาก GET /api/v1/power-plants
///
/// ตัวอย่าง JSON จาก Server จริง (Render):
/// {"id":1, "name":"Nam Ngum 1", "code":"NN1", "type":"hydro",
///  "capacity_mw":"155.00", "province":"Vientiane", "is_active":true}
///
/// ข้อสังเกต 2 จุดที่ต้องระวังตอน parse:
/// 1) capacity_mw เป็น "ตัวเลขในเครื่องหมายคำพูด" (String) → ใช้ double.parse
/// 2) ไม่มี field status/current_output_mw → แปลง is_active เป็นสถานะ
///    และให้ current_output_mw เป็น 0 เมื่อ Server ไม่ส่งมา
class Plant {
  const Plant({
    required this.id,
    required this.name,
    required this.capacityMw,
    required this.currentOutputMw,
    required this.status,
    this.type = '',
    this.code = '',
    this.province = '',
  });

  final int id;
  final String name;
  final String code;
  final String type; // hydro / solar
  final String province;
  final double capacityMw;
  final double currentOutputMw;
  final String status; // online / offline / maintenance

  bool get isOnline => status == 'online';

  double get loadFactor =>
      capacityMw == 0 ? 0 : (currentOutputMw / capacityMw) * 100;

  /// แปลงค่าที่อาจเป็น String ("155.00") หรือตัวเลข (155.0) ให้เป็น double
  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    // Server บางเวอร์ชันส่ง status มาตรง ๆ / บางเวอร์ชันส่ง is_active (bool)
    final status = (json['status'] as String?) ??
        ((json['is_active'] == true) ? 'online' : 'offline');

    return Plant(
      id: json['id'] as int,
      name: json['name'] as String,
      code: (json['code'] as String?) ?? '',
      type: (json['type'] as String?) ?? '',
      province: (json['province'] as String?) ?? '',
      capacityMw: _toDouble(json['capacity_mw']),
      currentOutputMw: _toDouble(json['current_output_mw']),
      status: status,
    );
  }
}

/// รายละเอียดโรงไฟฟ้า จาก GET /api/v1/power-plants/{id}
/// Server บน Render ยังไม่ส่งค่าไฟฟ้าละเอียด (Hz/kV/พลังงานวันนี้/กราฟ)
/// จึงให้ค่าเริ่มต้นเป็น 0 และ list ว่าง → หน้าจอแสดง "รอข้อมูล" แทน
class PlantDetail {
  const PlantDetail({
    required this.plant,
    required this.frequencyHz,
    required this.voltageKv,
    required this.energyTodayMwh,
    required this.readings,
  });

  final Plant plant;
  final double frequencyHz;
  final double voltageKv;
  final double energyTodayMwh;
  final List<({double outputMw, DateTime recordedAt})> readings;

  factory PlantDetail.fromJson(Map<String, dynamic> json) {
    return PlantDetail(
      plant: Plant.fromJson(json),
      frequencyHz: Plant._toDouble(json['frequency_hz']),
      voltageKv: Plant._toDouble(json['voltage_kv']),
      energyTodayMwh: Plant._toDouble(json['energy_today_mwh']),
      readings: ((json['readings'] as List<dynamic>?) ?? const [])
          .map((r) => (
                outputMw:
                    Plant._toDouble((r as Map<String, dynamic>)['output_mw']),
                recordedAt: DateTime.parse(r['recorded_at'] as String),
              ))
          .toList(),
    );
  }
}
