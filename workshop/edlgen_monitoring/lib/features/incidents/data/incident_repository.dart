import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import 'models/incident.dart';

part 'incident_repository.g.dart';

/// ส่งเหตุขัดข้องเป็น multipart/form-data (มีไฟล์รูปแนบ)
class IncidentRepository {
  IncidentRepository({required this.dio});

  final Dio dio;

  Future<Incident> submitIncident({
    required int plantId,
    required String title,
    required String description,
    required String severity, // low | medium | high | critical
    required double latitude,
    required double longitude,
    required String photoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'plant_id': plantId,
        'title': title,
        'description': description,
        'severity': severity,
        'latitude': latitude,
        'longitude': longitude,
        'photo':
            await MultipartFile.fromFile(photoPath, filename: 'incident.jpg'),
      });

      final response = await dio.post('incidents', data: formData);
      return Incident.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Incident>> fetchIncidents() async {
    try {
      final response = await dio.get('incidents');
      return (response.data['data'] as List)
          .map((json) => Incident.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Incident> fetchIncident(int id) async {
    try {
      final response = await dio.get('incidents/$id');
      return Incident.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

@Riverpod(keepAlive: true)
IncidentRepository incidentRepository(Ref ref) {
  return IncidentRepository(dio: ref.watch(dioProvider));
}
