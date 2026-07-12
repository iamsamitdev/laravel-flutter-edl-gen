import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import 'models/meter_reading.dart';

part 'meter_repository.g.dart';

class MeterRepository {
  MeterRepository({required this.dio});

  final Dio dio;

  Future<List<MeterReading>> getTodayReadings() async {
    try {
      final response = await dio.get('meter-readings/today');
      return (response.data['data'] as List)
          .map((json) => MeterReading.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MeterReading> createReading({
    required int plantId,
    required String meterCode,
    required double readingKwh,
    required DateTime recordedFor,
  }) async {
    try {
      final response = await dio.post('meter-readings', data: {
        'plant_id': plantId,
        'meter_code': meterCode,
        'reading_kwh': readingKwh,
        // Server บังคับรูปแบบชั่วโมงเต็ม Y-m-d H:00:00
        'recorded_for':
            DateFormat('yyyy-MM-dd HH:00:00').format(recordedFor),
      });
      return MeterReading.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

@Riverpod(keepAlive: true)
MeterRepository meterRepository(Ref ref) {
  return MeterRepository(dio: ref.watch(dioProvider));
}
