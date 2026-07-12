/// ค่าคงที่ของแอปทั้งหมดรวมไว้ที่เดียว (Anti-pattern #9: ห้าม hardcode URL กระจายทั่วโค้ด)
///
/// Android Emulator ใช้ 10.0.2.2 (alias กลับมาที่เครื่อง Host)
/// iOS Simulator ใช้ 127.0.0.1 · เครื่องจริงใช้ IP วง LAN เช่น 192.168.1.50
/// override ได้ตอน build: flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8000/api/v1/
abstract final class AppConfig {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000/api/v1/',
  );

  /// Reverb WebSocket (Pusher protocol): ws://{host}:8080/app/{REVERB_APP_KEY}
  static const wsUrl = String.fromEnvironment(
    'WS_URL',
    defaultValue: 'ws://10.0.2.2:8080/app/edlgen-local-key',
  );

  /// Channel + Event ที่ Laravel broadcast (ดู app/Events/PowerReadingUpdated.php)
  static const powerChannel = 'power.readings';
  static const powerEvent = 'power.reading.updated';

  static const deviceName = 'edlgen_monitoring_app';
}
