import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_colors.dart';

/// แถบแจ้ง Error + ปุ่มลองใหม่ (Day 3 Lab step 6)
class ErrorBanner extends StatelessWidget {
  const ErrorBanner({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryLabel = 'ลองใหม่',
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.criticalBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.critical.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const HugeIcon(
              icon: HugeIcons.strokeRoundedAlertCircle,
              color: AppColors.critical),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF9B181D)),
            ),
          ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedRefresh, size: 18),
            label: Text(retryLabel),
          ),
        ],
      ),
    );
  }
}
