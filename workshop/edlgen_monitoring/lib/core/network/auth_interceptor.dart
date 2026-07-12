import 'package:dio/dio.dart';

import '../../features/auth/data/token_storage.dart';
import '../../features/auth/logic/auth_cubit.dart';

/// แนบ Bearer Token ทุก Request + auto-refresh เมื่อเจอ 401 (retry ครั้งเดียว)
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.tokenStorage,
    required this.authCubit,
    required this.dio,
  });

  final TokenStorage tokenStorage;
  final AuthCubit authCubit;
  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorage.readToken();
    if (token != null && !options.path.contains('auth/login')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final isRetry = err.requestOptions.extra['retried'] == true;
    final isAuthPath = err.requestOptions.path.contains('auth/');

    if (err.response?.statusCode == 401 && !isRetry && !isAuthPath) {
      final refreshed = await authCubit.refreshToken();
      if (refreshed) {
        final newToken = await tokenStorage.readToken();
        final opts = err.requestOptions
          ..headers['Authorization'] = 'Bearer $newToken'
          ..extra['retried'] = true;
        try {
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      }
    }
    handler.next(err);
  }
}
