import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_colors.dart';

/// Shell + Bottom nav 5 แท็บตามดีไซน์: Dashboard/Reports/Incident(กลาง แดง)/Meter/Profile
/// ใช้ StatefulNavigationShell (IndexedStack) - สลับแท็บแล้ว state ของแต่ละหน้าไม่หาย
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inactive = isDark ? AppColors.darkSubtle : AppColors.textSubtle;
    final active = isDark ? AppColors.darkPrimary : AppColors.primary;

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(
            top: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.border),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            child: Row(
              children: [
                _NavItem(
                  icon: HugeIcons.strokeRoundedHome01,
                  label: context.tr('nav_home'),
                  selected: navigationShell.currentIndex == 0,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(0),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedFile01,
                  label: context.tr('nav_reports'),
                  selected: navigationShell.currentIndex == 1,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(1),
                ),
                // ปุ่มกลาง: แจ้งเหตุ - วงกลมแดงยกสูง (ตามดีไซน์)
                Expanded(
                  child: InkWell(
                    onTap: () => _goBranch(2),
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -6),
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.signalRed,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.signalRed
                                      .withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedAlert02,
                                  color: Colors.white,
                                  size: 24),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -6),
                          child: Text(
                            context.tr('nav_incident'),
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: navigationShell.currentIndex == 2
                                  ? AppColors.signalRed
                                  : inactive,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedDashboardSpeed01,
                  label: context.tr('nav_meter'),
                  selected: navigationShell.currentIndex == 3,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(3),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedUser,
                  label: context.tr('nav_profile'),
                  selected: navigationShell.currentIndex == 4,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  // HugeIcons ชุดฟรีมีเฉพาะแบบเส้น (stroke) จึงใช้ไอคอนเดียว
  // แล้วแยกสถานะ active/inactive ด้วย "สี" แทนการสลับรูป
  final List<List<dynamic>> icon;
  final String label;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? activeColor : inactiveColor;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: icon,
                size: 23,
                color: color,
                strokeWidth: selected ? 2.0 : 1.5, // แท็บที่เลือกเส้นหนาขึ้น
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
