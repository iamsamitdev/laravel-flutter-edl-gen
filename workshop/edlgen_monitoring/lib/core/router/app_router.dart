import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/logic/auth_cubit.dart';
import '../../features/auth/logic/auth_state.dart';
import '../../features/auth/presentation/forgot_password_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/splash_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/dashboard/presentation/plant_detail_page.dart';
import '../../features/incidents/presentation/camera_page.dart';
import '../../features/incidents/presentation/gps_map_page.dart';
import '../../features/incidents/presentation/incident_detail_page.dart';
import '../../features/incidents/presentation/incident_form_page.dart';
import '../../features/meters/presentation/meter_detail_page.dart';
import '../../features/meters/presentation/meter_page.dart';
import '../../features/notifications/presentation/notifications_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/reports/presentation/date_range_page.dart';
import '../../features/reports/presentation/reports_page.dart';
import 'app_shell.dart';

/// แปลง Stream ของ Cubit เป็น Listenable ให้ GoRouter re-evaluate redirect
/// ทุกครั้งที่ AuthState เปลี่ยน (Day 4/5 Route Guard)
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildRouter(AuthCubit authCubit) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),

    // 🔐 Route Guard: คุมทุกการนำทางรวมถึง Deep Link
    redirect: (context, state) {
      final status = authCubit.state.status;
      final location = state.matchedLocation;
      const publicRoutes = ['/login', '/forgot-password'];

      // ยังเช็ก session ไม่เสร็จ → ค้างที่ Splash ก่อน
      if (status == AuthStatus.unknown) {
        return location == '/splash' ? null : '/splash';
      }

      final isAuthenticated = status == AuthStatus.authenticated;
      final isPublic = publicRoutes.contains(location);

      if (!isAuthenticated && !isPublic) return '/login';
      if (isAuthenticated && (isPublic || location == '/splash')) {
        return '/dashboard';
      }
      return null;
    },

    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      // หน้าที่เปิดทับ Shell (ใช้ root navigator - ไม่มี bottom nav)
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/reports/date-range',
        name: 'date-range',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DateRangePage(),
      ),
      GoRoute(
        path: '/incidents/new/camera',
        name: 'camera',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CameraPage(),
      ),
      GoRoute(
        path: '/incidents/new/location',
        name: 'gps-map',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const GpsMapPage(),
      ),
      GoRoute(
        path: '/incidents/:id',
        name: 'incident-detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => IncidentDetailPage(
          incidentId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/meters/:id',
        name: 'meter-detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => MeterDetailPage(
          meterId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/dashboard/plant/:id',
        name: 'plant-detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => PlantDetailPage(
          plantId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Shell 5 แท็บ (IndexedStack - state ของแต่ละแท็บคงอยู่)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/reports',
              name: 'reports',
              builder: (context, state) => const ReportsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/incidents/new',
              name: 'incident-new',
              builder: (context, state) => const IncidentFormPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/meters',
              name: 'meters',
              builder: (context, state) => const MeterPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ]),
        ],
      ),
    ],
  );
}
