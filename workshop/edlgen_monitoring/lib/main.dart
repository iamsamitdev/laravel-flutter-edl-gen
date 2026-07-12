import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/network/auth_interceptor.dart';
import 'core/network/dio_client.dart';
import 'core/observability/app_bloc_observer.dart';
import 'core/providers/settings_providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/token_storage.dart';
import 'features/auth/logic/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Audit Trail: log ทุก state transition ของ Cubit (Day 4)
  Bloc.observer = AppBlocObserver();

  // ประกอบ Dependency ตามลำดับ: Storage → Dio → Repository → Cubit → Interceptor
  final tokenStorage = TokenStorage();
  final dio = buildDioClient();
  final authRepository = AuthRepository(dio: dio, tokenStorage: tokenStorage);
  final authCubit = AuthCubit(
    repository: authRepository,
    tokenStorage: tokenStorage,
  )..checkSession();

  // แนบ Bearer Token ทุก request + auto refresh เมื่อ 401 (Day 5 Feature 1)
  dio.interceptors.add(AuthInterceptor(
    tokenStorage: tokenStorage,
    authCubit: authCubit,
    dio: dio,
  ));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('lo'), Locale('th'), Locale('en')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('lo'), // ค่าเริ่มต้นภาษาลาว
      startLocale: const Locale('lo'),
      child: ProviderScope(
        overrides: [
          dioProvider.overrideWithValue(dio),
        ],
        child: BlocProvider.value(
          value: authCubit,
          child: EdlGenApp(authCubit: authCubit),
        ),
      ),
    ),
  );
}

class EdlGenApp extends ConsumerStatefulWidget {
  const EdlGenApp({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  ConsumerState<EdlGenApp> createState() => _EdlGenAppState();
}

class _EdlGenAppState extends ConsumerState<EdlGenApp> {
  late final GoRouter _router = buildRouter(widget.authCubit);

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

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
  }
}
