import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_colors.dart';

/// Login: โลโก้ + segmented สลับภาษา + ฟอร์ม (setState ธรรมดา)
/// - _loading เป็น state ของหน้านี้: true ระหว่างรอ API
/// - login สำเร็จ → AuthController แจ้ง GoRouter ให้ redirect ไป Dashboard เอง
/// - login ล้มเหลว → SnackBar สีแดง
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(text: 'engineer@edlgen.la');
  final _passCtrl = TextEditingController(text: 'password123');
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final success = await authController.login(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('เข้าสู่ระบบไม่สำเร็จ: ตรวจสอบอีเมลหรือรหัสผ่าน'),
          backgroundColor: AppColors.critical,
        ),
      );
    }
    // สำเร็จ: ไม่ต้องนำทางเอง GoRouter redirect ให้อัตโนมัติ
  }

  @override
  Widget build(BuildContext context) {
    final loading = _loading;
    return Scaffold(
      body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/edl_gen_logo.jpg',
                          width: 84,
                          height: 84,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _LanguageSwitcher(),
                      const SizedBox(height: 20),
                      Text(
                        context.tr('login_title'),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.tr('login_sub'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: context.tr('f_email'),
                          // ครอบ Center กันไอคอนถูกยืดเต็มกรอบ 48px
                          prefixIcon: const Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: HugeIcon(
                                icon: HugeIcons.strokeRoundedMail01,
                                size: 22),
                          ),
                        ),
                        validator: (v) => (v == null || !v.contains('@'))
                            ? context.tr('f_email')
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: context.tr('f_password'),
                          prefixIcon: const Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: HugeIcon(
                                icon: HugeIcons.strokeRoundedSquareLock02,
                                size: 22),
                          ),
                          suffixIcon: IconButton(
                            icon: HugeIcon(
                                icon: _obscure
                                    ? HugeIcons.strokeRoundedView
                                    : HugeIcons.strokeRoundedViewOffSlash,
                                size: 22),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        validator: (v) => (v == null || v.length < 4)
                            ? context.tr('f_password')
                            : null,
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(context.tr('login_forgot')),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text(context.tr('login_btn')),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        context.tr('login_foot'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

/// Segmented สลับภาษา ລາວ/ไทย/EN (ค่าเริ่มต้นภาษาลาว)
class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'lo', label: Text('ລາວ')),
        ButtonSegment(value: 'th', label: Text('ไทย')),
        ButtonSegment(value: 'en', label: Text('EN')),
      ],
      selected: {current},
      showSelectedIcon: false,
      onSelectionChanged: (selection) =>
          context.setLocale(Locale(selection.first)),
    );
  }
}
