import 'package:dio/dio.dart';

import 'models/daily_report.dart';
import 'report_local_data_source.dart';

/// ผลลัพธ์พร้อม flag ว่ามาจาก Cache หรือไม่ (ใช้โชว์ Offline banner)
class ReportResult {
  const ReportResult({required this.reports, required this.fromCache});

  final List<DailyReport> reports;
  final bool fromCache;
}

/// กลยุทธ์ API-first: ดึงจาก Server ก่อนเสมอ + เขียนทับ Cache
/// ถ้า network ล้ม → fallback อ่านจาก sqflite (Day 5 Feature 3)
class ReportRepository {
  ReportRepository({required this.dio, required this.local});

  final Dio dio;
  final ReportLocalDataSource local;

  Future<ReportResult> getDailyReports({
    String? dateFrom,
    String? dateTo,
    int? plantId,
  }) async {
    try {
      final response = await dio.get('reports/daily', queryParameters: {
        'date_from': ?dateFrom,
        'date_to': ?dateTo,
        'plant_id': ?plantId,
      });

      final reports = (response.data['data'] as List)
          .map((json) => DailyReport.fromJson(json as Map<String, dynamic>))
          .toList();

      await local.saveReports(reports);
      return ReportResult(reports: reports, fromCache: false);
    } on DioException {
      final cached = await local.loadReports(
          dateFrom: dateFrom, dateTo: dateTo, plantId: plantId);
      if (cached.isEmpty) rethrow;
      return ReportResult(reports: cached, fromCache: true);
    }
  }
}
