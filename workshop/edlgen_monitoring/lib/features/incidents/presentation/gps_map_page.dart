import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../logic/incident_form_providers.dart';

/// GPS map: แผนที่จำลอง (grid) + หมุด + วงความแม่นยำ + bottom sheet พิกัดจริง
/// พิกัดมาจาก geolocator ผ่าน currentPositionProvider (Day 5 Feature 4)
class GpsMapPage extends ConsumerWidget {
  const GpsMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(currentPositionProvider);

    return Scaffold(
      body: Stack(
        children: [
          // "แผนที่" จำลองด้วย grid (ห้องอบรมไม่ใช้ map SDK จริง)
          Positioned.fill(
            child: CustomPaint(
              painter: _GridMapPainter(
                dark: Theme.of(context).brightness == Brightness.dark,
              ),
            ),
          ),
          // หมุด + วงความแม่นยำ
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.15),
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4)),
                  ),
                  child: const Icon(Icons.location_on,
                      color: AppColors.signalRed, size: 40),
                ),
              ],
            ),
          ),
          // ปุ่ม back
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          // Bottom sheet พิกัด
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('gps_current'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 8),
                  position.when(
                    loading: () => Text(context.tr('inc_gps_wait')),
                    error: (e, _) => Text('$e',
                        style: const TextStyle(color: AppColors.critical)),
                    data: (p) => Text(
                      '${p.latitude.toStringAsFixed(6)}, ${p.longitude.toStringAsFixed(6)}'
                      '  ·  ±${p.accuracy.toStringAsFixed(0)} m',
                      style: AppTheme.numberStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: position.hasValue ? () => context.pop() : null,
                    icon: const Icon(Icons.check),
                    label: Text(context.tr('gps_use')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridMapPainter extends CustomPainter {
  const _GridMapPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..color = dark ? const Color(0xFF10203A) : const Color(0xFFE4EBF5);
    canvas.drawRect(Offset.zero & size, bg);

    final line = Paint()
      ..color = dark ? const Color(0xFF1B3050) : const Color(0xFFD0DCEC)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }

    // "ถนน" เส้นหนา
    final road = Paint()
      ..color = dark ? const Color(0xFF24395B) : Colors.white
      ..strokeWidth = 14;
    canvas.drawLine(Offset(0, size.height * 0.35),
        Offset(size.width, size.height * 0.55), road);
    canvas.drawLine(Offset(size.width * 0.3, 0),
        Offset(size.width * 0.55, size.height), road);
  }

  @override
  bool shouldRepaint(covariant _GridMapPainter oldDelegate) =>
      oldDelegate.dark != dark;
}
