import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_header.dart';
import '../data/models/meter_reading.dart';

/// บันทึกค่ามิเตอร์: ฟอร์ม + Optimistic Update ด้วย setState ธรรมดา
///
/// Optimistic Update คือ:
/// 1) เพิ่มรายการชั่วคราวเข้า list ทันที (isPending = true, ไอคอนนาฬิกา)
/// 2) Server ตอบสำเร็จ → แทนที่ด้วยรายการจริง (ติ๊กเขียว)
/// 3) ล้มเหลว → เอารายการชั่วคราวออก (rollback) + แจ้ง error
///
/// validate ฝั่ง client ต้องตรงกับ server: ^MTR-\d{4}$ และ 0-99,999,999
class MeterPage extends StatefulWidget {
  const MeterPage({super.key});

  @override
  State<MeterPage> createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  final _formKey = GlobalKey<FormState>();
  final _meterCodeCtrl = TextEditingController(text: 'MTR-0042');
  final _readingCtrl = TextEditingController();

  List<MeterReading> _todayReadings = [];
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadToday();
  }

  @override
  void dispose() {
    _meterCodeCtrl.dispose();
    _readingCtrl.dispose();
    super.dispose();
  }

  DateTime _currentHour() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour);
  }

  Future<void> _loadToday() async {
    try {
      final readings = await meterRepository.getTodayReadings();
      if (!mounted) return;
      setState(() => _todayReadings = readings);
    } catch (_) {
      // โหลดรายการเดิมไม่ได้ไม่ใช่เรื่องคอขาดบาดตาย - ฟอร์มยังใช้ได้
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final meterCode = _meterCodeCtrl.text;
    final readingKwh = double.parse(_readingCtrl.text);
    final recordedFor = _currentHour();

    // (1) Optimistic: เพิ่มรายการชั่วคราวทันที (id ติดลบ = ยังไม่ยืนยัน)
    final optimistic = MeterReading(
      id: -DateTime.now().millisecondsSinceEpoch,
      plantId: 1,
      meterCode: meterCode,
      readingKwh: readingKwh,
      recordedFor: recordedFor,
      isPending: true,
    );
    final previousList = _todayReadings;
    setState(() {
      _submitting = true;
      _todayReadings = [optimistic, ...previousList];
    });

    try {
      // (2) Server ตอบสำเร็จ → แทนที่รายการชั่วคราวด้วยของจริง
      final confirmed = await meterRepository.createReading(
        plantId: 1,
        meterCode: meterCode,
        readingKwh: readingKwh,
        recordedFor: recordedFor,
      );
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _todayReadings = [confirmed, ...previousList];
      });
      _readingCtrl.clear();
    } catch (e) {
      if (!mounted) return;
      // (3) ล้มเหลว → rollback กลับไปเป็น list เดิม + SnackBar
      final message = e is ApiException && e.statusCode == 409
          ? 'ชั่วโมงนี้บันทึกค่ามิเตอร์นี้ไปแล้ว'
          : 'บันทึกไม่สำเร็จ กรุณาลองใหม่';
      setState(() {
        _submitting = false;
        _todayReadings = previousList;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.critical,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            title: context.tr('mtr_title'),
            subtitle: context.tr('mtr_sub'),
            onBellTap: () => context.push('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _meterCodeCtrl,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: context.tr('f_metercode'),
                      // ครอบ Center กันไอคอนถูกยืดเต็มกรอบ 48px ของ prefixIcon
                      prefixIcon: const Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: HugeIcon(
                            icon: HugeIcons.strokeRoundedQrCode, size: 22),
                      ),
                      hintText: 'MTR-0042',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return context.tr('mtr_code_required');
                      }
                      if (!RegExp(r'^MTR-\d{4}$').hasMatch(v)) {
                        return context.tr('mtr_code_invalid');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _readingCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: InputDecoration(
                      labelText: context.tr('f_reading'),
                      prefixIcon: const Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: HugeIcon(
                            icon: HugeIcons.strokeRoundedFlash, size: 22),
                      ),
                      suffixText: 'kWh',
                    ),
                    validator: (v) {
                      final value = double.tryParse(v ?? '');
                      if (value == null) {
                        return context.tr('mtr_reading_invalid');
                      }
                      if (value < 0 || value > 99999999) {
                        return context.tr('mtr_reading_range');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${context.tr('mtr_hourword')} '
                    '${DateFormat('HH:00').format(_currentHour())}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  // ปุ่มทอง (gold gradient ตามดีไซน์)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: _submitting ? null : _submit,
                      icon: _submitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const HugeIcon(
                              icon: HugeIcons.strokeRoundedFloppyDisk),
                      label: Text(context.tr('mtr_save')),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.tr('mtr_today'),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  // รายการวันนี้: pending = นาฬิกาส้ม / confirmed = ติ๊กเขียว
                  for (final reading in _todayReadings)
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        onTap: reading.isPending
                            ? null
                            : () => context.push('/meters/${reading.id}'),
                        leading: reading.isPending
                            ? const HugeIcon(
                                icon: HugeIcons.strokeRoundedClock01,
                                color: AppColors.warning)
                            : const HugeIcon(
                                icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                                color: AppColors.success),
                        title: Text(
                          '${reading.meterCode} · '
                          '${reading.readingKwh.toStringAsFixed(1)} kWh',
                          style: AppTheme.numberStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color,
                          ),
                        ),
                        subtitle: Text(
                          '${context.tr('mtr_hourword')} '
                          '${DateFormat('HH:00').format(reading.recordedFor)} · '
                          '${reading.isPending ? context.tr('mtr_pending') : context.tr('mtr_confirm')}',
                        ),
                        trailing: reading.isPending
                            ? null
                            : const HugeIcon(
                                icon: HugeIcons.strokeRoundedArrowRight01),
                      ),
                    ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
