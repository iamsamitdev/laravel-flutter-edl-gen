import 'package:dio/dio.dart';

/// แปลง DioException เป็นข้อความที่ผู้ใช้อ่านรู้เรื่อง (Day 3 Module 5)
/// กติกา: Repository จับ DioException แล้ว rethrow เป็น ApiException เสมอ
/// UI ไม่ควรเห็น DioException ดิบ ๆ
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.canRetry = true});

  final String message;
  final int? statusCode;
  final bool canRetry;

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException('เชื่อมต่อ Server ไม่ทัน กรุณาลองใหม่');
      case DioExceptionType.connectionError:
        return const ApiException(
            'เชื่อมต่อเครือข่ายไม่ได้ ตรวจสอบว่า Server ทำงานอยู่');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final serverMessage = e.response?.data is Map
            ? (e.response!.data['message'] as String?)
            : null;
        return switch (code ?? 0) {
          401 => const ApiException('Session หมดอายุ กรุณา Login ใหม่',
              statusCode: 401, canRetry: false),
          403 => const ApiException('ไม่มีสิทธิ์เข้าถึงข้อมูลนี้',
              statusCode: 403, canRetry: false),
          404 => const ApiException('ไม่พบข้อมูลที่ต้องการ', statusCode: 404),
          409 => ApiException(serverMessage ?? 'ข้อมูลซ้ำกับที่บันทึกไว้แล้ว',
              statusCode: 409, canRetry: false),
          422 => ApiException(serverMessage ?? 'ข้อมูลไม่ถูกต้อง',
              statusCode: 422, canRetry: false),
          >= 500 => const ApiException('Server ขัดข้อง กรุณาลองใหม่ภายหลัง',
              statusCode: 500),
          _ => ApiException(serverMessage ?? 'เกิดข้อผิดพลาด ($code)',
              statusCode: code),
        };
      default:
        return const ApiException('เกิดข้อผิดพลาดที่ไม่คาดคิด');
    }
  }

  @override
  String toString() => message;
}
