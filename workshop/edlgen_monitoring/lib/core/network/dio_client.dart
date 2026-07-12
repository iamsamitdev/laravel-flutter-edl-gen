import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';

/// สร้าง Dio ตัวเดียวใช้ทั้งแอป - main.dart จะ override dioProvider ด้วยตัวนี้
Dio buildDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  return dio;
}

/// Provider ของ Dio - ค่าจริงถูก override ใน main.dart
/// (สร้างที่นั่นเพราะต้องผูก AuthInterceptor ที่อ้างถึง AuthCubit)
final dioProvider = Provider<Dio>((ref) {
  throw UnimplementedError('dioProvider ต้องถูก override ใน ProviderScope');
});
