import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/meter_repository.dart';
import '../data/models/meter_reading.dart';
import 'meter_entry_state.dart';

/// Optimistic Update (Day 5 Feature 5):
/// 1) เพิ่มรายการชั่วคราวทันที (id ติดลบ, isPending = true, ไอคอนนาฬิกา)
/// 2) Server ตอบ 201 → แทนที่ด้วยรายการจริง (ติ๊กเขียว)
/// 3) ล้มเหลว → rollback รายการชั่วคราวออก + แจ้ง error
class MeterEntryCubit extends Cubit<MeterEntryState> {
  MeterEntryCubit({required this._repository})
      : super(const MeterEntryState());

  final MeterRepository _repository;

  Future<void> loadToday() async {
    try {
      final readings = await _repository.getTodayReadings();
      if (isClosed) return;
      emit(state.copyWith(todayReadings: readings));
    } catch (_) {
      // โหลดรายการเดิมไม่ได้ไม่ใช่เรื่องคอขาดบาดตาย - ฟอร์มยังใช้ได้
    }
  }

  Future<void> submitReading({
    required int plantId,
    required String meterCode,
    required double readingKwh,
    required DateTime recordedFor,
  }) async {
    final optimistic = MeterReading(
      id: -DateTime.now().millisecondsSinceEpoch, // id ติดลบ = ยังไม่ยืนยัน
      plantId: plantId,
      meterCode: meterCode,
      readingKwh: readingKwh,
      recordedFor: recordedFor,
      isPending: true,
    );

    final previousList = state.todayReadings;

    emit(state.copyWith(
      status: MeterEntryStatus.submitting,
      todayReadings: [optimistic, ...previousList],
    ));

    try {
      final confirmed = await _repository.createReading(
        plantId: plantId,
        meterCode: meterCode,
        readingKwh: readingKwh,
        recordedFor: recordedFor,
      );

      if (isClosed) return;
      emit(state.copyWith(
        status: MeterEntryStatus.success,
        todayReadings: [confirmed, ...previousList],
      ));
    } catch (e) {
      if (isClosed) return;
      final message = e is ApiException && e.statusCode == 409
          ? 'ชั่วโมงนี้บันทึกค่ามิเตอร์นี้ไปแล้ว'
          : 'บันทึกไม่สำเร็จ กรุณาลองใหม่';
      // Rollback: เอารายการ optimistic ออก กลับไปเป็น list เดิม
      emit(state.copyWith(
        status: MeterEntryStatus.failure,
        todayReadings: previousList,
        errorMessage: message,
      ));
    }
  }
}
