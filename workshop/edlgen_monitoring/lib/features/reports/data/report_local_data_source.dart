import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'models/daily_report.dart';

/// Cache ฝั่งเครื่องด้วย sqflite (Day 5 Feature 3)
/// เก็บ payload เป็น JSON ต่อแถว + คอลัมน์ที่ใช้ query (report_date, plant_id)
class ReportLocalDataSource {
  Database? _db;

  Future<Database> _open() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'edlgen_cache.db'),
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE daily_reports (
          id INTEGER PRIMARY KEY,
          plant_id INTEGER NOT NULL,
          report_date TEXT NOT NULL,
          payload TEXT NOT NULL,
          cached_at TEXT NOT NULL
        )
      '''),
    );
    return _db!;
  }

  Future<void> saveReports(List<DailyReport> reports) async {
    final db = await _open();
    final batch = db.batch();
    for (final r in reports) {
      batch.insert(
        'daily_reports',
        {
          'id': r.id,
          'plant_id': r.plantId,
          'report_date': r.reportDate,
          'payload': jsonEncode(r.toJson()),
          'cached_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<DailyReport>> loadReports({
    String? dateFrom,
    String? dateTo,
    int? plantId,
  }) async {
    final db = await _open();
    final where = <String>[];
    final args = <Object>[];

    if (dateFrom != null) {
      where.add('report_date >= ?');
      args.add(dateFrom);
    }
    if (dateTo != null) {
      where.add('report_date <= ?');
      args.add(dateTo);
    }
    if (plantId != null) {
      where.add('plant_id = ?');
      args.add(plantId);
    }

    final rows = await db.query(
      'daily_reports',
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args.isEmpty ? null : args,
      orderBy: 'report_date DESC',
    );

    return rows
        .map((row) => DailyReport.fromJson(
            jsonDecode(row['payload'] as String) as Map<String, dynamic>))
        .toList();
  }
}
