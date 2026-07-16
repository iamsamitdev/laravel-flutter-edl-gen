import 'package:edlgen_monitoring/features/auth/data/auth_repository.dart';
import 'package:edlgen_monitoring/features/auth/data/models/auth_user.dart';
import 'package:edlgen_monitoring/features/auth/data/token_storage.dart';
import 'package:edlgen_monitoring/features/auth/logic/auth_controller.dart';
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
  late AuthController controller;

  setUp(() {
    repository = MockAuthRepository();
    tokenStorage = MockTokenStorage();
    controller =
        AuthController(repository: repository, tokenStorage: tokenStorage);
  });

  group('AuthController.login', () {
    test('เมื่อ Login สำเร็จ ต้องคืน true, เป็น authenticated และบันทึก Token',
        () async {
      when(() => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => fakeLoginResult);
      when(() => tokenStorage.saveToken(any(), any()))
          .thenAnswer((_) async {});

      final success = await controller.login(
        email: 'engineer@edlgen.la',
        password: 'password123',
      );

      expect(success, isTrue);
      expect(controller.status, AuthStatus.authenticated);
      expect(controller.user, fakeUser);
      verify(() => tokenStorage.saveToken(any(), any())).called(1);
    });

    test('เมื่อรหัสผ่านผิด ต้องคืน false และสถานะไม่เปลี่ยนเป็น authenticated',
        () async {
      when(() => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('401'));

      final success = await controller.login(
        email: 'engineer@edlgen.la',
        password: 'wrong-password',
      );

      expect(success, isFalse);
      expect(controller.status, isNot(AuthStatus.authenticated));
    });
  });

  group('AuthController.checkSession', () {
    test('ไม่มี token ใน storage ต้องเป็น unauthenticated', () async {
      when(() => tokenStorage.readToken()).thenAnswer((_) async => null);

      await controller.checkSession();

      expect(controller.status, AuthStatus.unauthenticated);
    });

    test('มี token และ /auth/me ผ่าน ต้องเป็น authenticated', () async {
      when(() => tokenStorage.readToken())
          .thenAnswer((_) async => '1|fake-token');
      when(() => repository.me()).thenAnswer((_) async => fakeUser);

      await controller.checkSession();

      expect(controller.status, AuthStatus.authenticated);
      expect(controller.user, fakeUser);
    });

    test('มี token แต่ /auth/me ล้ม ต้องล้าง token และเป็น unauthenticated',
        () async {
      when(() => tokenStorage.readToken())
          .thenAnswer((_) async => '1|expired-token');
      when(() => repository.me()).thenThrow(Exception('401'));
      when(() => tokenStorage.clear()).thenAnswer((_) async {});

      await controller.checkSession();

      expect(controller.status, AuthStatus.unauthenticated);
      verify(() => tokenStorage.clear()).called(1);
    });
  });
}
