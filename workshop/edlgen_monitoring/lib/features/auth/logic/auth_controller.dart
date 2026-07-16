import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';
import '../data/models/auth_user.dart';
import '../data/token_storage.dart';

/// สถานะ Session: unknown → (checkSession) → authenticated/unauthenticated
enum AuthStatus { unknown, authenticated, unauthenticated }

/// ตัวจัดการ Session ทั้งแอป (คลาสธรรมดา + ChangeNotifier ของ Flutter เอง)
///
/// ทำไมต้องใช้ ChangeNotifier ตรงนี้?
/// เพราะ GoRouter ต้องรู้ว่า login/logout เมื่อไหร่ เพื่อ redirect หน้าอัตโนมัติ
/// เราจึงเรียก notifyListeners() ทุกครั้งที่สถานะเปลี่ยน
/// (ส่วนภายในหน้าจอต่าง ๆ ใช้ setState ธรรมดาทั้งหมด)
class AuthController extends ChangeNotifier {
  AuthController({
    required this._repository,
    required this._tokenStorage,
  });

  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  AuthStatus status = AuthStatus.unknown;
  AuthUser? user;

  /// เรียกตอนเปิดแอป: อ่าน token จาก secure storage แล้วยืนยันกับ /me
  Future<void> checkSession() async {
    final token = await _tokenStorage.readToken();
    if (token == null) {
      status = AuthStatus.unauthenticated;
      notifyListeners();
      return;
    }
    try {
      user = await _repository.me();
      status = AuthStatus.authenticated;
    } catch (_) {
      await _tokenStorage.clear();
      status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  /// คืน true เมื่อ login สำเร็จ (หน้า Login ใช้ตัดสินใจโชว์ SnackBar)
  Future<bool> login({required String email, required String password}) async {
    try {
      final result = await _repository.login(email: email, password: password);
      await _tokenStorage.saveToken(result.token, result.expiresAt);
      user = result.user;
      status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (_) {
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
    user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
