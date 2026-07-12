import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_header.dart';
import '../data/meter_repository.dart';
import '../logic/meter_entry_cubit.dart';
import '../logic/meter_entry_state.dart';

/// บันทึกค่ามิเตอร์ (Day 5 Feature 5): Cubit + Optimistic Update
/// validate ฝั่ง client ต้องตรงกับ server: ^MTR-\d{4}$ และ 0-99,999,999
class MeterPage extends ConsumerWidget {
  const MeterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (_) =>
          MeterEntryCubit(repository: ref.read(meterRepositoryProvider))
            ..loadToday(),
      child: const _MeterView(),
    );
  }
}

class _MeterView extends StatefulWidget {
  const _MeterView();

  @override
  State<_MeterView> createState() => _MeterViewState();
}

class _MeterViewState extends State<_MeterView> {
  final _formKey = GlobalKey<FormState>();
  final _meterCodeCtrl = TextEditingController(text: 'MTR-0042');
  final _readingCtrl = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MeterEntryCubit, MeterEntryState>(
        listener: (context, state) {
          if (state.status == MeterEntryStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? context.tr('mtr_failed')),
                backgroundColor: AppColors.critical,
              ),
            );
          }
          if (state.status == MeterEntryStatus.success) {
            _readingCtrl.clear();
          }
        },
        builder: (context, state) {
          final submitting = state.status == MeterEntryStatus.submitting;
          return ListView(
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
                          prefixIcon: const Icon(Icons.qr_code_2),
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
                          prefixIcon: const Icon(Icons.bolt),
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
                          onPressed: submitting
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context
                                      .read<MeterEntryCubit>()
                                      .submitReading(
                                        plantId: 1,
                                        meterCode: _meterCodeCtrl.text,
                                        readingKwh: double.parse(
                                            _readingCtrl.text),
                                        recordedFor: _currentHour(),
                                      );
                                },
                          icon: submitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.save_outlined),
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
                      for (final reading in state.todayReadings)
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            onTap: reading.isPending
                                ? null
                                : () =>
                                    context.push('/meters/${reading.id}'),
                            leading: reading.isPending
                                ? const Icon(Icons.schedule,
                                    color: AppColors.warning)
                                : const Icon(Icons.check_circle,
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
                                : const Icon(Icons.chevron_right),
                          ),
                        ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
