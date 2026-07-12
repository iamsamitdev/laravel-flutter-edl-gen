import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'incident_form_providers.g.dart';

/// path รูปถ่ายเครื่องจักร (null = ยังไม่ถ่าย → ปุ่มส่งกดไม่ได้)
@riverpod
class IncidentPhoto extends _$IncidentPhoto {
  @override
  String? build() => null;

  Future<void> takePhoto() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 80, // ย่อรูปก่อนอัปโหลด กันไฟล์เกิน 5 MB
    );
    if (picked != null) state = picked.path;
  }

  Future<void> pickFromGallery() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked != null) state = picked.path;
  }

  void clear() => state = null;
}

/// พิกัด GPS ปัจจุบัน - throw เมื่อ Location Service ปิดหรือไม่ได้รับสิทธิ์
@riverpod
Future<Position> currentPosition(Ref ref) async {
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

/// โรงไฟฟ้าที่เลือกในฟอร์ม + ระดับความรุนแรง (state ของฟอร์ม)
@riverpod
class IncidentFormPlant extends _$IncidentFormPlant {
  @override
  int? build() => null;

  void select(int? plantId) => state = plantId;
}

@riverpod
class IncidentFormSeverity extends _$IncidentFormSeverity {
  @override
  String build() => 'medium';

  void select(String severity) => state = severity;
}
