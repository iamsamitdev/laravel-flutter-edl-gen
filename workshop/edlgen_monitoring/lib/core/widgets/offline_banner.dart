import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_colors.dart';

/// แถบเหลืองแจ้งโหมด Offline - แสดงเมื่อข้อมูลมาจาก Cache (Day 5 Feature 3)
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warningBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const HugeIcon(
              icon: HugeIcons.strokeRoundedWifiDisconnected01,
              size: 20,
              color: Color(0xFF7A5800)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF7A5800))),
                Text(body,
                    style: const TextStyle(
                        fontSize: 11.5, color: Color(0xFF7A5800))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
