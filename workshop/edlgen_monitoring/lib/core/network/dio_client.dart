import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';

/// สร้าง Dio ตัวเดียวใช้ทั้งแอป (ดูตัวแปร global `dio` ใน app_services.dart)
Dio buildDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      // Render แผนฟรีจะ "หลับ" เมื่อไม่มีคนใช้ ตื่นครั้งแรกใช้เวลาถึง ~1 นาที
      // จึงตั้ง timeout ยาวกว่าปกติ
      connectTimeout: const Duration(seconds: 70),
      receiveTimeout: const Duration(seconds: 70),
      headers: {'Accept': 'application/json'},
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  return dio;
}
