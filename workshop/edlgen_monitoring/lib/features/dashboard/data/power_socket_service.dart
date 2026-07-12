import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/config/app_config.dart';
import 'models/power_reading.dart';

/// เชื่อม Reverb ด้วย Pusher protocol (Day 5 Feature 2)
/// 1) เปิด WebSocket ไปที่ ws://host:8080/app/{APP_KEY}
/// 2) ส่ง pusher:subscribe ระบุ channel
/// 3) กรองเฉพาะ event ของเรา แล้ว decode data (ซ้อน JSON string 2 ชั้น)
class PowerSocketService {
  Stream<PowerReading> connect() {
    final channel = WebSocketChannel.connect(Uri.parse(AppConfig.wsUrl));

    channel.sink.add(jsonEncode({
      'event': 'pusher:subscribe',
      'data': {'channel': AppConfig.powerChannel},
    }));

    return channel.stream
        .map((raw) => jsonDecode(raw as String) as Map<String, dynamic>)
        .where((msg) => msg['event'] == AppConfig.powerEvent)
        .map((msg) {
      // Pusher ห่อ 'data' เป็น JSON string อีกชั้น → decode ซ้ำ
      final data = jsonDecode(msg['data'] as String) as Map<String, dynamic>;
      return PowerReading.fromJson(data);
    });
  }
}
