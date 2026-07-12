/// เหตุขัดข้อง จาก IncidentResource ฝั่ง Laravel (Day 5 Feature 4)
class Incident {
  const Incident({
    required this.id,
    required this.plantId,
    required this.title,
    required this.description,
    required this.severity,
    required this.status,
    this.plantName,
    this.latitude,
    this.longitude,
    this.photoUrl,
    this.reportedBy,
    this.occurredAt,
  });

  final int id;
  final int plantId;
  final String? plantName;
  final String title;
  final String description;
  final String severity; // low | medium | high | critical
  final String status;   // open | investigating | resolved
  final double? latitude;
  final double? longitude;
  final String? photoUrl;
  final String? reportedBy;
  final DateTime? occurredAt;

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        id: json['id'] as int,
        plantId: json['plant_id'] as int,
        plantName: json['plant_name'] as String?,
        title: json['title'] as String,
        description: (json['description'] as String?) ?? '',
        severity: json['severity'] as String,
        status: json['status'] as String,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        photoUrl: json['photo_url'] as String?,
        reportedBy: json['reported_by'] as String?,
        occurredAt: json['occurred_at'] != null
            ? DateTime.tryParse(json['occurred_at'] as String)
            : null,
      );
}
