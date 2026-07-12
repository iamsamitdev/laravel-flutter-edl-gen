import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import 'models/dashboard_summary.dart';
import 'models/plant.dart';

part 'dashboard_repository.g.dart';

/// Repository ของ Dashboard - จับ DioException แล้ว rethrow เป็น ApiException
/// (UI ไม่ควรเห็น DioException ดิบ ๆ - Day 3 Module 5)
class DashboardRepository {
  DashboardRepository(this._dio);

  final Dio _dio;

  Future<DashboardSummary> fetchSummary() async {
    try {
      final response = await _dio.get('dashboard/summary');
      return DashboardSummary.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Plant>> fetchPlants({String? status}) async {
    try {
      final response = await _dio.get(
        'plants',
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
      final response = await _dio.get('plants/$id');
      return PlantDetail.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepository(ref.watch(dioProvider));
}
