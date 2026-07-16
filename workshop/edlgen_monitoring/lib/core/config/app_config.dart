/// ค่าคงที่ของแอปทั้งหมดรวมไว้ที่เดียว (Anti-pattern #9: ห้าม hardcode URL กระจายทั่วโค้ด)
///
/// ค่าเริ่มต้นชี้ไป API ที่ deploy บน Render แล้ว ใช้ได้ทั้ง Emulator และเครื่องจริง
/// ถ้าอยากกลับไปทดสอบกับ Laravel ในเครื่อง override ตอน build ได้:
/// flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1/
/// (Android Emulator ใช้ 10.0.2.2 · iOS Simulator ใช้ 127.0.0.1 · เครื่องจริงใช้ IP วง LAN)
abstract final class AppConfig {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://edlgen-api.onrender.com/api/v1/',
  );

  static const deviceName = 'edlgen_monitoring_app';
}
