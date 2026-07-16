import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_colors.dart';

/// Forgot password: ไอคอนกุญแจ + ช่องอีเมล + ปุ่มส่งลิงก์ + หมายเหตุ 15 นาที
/// (ฝั่ง API เป็น mock - ในห้องอบรมใช้สาธิต UI/Flow เท่านั้น)
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailCtrl = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft02),
        ),
        title: Text(context.tr('fp_sub')),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.infoBg,
                    shape: BoxShape.circle,
                  ),
                  child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedForgotPassword,
                      size: 40,
                      color: AppColors.info),
                ),
                const SizedBox(height: 20),
                Text(
                  context.tr('fp_title'),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('fp_desc'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: context.tr('f_email'),
                    // ครอบ Center กันไอคอนถูกยืดเต็มกรอบ 48px
                    prefixIcon: const Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: HugeIcon(
                          icon: HugeIcons.strokeRoundedMail01, size: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    setState(() => _sent = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.tr('fp_note'))),
                    );
                  },
                  child: Text(
                      _sent ? '✓ ${context.tr('fp_send')}' : context.tr('fp_send')),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(context.tr('fp_back')),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('fp_note'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
