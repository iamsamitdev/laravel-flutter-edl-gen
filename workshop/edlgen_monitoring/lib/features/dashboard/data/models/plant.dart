/// โรงไฟฟ้าแบบย่อ จาก GET /api/v1/plants (Day 3)
class Plant {
  const Plant({
    required this.id,
    required this.name,
    required this.capacityMw,
    required this.currentOutputMw,
    required this.status,
    this.code = '',
    this.province = '',
  });

  final int id;
  final String name;
  final String code;
  final String province;
  final double capacityMw;
  final double currentOutputMw;
  final String status; // online / offline / maintenance

  bool get isOnline => status == 'online';

  double get loadFactor =>
      capacityMw == 0 ? 0 : (currentOutputMw / capacityMw) * 100;

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as int,
      name: json['name'] as String,
      code: (json['code'] as String?) ?? '',
      province: (json['province'] as String?) ?? '',
      capacityMw: (json['capacity_mw'] as num).toDouble(),
      currentOutputMw: (json['current_output_mw'] as num).toDouble(),
      status: json['status'] as String,
    );
  }
}

/// รายละเอียดโรงไฟฟ้า จาก GET /api/v1/plants/{id} (หน้า Plant Detail)
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
      frequencyHz: (json['frequency_hz'] as num).toDouble(),
      voltageKv: (json['voltage_kv'] as num).toDouble(),
      energyTodayMwh: (json['energy_today_mwh'] as num).toDouble(),
      readings: (json['readings'] as List<dynamic>)
          .map((r) => (
                outputMw: ((r as Map<String, dynamic>)['output_mw'] as num)
                    .toDouble(),
                recordedAt: DateTime.parse(r['recorded_at'] as String),
              ))
          .toList(),
    );
  }
}
