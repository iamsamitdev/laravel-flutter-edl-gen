import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_header.dart';

/// Profile & Settings: การ์ดโปรไฟล์ + เมนูภาษา (คลิกวนภาษา) +
/// toggle dark mode/แจ้งเตือน + ปุ่มออกจากระบบ
/// - Dark mode: เรียก toggleThemeMode() (app_services.dart)
/// - เปิด/ปิดแจ้งเตือน: state ในหน้านี้เอง (setState ธรรมดา)
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _locales = [Locale('lo'), Locale('th'), Locale('en')];

  bool _notificationsEnabled = true;

  void _cycleLanguage(BuildContext context) {
    final current = context.locale;
    final index = _locales.indexWhere(
        (locale) => locale.languageCode == current.languageCode);
    context.setLocale(_locales[(index + 1) % _locales.length]);
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.user;
    final isDark = themeModeNotifier.value == ThemeMode.dark;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            title: context.tr('nav_profile'),
            subtitle: context.tr('prof_sub'),
            showBell: false,
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/edl_gen_logo.jpg',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '-',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('prof_settings'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      // ภาษา - แตะเพื่อวนภาษา ລາວ → ไทย → EN
                      ListTile(
                        leading: const HugeIcon(
                            icon: HugeIcons.strokeRoundedGlobe02),
                        title: Text(context.tr('set_lang')),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.tr('lang_name'),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const HugeIcon(
                                icon: HugeIcons.strokeRoundedArrowRight01),
                          ],
                        ),
                        onTap: () => _cycleLanguage(context),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary:
                            const HugeIcon(icon: HugeIcons.strokeRoundedMoon02),
                        title: Text(context.tr('set_dark')),
                        value: isDark,
                        onChanged: (_) async {
                          await toggleThemeMode();
                          // MaterialApp เปลี่ยนธีมเอง แต่ setState เพื่อให้
                          // switch ในหน้านี้สะท้อนค่าใหม่ทันที
                          setState(() {});
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const HugeIcon(
                            icon: HugeIcons.strokeRoundedNotification03),
                        title: Text(context.tr('set_notif')),
                        value: _notificationsEnabled,
                        onChanged: (value) =>
                            setState(() => _notificationsEnabled = value),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const HugeIcon(
                            icon: HugeIcons.strokeRoundedInformationCircle),
                        title: Text(context.tr('set_about')),
                        trailing: const Text('v1.0.0'),
                        onTap: () => showAboutDialog(
                          context: context,
                          applicationName: 'EDL-Gen Monitoring',
                          applicationVersion: '1.0.0',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const HugeIcon(
                        icon: HugeIcons.strokeRoundedLogout03,
                        color: AppColors.critical),
                    title: Text(
                      context.tr('prof_logout'),
                      style: const TextStyle(
                          color: AppColors.critical,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      // GoRouter redirect พากลับหน้า Login เองเมื่อสถานะเปลี่ยน
                      authController.logout();
                    },
                  ),
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
