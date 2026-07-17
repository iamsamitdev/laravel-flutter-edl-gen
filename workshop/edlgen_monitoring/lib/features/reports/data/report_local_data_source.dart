import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/daily_report.dart';

/// Cache ฝั่งเครื่องด้วย SharedPreferences (Day 5 Feature 3)
/// เก็บ report ทั้งหมดเป็น JSON list เดียวใน key เดียว
/// (เปลี่ยนจาก sqflite → SharedPreferences เพราะ sqflite ไม่รองรับ Flutter Web
/// ทำให้หน้า Reports พังตอนรันบน website)
class ReportLocalDataSource {
  static const _cacheKey = 'edlgen_reports_cache';

  Future<void> saveReports(List<DailyReport> reports) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await _readAll(prefs);

    // แทนที่รายการเดิมที่ id ตรงกัน ที่เหลือเก็บไว้เหมือนเดิม
    final byId = {for (final r in existing) r.id: r};
    for (final r in reports) {
      byId[r.id] = r;
    }

    final merged = byId.values.toList()
      ..sort((a, b) => b.reportDate.compareTo(a.reportDate));

    await prefs.setString(
      _cacheKey,
      jsonEncode(merged.map((r) => r.toJson()).toList()),
    );
  }

  Future<List<DailyReport>> loadReports({
    String? dateFrom,
    String? dateTo,
    int? plantId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final all = await _readAll(prefs);

    return all.where((r) {
      if (dateFrom != null && r.reportDate.compareTo(dateFrom) < 0) {
        return false;
      }
      if (dateTo != null && r.reportDate.compareTo(dateTo) > 0) return false;
      if (plantId != null && r.plantId != plantId) return false;
      return true;
    }).toList();
  }

  Future<List<DailyReport>> _readAll(SharedPreferences prefs) async {
    final raw = prefs.getString(_cacheKey);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List;
    return list
        .map((json) => DailyReport.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
