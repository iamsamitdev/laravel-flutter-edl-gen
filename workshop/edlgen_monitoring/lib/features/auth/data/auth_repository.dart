import 'package:dio/dio.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_exception.dart';
import 'models/auth_user.dart';
import 'token_storage.dart';

/// คุยกับ Laravel Sanctum: /auth/login /auth/me /auth/refresh /auth/logout
class AuthRepository {
  AuthRepository({required this._dio, required this._tokenStorage});

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('auth/login', data: {
        'email': email,
        'password': password,
        'device_name': AppConfig.deviceName,
      });

      final data = response.data['data'] as Map<String, dynamic>;
      return LoginResult(
        token: data['token'] as String,
        expiresAt: data['expires_at'] as String?,
        user: AuthUser.fromJson(data['user'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AuthUser> me() async {
    try {
      final response = await _dio.get('auth/me');
      return AuthUser.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Token Rotation: ลบใบเดิม ออกใบใหม่ (Day 4/5)
  Future<LoginResult> refresh() async {
    final response = await _dio.post('auth/refresh');
    final data = response.data['data'] as Map<String, dynamic>;
    return LoginResult(
      token: data['token'] as String,
      expiresAt: data['expires_at'] as String?,
      user: const AuthUser(id: 0, name: '', email: ''), // refresh ไม่คืน user
    );
  }

  Future<void> logout() async {
    await _dio.post('auth/logout');
  }

  TokenStorage get tokenStorage => _tokenStorage;
}
