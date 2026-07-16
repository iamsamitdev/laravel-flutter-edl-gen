import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/auth_repository.dart';
import '../features/auth/data/token_storage.dart';
import '../features/auth/logic/auth_controller.dart';
import '../features/dashboard/data/dashboard_repository.dart';
import '../features/incidents/data/incident_repository.dart';
import '../features/meters/data/meter_repository.dart';
import '../features/reports/data/report_local_data_source.dart';
import '../features/reports/data/report_repository.dart';
import 'network/dio_client.dart';

/// ═══════════════════════════════════════════════════════════════
/// ศูนย์รวม "ของใช้ส่วนกลาง" ของทั้งแอป (ตัวแปร global ธรรมดา)
///
/// แนวคิดสำหรับมือใหม่:
/// - ทั้งแอปมี Dio ตัวเดียว, Repository อย่างละตัว → ประกาศเป็น
///   ตัวแปร global ไว้ที่นี่ที่เดียว หน้าไหนอยากใช้ก็ import ไฟล์นี้
/// - ไม่ต้องมี Provider/Bloc/DI ใด ๆ ทั้งสิ้น
/// - ตัวแปร final ระดับบนสุดของ Dart จะถูกสร้าง "ครั้งแรกที่ถูกเรียกใช้"
///   (lazy) จึงเรียงลำดับตามนี้ได้เลย
/// ═══════════════════════════════════════════════════════════════

/// เก็บ token ใน secure storage
final tokenStorage = TokenStorage();

/// HTTP client ตัวเดียวใช้ทั้งแอป (main.dart จะแนบ AuthInterceptor ให้)
final dio = buildDioClient();

/// คุยกับ API ส่วน auth (login / me / refresh / logout)
final authRepository = AuthRepository(dio: dio, tokenStorage: tokenStorage);

/// สถานะ login ของทั้งแอป (GoRouter ฟังตัวนี้เพื่อ redirect)
final authController = AuthController(
  repository: authRepository,
  tokenStorage: tokenStorage,
);

/// Repository ของแต่ละฟีเจอร์
final dashboardRepository = DashboardRepository(dio);
final incidentRepository = IncidentRepository(dio: dio);
final meterRepository = MeterRepository(dio: dio);
final reportRepository = ReportRepository(
  dio: dio,
  local: ReportLocalDataSource(),
);

/// ═══════════════════════════════════════════════════════════════
/// โหมดสว่าง/มืด ของทั้งแอป
///
/// ใช้ ValueNotifier (ของ Flutter เอง ไม่ใช่ package) เพราะ MaterialApp
/// อยู่บนสุดของแอป ต้อง rebuild เมื่อผู้ใช้กดสลับโหมดจากหน้า Profile
/// - อ่านค่า:   themeModeNotifier.value
/// - เปลี่ยนค่า: เรียก toggleThemeMode()
/// ═══════════════════════════════════════════════════════════════
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

const _themePrefsKey = 'edlgen_theme_mode';

/// เรียกครั้งเดียวตอนเปิดแอป: อ่านค่าที่เคยบันทึกไว้
Future<void> restoreThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString(_themePrefsKey) == 'dark') {
    themeModeNotifier.value = ThemeMode.dark;
  }
}

/// สลับ สว่าง ↔ มืด แล้วบันทึกลง shared_preferences
Future<void> toggleThemeMode() async {
  final isDark = themeModeNotifier.value == ThemeMode.dark;
  themeModeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_themePrefsKey, isDark ? 'light' : 'dark');
}
