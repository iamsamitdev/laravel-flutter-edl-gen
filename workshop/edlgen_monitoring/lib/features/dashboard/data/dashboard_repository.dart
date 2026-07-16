import 'package:dio/dio.dart';

import '../../../core/network/api_exception.dart';
import 'models/plant.dart';

/// Repository ของ Dashboard - จับ DioException แล้ว rethrow เป็น ApiException
/// (UI ไม่ควรเห็น DioException ดิบ ๆ - Day 3 Module 5)
/// Endpoint บน Render: GET power-plants / GET power-plants/{id}
class DashboardRepository {
  DashboardRepository(this._dio);

  final Dio _dio;

  Future<List<Plant>> fetchPlants({String? status}) async {
    try {
      final response = await _dio.get(
        'power-plants',
        queryParameters: {'status': ?status},
      );
      final items = response.data['data'] as List<dynamic>;
      return items
          .map((item) => Plant.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PlantDetail> fetchPlantDetail(int id) async {
    try {
      final response = await _dio.get('power-plants/$id');
      return PlantDetail.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
