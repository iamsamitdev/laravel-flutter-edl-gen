import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../logic/incident_form_providers.dart';

/// Camera: วิวไฟน์เดอร์ + กรอบมุม + ปุ่มชัตเตอร์/คลังรูป
/// ปุ่มชัตเตอร์เรียกกล้องจริงผ่าน image_picker (Day 5 Feature 4)
class CameraPage extends ConsumerWidget {
  const CameraPage({super.key});

  Future<void> _capture(BuildContext context, WidgetRef ref,
      {bool gallery = false}) async {
    final notifier = ref.read(incidentPhotoProvider.notifier);
    if (gallery) {
      await notifier.pickFromGallery();
    } else {
      await notifier.takePhoto();
    }
    if (context.mounted && ref.read(incidentPhotoProvider) != null) {
      context.pop(); // ได้รูปแล้วกลับไปหน้าฟอร์ม
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      context.tr('cam_title'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            // วิวไฟน์เดอร์จำลอง + กรอบมุม
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo_camera_outlined,
                                  size: 44, color: Colors.white38),
                              const SizedBox(height: 10),
                              Text(
                                context.tr('cam_hint'),
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12.5),
                              ),
                            ],
                          ),
                        ),
                        // กรอบมุม 4 ด้าน
                        for (final alignment in [
                          Alignment.topLeft,
                          Alignment.topRight,
                          Alignment.bottomLeft,
                          Alignment.bottomRight,
                        ])
                          Align(
                            alignment: alignment,
                            child: Container(
                              margin: const EdgeInsets.all(14),
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: alignment.y < 0
                                      ? const BorderSide(
                                          color: AppColors.gold, width: 3)
                                      : BorderSide.none,
                                  bottom: alignment.y > 0
                                      ? const BorderSide(
                                          color: AppColors.gold, width: 3)
                                      : BorderSide.none,
                                  left: alignment.x < 0
                                      ? const BorderSide(
                                          color: AppColors.gold, width: 3)
                                      : BorderSide.none,
                                  right: alignment.x > 0
                                      ? const BorderSide(
                                          color: AppColors.gold, width: 3)
                                      : BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ปุ่มชัตเตอร์ / คลังรูป
            Padding(
              padding: const EdgeInsets.only(bottom: 28, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _capture(context, ref, gallery: true),
                        icon: const Icon(Icons.photo_library_outlined,
                            color: Colors.white, size: 30),
                      ),
                      Text(context.tr('cam_gallery'),
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _capture(context, ref),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 58),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
