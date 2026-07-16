import 'package:dio/dio.dart';

import '../../features/auth/data/token_storage.dart';
import '../../features/auth/logic/auth_controller.dart';

/// แนบ Bearer Token ให้ทุก Request อัตโนมัติ
/// และเมื่อ Server ตอบ 401 (token ใช้ไม่ได้แล้ว) → logout พากลับหน้า Login
/// (API บน Render ไม่มี endpoint refresh token จึงไม่มีขั้นตอน retry)
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.tokenStorage,
    required this.authController,
    required this.dio,
  });

  final TokenStorage tokenStorage;
  final AuthController authController;
  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorage.readToken();
    // หน้า login ยังไม่มี token จึงไม่ต้องแนบ
    if (token != null && !options.path.contains('login')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;
    final isAuthPath = path.contains('login') || path.contains('logout');

    // 401 นอก endpoint auth = session หมดอายุ → logout
    // (GoRouter จะ redirect กลับหน้า Login ให้เอง)
    // เช็กสถานะก่อนกันการเรียก logout ซ้ำซ้อน
    if (err.response?.statusCode == 401 &&
        !isAuthPath &&
        authController.status == AuthStatus.authenticated) {
      await authController.logout();
    }
    handler.next(err);
  }
}
