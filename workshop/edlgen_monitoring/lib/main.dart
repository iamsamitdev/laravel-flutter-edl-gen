import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/app_services.dart';
import 'core/network/auth_interceptor.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // โหลดโหมดสว่าง/มืดที่เคยบันทึกไว้
  await restoreThemeMode();

  // แนบ Bearer Token ทุก request + auto refresh เมื่อ 401
  dio.interceptors.add(AuthInterceptor(
    tokenStorage: tokenStorage,
    authController: authController,
    dio: dio,
  ));

  // เช็กว่าเคย login ค้างไว้หรือยัง (ทำงานเบื้องหลัง GoRouter รอผลที่หน้า Splash)
  authController.checkSession();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('lo'), Locale('th'), Locale('en')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('lo'), // ค่าเริ่มต้นภาษาลาว
      startLocale: const Locale('lo'),
      child: const EdlGenApp(),
    ),
  );
}

class EdlGenApp extends StatefulWidget {
  const EdlGenApp({super.key});

  @override
  State<EdlGenApp> createState() => _EdlGenAppState();
}

class _EdlGenAppState extends State<EdlGenApp> {
  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder: rebuild MaterialApp เมื่อผู้ใช้สลับโหมดสว่าง/มืด
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp.router(
          title: 'EDL-Gen Monitoring',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.light(context.locale),
          darkTheme: AppTheme.dark(context.locale),
          themeMode: themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
