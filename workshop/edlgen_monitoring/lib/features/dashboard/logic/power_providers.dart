import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/power_reading.dart';
import '../data/power_socket_service.dart';

part 'power_providers.g.dart';

@riverpod
PowerSocketService powerSocketService(Ref ref) => PowerSocketService();

/// StreamProvider: ค่าการผลิตสดจาก WebSocket - push ทุก 3 วินาที (ไม่มี polling)
/// Riverpod retry อัตโนมัติแบบ exponential backoff เมื่อ stream error
@riverpod
Stream<PowerReading> latestPowerReading(Ref ref) {
  return ref.watch(powerSocketServiceProvider).connect();
}

/// สะสมค่าล่าสุด 30 จุดสำหรับกราฟเส้น (Day 5 Feature 2)
@riverpod
class PowerHistory extends _$PowerHistory {
  static const _maxPoints = 30;

  @override
  List<PowerReading> build() {
    ref.listen(latestPowerReadingProvider, (previous, next) {
      next.whenData((reading) {
        final updated = [...state, reading];
        state = updated.length > _maxPoints
            ? updated.sublist(updated.length - _maxPoints)
            : updated;
      });
    });
    return const [];
  }
}
