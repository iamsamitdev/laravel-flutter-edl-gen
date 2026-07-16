import 'package:dio/dio.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_exception.dart';
import 'models/auth_user.dart';
import 'token_storage.dart';

/// คุยกับ Laravel Sanctum บน Render:
///   POST /login   → {message, token, user}
///   GET  /me      → {user}
///   POST /logout  → {message}
/// (Server ตัวนี้ไม่มี endpoint refresh token)
class AuthRepository {
  AuthRepository({required this._dio, required this._tokenStorage});

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('login', data: {
        'email': email,
        'password': password,
        'device_name': AppConfig.deviceName,
      });

      // API นี้ส่ง token/user ที่ระดับบนสุดเลย (ไม่ห่อใน data)
      final data = response.data as Map<String, dynamic>;
      return LoginResult(
        token: data['token'] as String,
        expiresAt: data['expires_at'] as String?, // ไม่มี = token ไม่หมดอายุ
        user: AuthUser.fromJson(data['user'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AuthUser> me() async {
    try {
      final response = await _dio.get('me');
      return AuthUser.fromJson(
          response.data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> logout() async {
    await _dio.post('logout');
  }

  TokenStorage get tokenStorage => _tokenStorage;
}
