import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../dashboard/data/models/plant.dart';
import '../data/location_service.dart';

/// แจ้งเหตุขัดข้อง: ฟอร์ม + รูปถ่าย + GPS ทั้งหมดเป็น state ในหน้าเดียว
/// - รูปถ่าย: push ไปหน้า Camera แล้วรอรับ path กลับมา (context.push คืนค่าได้)
/// - GPS: เรียก getCurrentPosition() ใน initState
/// - ปุ่มส่ง: _submitting กันกดซ้ำ + SnackBar แจ้งผล
class IncidentFormPage extends StatefulWidget {
  const IncidentFormPage({super.key});

  @override
  State<IncidentFormPage> createState() => _IncidentFormPageState();
}

class _IncidentFormPageState extends State<IncidentFormPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // ── state ของฟอร์ม ──
  List<Plant> _plants = [];
  int? _selectedPlantId;
  String _severity = 'medium';
  String? _photoPath; // null = ยังไม่ถ่ายรูป → ปุ่มส่งกดไม่ได้
  Position? _position; // null = กำลังหาพิกัด
  String? _positionError;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadPlants();
    _loadPosition();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadPlants() async {
    try {
      final plants = await dashboardRepository.fetchPlants();
      if (!mounted) return;
      setState(() => _plants = plants);
    } catch (_) {
      // โหลดรายชื่อโรงไฟฟ้าไม่ได้ → dropdown ว่าง แต่ฟอร์มส่วนอื่นยังใช้ได้
    }
  }

  Future<void> _loadPosition() async {
    setState(() {
      _position = null;
      _positionError = null;
    });
    try {
      final position = await getCurrentPosition();
      if (!mounted) return;
      setState(() => _position = position);
    } catch (e) {
      if (!mounted) return;
      setState(() => _positionError = '$e');
    }
  }

  /// เปิดหน้ากล้อง แล้วรอรับ path ของรูปที่ถ่ายกลับมา
  Future<void> _openCamera() async {
    final path = await context.push<String>('/incidents/new/camera');
    if (path != null) {
      setState(() => _photoPath = path);
    }
  }

  Future<void> _submit() async {
    final photoPath = _photoPath;
    final position = _position;
    if (photoPath == null || position == null) return;

    setState(() => _submitting = true);
    try {
      await incidentRepository.submitIncident(
        plantId: _selectedPlantId ?? 1,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        severity: _severity,
        latitude: position.latitude,
        longitude: position.longitude,
        photoPath: photoPath,
      );
      if (!mounted) return;
      // สำเร็จ: ล้างฟอร์ม + SnackBar เขียว
      setState(() {
        _submitting = false;
        _photoPath = null;
      });
      _titleCtrl.clear();
      _descCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ ${context.tr('inc_success')}'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ $e'),
          backgroundColor: AppColors.critical,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _photoPath != null && _position != null && !_submitting;

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
                  initialValue: _selectedPlantId,
                  hint: Text(context.tr('f_plant'),
                      style: const TextStyle(fontSize: 14)),
                  items: [
                    for (final plant in _plants)
                      DropdownMenuItem(
                          value: plant.id, child: Text(plant.name)),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedPlantId = value),
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
                                  color: _severity == value
                                      ? Colors.white
                                      : color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            selected: _severity == value,
                            selectedColor: color,
                            backgroundColor: color.withValues(alpha: 0.1),
                            showCheckmark: false,
                            onSelected: (_) =>
                                setState(() => _severity = value),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 14),
                _FieldLabel(context.tr('inc_photo')),
                InkWell(
                  onTap: _openCamera,
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
                    child: _photoPath != null
                        ? Image.file(File(_photoPath!), fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const HugeIcon(
                                  icon: HugeIcons.strokeRoundedCamera01,
                                  size: 28,
                                  color: AppColors.textSubtle),
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
                      color: _position != null
                          ? AppColors.successBg
                          : AppColors.infoBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: _position != null
                              ? HugeIcons.strokeRoundedLocation01
                              : HugeIcons.strokeRoundedGps01,
                          size: 20,
                          color: _position != null
                              ? AppColors.success
                              : AppColors.info,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _positionError ??
                                (_position != null
                                    ? '${context.tr('inc_gps')} · ${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}'
                                    : context.tr('inc_gps_wait')),
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // ปุ่มส่ง: หมุนระหว่างส่ง + กดไม่ได้จนกว่ารูปและพิกัดจะพร้อม
                FilledButton.icon(
                  icon: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const HugeIcon(icon: HugeIcons.strokeRoundedSent),
                  label: Text(context.tr('inc_submit')),
                  onPressed: canSubmit ? _submit : null,
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
