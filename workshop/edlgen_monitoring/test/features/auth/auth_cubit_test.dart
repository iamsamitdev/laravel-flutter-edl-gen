import 'package:bloc_test/bloc_test.dart';
import 'package:edlgen_monitoring/features/auth/data/auth_repository.dart';
import 'package:edlgen_monitoring/features/auth/data/models/auth_user.dart';
import 'package:edlgen_monitoring/features/auth/data/token_storage.dart';
import 'package:edlgen_monitoring/features/auth/logic/auth_cubit.dart';
import 'package:edlgen_monitoring/features/auth/logic/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTokenStorage extends Mock implements TokenStorage {}

const fakeUser = AuthUser(
  id: 1,
  name: 'Somphone Engineer',
  email: 'engineer@edlgen.la',
  role: 'operator',
);

const fakeLoginResult = LoginResult(
  token: '1|fake-token',
  user: fakeUser,
  expiresAt: '2026-07-13T12:00:00+07:00',
);

void main() {
  late MockAuthRepository repository;
  late MockTokenStorage tokenStorage;

  setUp(() {
    repository = MockAuthRepository();
    tokenStorage = MockTokenStorage();
  });

  group('AuthCubit.login', () {
    blocTest<AuthCubit, AuthState>(
      'เมื่อ Login สำเร็จ ต้อง emit [authenticating, authenticated] และบันทึก Token',
      build: () {
        when(() => repository.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => fakeLoginResult);
        when(() => tokenStorage.saveToken(any(), any()))
            .thenAnswer((_) async {});
        return AuthCubit(repository: repository, tokenStorage: tokenStorage);
      },
      act: (cubit) => cubit.login(
        email: 'engineer@edlgen.la',
        password: 'password123',
      ),
      expect: () => [
        const AuthState(status: AuthStatus.authenticating),
        const AuthState(status: AuthStatus.authenticated, user: fakeUser),
      ],
      verify: (_) {
        verify(() => tokenStorage.saveToken(any(), any())).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'เมื่อรหัสผ่านผิด ต้อง emit [authenticating, failure] พร้อมข้อความ error',
      build: () {
        when(() => repository.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('401'));
        return AuthCubit(repository: repository, tokenStorage: tokenStorage);
      },
      act: (cubit) => cubit.login(
        email: 'engineer@edlgen.la',
        password: 'wrong-password',
      ),
      expect: () => [
        const AuthState(status: AuthStatus.authenticating),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.failure)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  group('AuthCubit.checkSession', () {
    blocTest<AuthCubit, AuthState>(
      'ไม่มี token ใน storage ต้องเป็น unauthenticated',
      build: () {
        when(() => tokenStorage.readToken()).thenAnswer((_) async => null);
        return AuthCubit(repository: repository, tokenStorage: tokenStorage);
      },
      act: (cubit) => cubit.checkSession(),
      expect: () => [
        const AuthState(status: AuthStatus.unauthenticated),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'มี token และ /auth/me ผ่าน ต้องเป็น authenticated',
      build: () {
        when(() => tokenStorage.readToken())
            .thenAnswer((_) async => '1|fake-token');
        when(() => repository.me()).thenAnswer((_) async => fakeUser);
        return AuthCubit(repository: repository, tokenStorage: tokenStorage);
      },
      act: (cubit) => cubit.checkSession(),
      expect: () => [
        const AuthState(status: AuthStatus.authenticated, user: fakeUser),
      ],
    );
  });
}
