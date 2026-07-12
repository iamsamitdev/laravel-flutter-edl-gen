import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// เก็บ Sanctum Token ใน Secure Storage (Android Keystore / iOS Keychain)
/// Anti-pattern #3: ห้ามเก็บ Token ใน shared_preferences เด็ดขาด
class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'edlgen_access_token';
  static const _expiresKey = 'edlgen_token_expires_at';

  Future<void> saveToken(String token, [String? expiresAt]) async {
    await _storage.write(key: _tokenKey, value: token);
    if (expiresAt != null) {
      await _storage.write(key: _expiresKey, value: expiresAt);
    }
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<DateTime?> readExpiresAt() async {
    final raw = await _storage.read(key: _expiresKey);
    return raw != null ? DateTime.tryParse(raw) : null;
  }

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiresKey);
  }
}
