import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import '../data/token_storage.dart';
import 'auth_state.dart';

/// Cubit ดูแล Session ทั้งแอป (Day 5 Feature 1)
/// - checkSession(): เรียกตอนเปิดแอป อ่าน token จาก secure storage แล้วยืนยันกับ /auth/me
/// - login()/logout(): เปลี่ยนสถานะ + GoRouter redirect อัตโนมัติผ่าน refreshListenable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this._repository,
    required this._tokenStorage,
  })  : super(const AuthState());

  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  Future<void> checkSession() async {
    final token = await _tokenStorage.readToken();
    if (token == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }
    try {
      final user = await _repository.me();
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (_) {
      await _tokenStorage.clear();
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    try {
      final result = await _repository.login(email: email, password: password);
      await _tokenStorage.saveToken(result.token, result.expiresAt);
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.authenticated, user: result.user));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'เข้าสู่ระบบไม่สำเร็จ: ตรวจสอบอีเมลหรือรหัสผ่าน',
      ));
    }
  }

  /// คืน true เมื่อ refresh สำเร็จ (AuthInterceptor ใช้ retry request เดิม)
  Future<bool> refreshToken() async {
    try {
      final result = await _repository.refresh();
      await _tokenStorage.saveToken(result.token, result.expiresAt);
      return true;
    } catch (_) {
      await logout();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } catch (_) {
      // Server ล่มก็ยัง logout ฝั่งเครื่องได้
    }
    await _tokenStorage.clear();
    if (isClosed) return;
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
