import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// โหมดสว่าง/มืด - เก็บค่าล่าสุดใน shared_preferences
/// (ไม่ใช่ข้อมูล sensitive จึงไม่ต้องใช้ flutter_secure_storage)
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'edlgen_theme_mode';

  @override
  ThemeMode build() {
    _restore();
    return ThemeMode.light;
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == 'dark') state = ThemeMode.dark;
  }

  Future<void> toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, state == ThemeMode.dark ? 'dark' : 'light');
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

/// เปิด/ปิดการแจ้งเตือน (หน้า Profile & Settings)
/// Riverpod 3: StateProvider เป็น legacy แล้ว ใช้ Notifier แทน
class NotificationsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

final notificationsEnabledProvider =
    NotifierProvider<NotificationsEnabledNotifier, bool>(
        NotificationsEnabledNotifier.new);
