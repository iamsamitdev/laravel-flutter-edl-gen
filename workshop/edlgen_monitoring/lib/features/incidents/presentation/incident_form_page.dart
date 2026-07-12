import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../dashboard/logic/dashboard_providers.dart';
import '../data/incident_repository.dart';
import '../logic/incident_form_providers.dart';
import '../logic/incident_mutations.dart';

/// แจ้งเหตุขัดข้อง (Day 5 Feature 4): Riverpod Mutation
/// ปุ่มส่ง 4 สถานะ: idle → pending (หมุน กันกดซ้ำ) → success (เขียว) / error (แดง)
class IncidentFormPage extends ConsumerStatefulWidget {
  const IncidentFormPage({super.key});

  @override
  ConsumerState<IncidentFormPage> createState() => _IncidentFormPageState();
}

class _IncidentFormPageState extends ConsumerState<IncidentFormPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit(String? photoPath, double lat, double lng) {
    final plantId = ref.read(incidentFormPlantProvider) ?? 1;
    final severity = ref.read(incidentFormSeverityProvider);

    submitIncidentMutation.run(ref, (tsx) async {
      final repository = tsx.get(incidentRepositoryProvider);
      return repository.submitIncident(
        plantId: plantId,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        severity: severity,
        latitude: lat,
        longitude: lng,
        photoPath: photoPath!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoPath = ref.watch(incidentPhotoProvider);
    final position = ref.watch(currentPositionProvider);
    final submitState = ref.watch(submitIncidentMutation);
    final plants = ref.watch(plantListProvider).value ?? [];
    final selectedPlant = ref.watch(incidentFormPlantProvider);
    final severity = ref.watch(incidentFormSeverityProvider);

    // Side effect: SnackBar + ล้างฟอร์มเมื่อสำเร็จ (ref.listen ไม่ใช่ watch)
    ref.listen(submitIncidentMutation, (previous, next) {
      switch (next) {
        case MutationSuccess():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ ${context.tr('inc_success')}'),
              backgroundColor: AppColors.success,
            ),
          );
          _titleCtrl.clear();
          _descCtrl.clear();
          ref.read(incidentPhotoProvider.notifier).clear();
        case MutationError(:final error):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ $error'),
              backgroundColor: AppColors.critical,
            ),
          );
        default:
          break;
      }
    });

    final canSubmit = photoPath != null && position.hasValue;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            title: context.tr('inc_title'),
            subtitle: context.tr('inc_sub'),
            showBell: false,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel(context.tr('f_plant')),
                DropdownButtonFormField<int>(
                  initialValue: selectedPlant,
                  hint: Text(context.tr('f_plant'),
                      style: const TextStyle(fontSize: 14)),
                  items: [
                    for (final plant in plants)
                      DropdownMenuItem(
                          value: plant.id, child: Text(plant.name)),
                  ],
                  onChanged: (value) => ref
                      .read(incidentFormPlantProvider.notifier)
                      .select(value),
                ),
                const SizedBox(height: 14),
                _FieldLabel(context.tr('f_title')),
                TextField(
                  controller: _titleCtrl,
                  decoration:
                      const InputDecoration(hintText: 'Turbine #2 ...'),
                ),
                const SizedBox(height: 14),
                _FieldLabel(context.tr('f_desc')),
                TextField(
                  controller: _descCtrl,
                  maxLines: 4,
                  decoration: const InputDecoration(hintText: '...'),
                ),
                const SizedBox(height: 14),
                _FieldLabel(context.tr('inc_sev')),
                Row(
                  children: [
                    for (final (value, key, color) in [
                      ('low', 'sev_low', AppColors.success),
                      ('medium', 'sev_med', AppColors.warning),
                      ('high', 'sev_high', const Color(0xFFEA7317)),
                      ('critical', 'sev_crit', AppColors.critical),
                    ]) ...[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: SizedBox(
                              width: double.infinity,
                              child: Text(
                                context.tr(key),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: severity == value
                                      ? Colors.white
                                      : color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            selected: severity == value,
                            selectedColor: color,
                            backgroundColor: color.withValues(alpha: 0.1),
                            showCheckmark: false,
                            onSelected: (_) => ref
                                .read(incidentFormSeverityProvider.notifier)
                                .select(value),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 14),
                _FieldLabel(context.tr('inc_photo')),
                InkWell(
                  onTap: () => context.push('/incidents/new/camera'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1.5,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: photoPath != null
                        ? Image.file(File(photoPath), fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo_camera_outlined,
                                  size: 28, color: AppColors.textSubtle),
                              const SizedBox(height: 6),
                              Text(context.tr('inc_photo_hint'),
                                  style: const TextStyle(
                                      fontSize: 11.5,
                                      color: AppColors.textSubtle)),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 14),
                // แถบ GPS
                InkWell(
                  onTap: () => context.push('/incidents/new/location'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: position.hasValue
                          ? AppColors.successBg
                          : AppColors.infoBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          position.hasValue
                              ? Icons.location_on
                              : Icons.location_searching,
                          size: 20,
                          color: position.hasValue
                              ? AppColors.success
                              : AppColors.info,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            position.when(
                              data: (p) =>
                                  '${context.tr('inc_gps')} · ${p.latitude.toStringAsFixed(4)}, ${p.longitude.toStringAsFixed(4)}',
                              loading: () => context.tr('inc_gps_wait'),
                              error: (e, _) => '$e',
                            ),
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // ปุ่มส่ง 4 สถานะจาก Mutation
                switch (submitState) {
                  MutationPending() => const FilledButton(
                      onPressed: null,
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  MutationSuccess() => FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.success),
                      onPressed: null,
                      icon: const Icon(Icons.check_circle),
                      label: Text(context.tr('inc_sent')),
                    ),
                  MutationError() => FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.critical),
                      icon: const Icon(Icons.refresh),
                      label: Text(context.tr('inc_retry')),
                      onPressed: () => _submit(
                        photoPath,
                        position.requireValue.latitude,
                        position.requireValue.longitude,
                      ),
                    ),
                  _ => FilledButton.icon(
                      icon: const Icon(Icons.send),
                      label: Text(context.tr('inc_submit')),
                      onPressed: canSubmit && _canValidate()
                          ? () => _submit(
                                photoPath,
                                position.requireValue.latitude,
                                position.requireValue.longitude,
                              )
                          : null,
                    ),
                },
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canValidate() => _titleCtrl.text.isNotEmpty || true;
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
    );
  }
}
