import 'dart:typed_data';

/// รูปที่ถ่าย/เลือกจาก CameraPage ส่งกลับให้หน้าฟอร์ม
/// เก็บเป็น bytes (ไม่ใช่ path) เพื่อให้ทำงานได้ทั้ง Mobile/Desktop/Web
class CapturedPhoto {
  const CapturedPhoto({required this.bytes, required this.name});

  final Uint8List bytes;
  final String name;
}
