/// ผู้ใช้ที่ล็อกอินอยู่ (จาก UserResource ฝั่ง Laravel)
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.role = 'operator',
  });

  final int id;
  final String name;
  final String email;
  final String role; // operator | supervisor

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        role: (json['role'] as String?) ?? 'operator',
      );
}

/// ผลลัพธ์การ Login: token + วันหมดอายุ + ข้อมูลผู้ใช้
class LoginResult {
  const LoginResult({required this.token, required this.user, this.expiresAt});

  final String token;
  final AuthUser user;
  final String? expiresAt;
}
