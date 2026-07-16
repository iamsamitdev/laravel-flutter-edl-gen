import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';

/// Camera: วิวไฟน์เดอร์ + กรอบมุม + ปุ่มชัตเตอร์/คลังรูป
/// ถ่ายรูปด้วย image_picker แล้ว "ส่ง path กลับ" ให้หน้าฟอร์มผ่าน context.pop(path)
class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  Future<void> _capture(BuildContext context, {bool gallery = false}) async {
    final picked = await ImagePicker().pickImage(
      source: gallery ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 80, // ย่อรูปก่อนอัปโหลด กันไฟล์เกิน 5 MB
    );
    if (context.mounted && picked != null) {
      context.pop(picked.path); // ได้รูปแล้วส่ง path กลับไปหน้าฟอร์ม
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedCancel01,
                        color: Colors.white),
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
                              const HugeIcon(
                                  icon: HugeIcons.strokeRoundedCamera01,
                                  size: 44,
                                  color: Colors.white38),
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
                            _capture(context, gallery: true),
                        icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedAlbum02,
                            color: Colors.white,
                            size: 30),
                      ),
                      Text(context.tr('cam_gallery'),
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _capture(context),
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
