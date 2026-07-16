import 'package:geolocator/geolocator.dart';

/// ขอพิกัด GPS ปัจจุบัน (ฟังก์ชันธรรมดา เรียกจากหน้าไหนก็ได้)
/// throw Exception เมื่อ Location Service ปิดอยู่ หรือไม่ได้รับสิทธิ์
Future<Position> getCurrentPosition() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw Exception('กรุณาเปิด Location Service ก่อนแจ้งเหตุ');
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception('แอปไม่ได้รับสิทธิ์เข้าถึงตำแหน่ง');
  }
  return Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );
}
