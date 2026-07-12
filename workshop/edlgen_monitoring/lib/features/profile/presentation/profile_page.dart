import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/settings_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../auth/logic/auth_cubit.dart';

/// Profile & Settings: การ์ดโปรไฟล์ + เมนูภาษา (คลิกวนภาษา) +
/// toggle dark mode/แจ้งเตือน + ปุ่มออกจากระบบ (ดีไซน์หน้า 16)
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const _locales = [Locale('lo'), Locale('th'), Locale('en')];

  void _cycleLanguage(BuildContext context) {
    final current = context.locale;
    final index = _locales.indexWhere(
        (locale) => locale.languageCode == current.languageCode);
    context.setLocale(_locales[(index + 1) % _locales.length]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = context.watch<AuthCubit>().state.user;
    final themeMode = ref.watch(themeModeProvider);
    final notifEnabled = ref.watch(notificationsEnabledProvider);

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
                        leading: const Icon(Icons.language),
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
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => _cycleLanguage(context),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const Icon(Icons.dark_mode_outlined),
                        title: Text(context.tr('set_dark')),
                        value: themeMode == ThemeMode.dark,
                        onChanged: (_) =>
                            ref.read(themeModeProvider.notifier).toggle(),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary:
                            const Icon(Icons.notifications_outlined),
                        title: Text(context.tr('set_notif')),
                        value: notifEnabled,
                        onChanged: (value) => ref
                            .read(notificationsEnabledProvider.notifier)
                            .set(value),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
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
                    leading:
                        const Icon(Icons.logout, color: AppColors.critical),
                    title: Text(
                      context.tr('prof_logout'),
                      style: const TextStyle(
                          color: AppColors.critical,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      // GoRouter redirect พากลับหน้า Login เองเมื่อ state เปลี่ยน
                      context.read<AuthCubit>().logout();
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
