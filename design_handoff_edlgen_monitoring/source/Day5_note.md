# Basic to Advanced Laravel 13 & Flutter - วันที่ 5: Workshop ครบวงจร - EDL-Generation Monitoring App

**หลักสูตรอบรมเชิงปฏิบัติการ: Basic to Advanced Laravel 13 and Flutter Framework (30 ชั่วโมง)**
**Course ID: MOB-15 | Category: Mobile / Full-Stack**
**จัดอบรมให้: EDL-Generation Public Company (EDL-Gen) ผู้ผลิตไฟฟ้ารายใหญ่ของ สปป.ลาว**
**วันที่ 5: Workshop ครบวงจร - ประกอบทุกส่วนจาก Day 1-4 เป็นแอปสมบูรณ์ + Final PoC Presentation**
วันที่: วันศุกร์ที่ 17 กรกฎาคม 2569 | เวลา 09:30-16:30 น. (พักกลางวัน 12:00-13:00 น.) | Onsite Workshop ณ สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
ผู้สอน: อ.สามิตร โกยม

---

## 🎯 วัตถุประสงค์การเรียนรู้ประจำวัน

เมื่อจบการอบรมวันที่ 5 ผู้เรียนจะสามารถ:

1. ประกอบองค์ประกอบทั้งหมดจาก Day 1-4 (Laravel API, Flutter UI, Riverpod 3.0, Cubit) เป็นแอป **EDL-Gen Monitoring App** ที่ทำงานได้จริงครบ 5 Feature
2. เชื่อม AuthCubit เข้ากับ Laravel Sanctum ให้ครบวงจร Login, Token Refresh, Logout พร้อม Route Guard ด้วย GoRouter Redirect
3. สร้าง Real-time Power Dashboard ที่รับข้อมูลจาก Laravel Event Broadcast ผ่าน WebSocket และวาดกราฟด้วย `fl_chart` ที่อัพเดทอัตโนมัติ
4. สร้างระบบรายงานการผลิตรายวันแบบ Offline-First ด้วย AsyncNotifier + SQLite Cache ที่ Filter ตามช่วงเวลาและโรงผลิตได้แม้ไม่มี Network
5. ใช้ Riverpod 3.0 Mutations API จัดการการส่งข้อมูลแจ้งเหตุขัดข้องพร้อมภาพถ่ายและพิกัด GPS โดยแสดงสถานะ idle/pending/success/error ครบถ้วน
6. สร้าง Form บันทึกค่ามิเตอร์ด้วย Cubit พร้อม Validation และ Optimistic UI Update ที่บันทึกลง MariaDB ผ่าน Laravel API
7. เขียน Unit Test ให้ Cubit (ด้วย `bloc_test`) และ Riverpod Provider (ด้วย `ProviderContainer` + override) รวมถึงวาง CI/CD เบื้องต้นด้วย GitHub Actions
8. นำเสนอ Final PoC ของทีมตนเอง พร้อมแผน Next Steps สำหรับพัฒนาต่อในโปรเจคจริงของ EDL-Gen

> **หมายเหตุสำคัญ:** วันนี้ไม่มีทฤษฎีใหม่ ทุกหัวข้อคือการ "ประกอบร่าง" สิ่งที่เรียนมาแล้วทั้ง 4 วันให้กลายเป็นแอปเดียวที่สมบูรณ์ ผู้เรียนควรเปิดโปรเจกต์ Laravel และ Flutter จาก Day 4 ค้างไว้ตั้งแต่เช้า และทำงานเป็นทีมเดิมที่จัดไว้ตั้งแต่ Day 1

---

## 🧭 กำหนดการวันที่ 5 (โดยสังเขป)

| เวลา        | หัวข้อ                                                                       |
| ----------- | ---------------------------------------------------------------------------- |
| 09:30-10:00 | ตรวจความพร้อมก่อน Workshop + ภาพรวมสถาปัตยกรรมของแอปทั้งระบบ                  |
| 10:00-10:45 | **Feature 1** Login & Auth Flow (Cubit + Laravel Sanctum)                    |
| 10:45-11:30 | **Feature 2** Real-time Power Dashboard (StreamProvider + WebSocket)         |
| 11:30-12:00 | **Feature 3 (ตอนที่ 1)** รายงานการผลิตรายวัน - Laravel API + AsyncNotifier   |
| 12:00-13:00 | พักกลางวัน                                                                    |
| 13:00-13:30 | **Feature 3 (ตอนที่ 2)** Offline Cache (SQLite) + Filter ช่วงเวลา/โรงผลิต     |
| 13:30-14:15 | **Feature 4** แจ้งเหตุขัดข้องเครื่องจักร (Mutations API + Push Notification) |
| 14:15-14:45 | **Feature 5** บันทึกค่ามิเตอร์ (Cubit + MariaDB via Laravel API)             |
| 14:45-15:30 | Code Review & Best Practices + Unit Test + CI/CD                             |
| 15:30-16:15 | 🔬 **Final PoC Presentation** นำเสนอผลงานแต่ละทีม + Feedback                  |
| 16:15-16:30 | Post-test, สรุปปิดหลักสูตร และมอบ Certificate                                 |

---

## ✅ ตรวจความพร้อมก่อน Workshop

### เวลา 09:30-10:00 น.

ก่อนเริ่มประกอบ Feature ให้ทุกทีมไล่ Checklist ต่อไปนี้ให้ครบ ถ้าข้อใดไม่ผ่านให้รีบแจ้งวิทยากรทันที เพราะทุก Feature ของวันนี้พึ่งพาระบบเหล่านี้ทั้งหมด

**Checklist ที่ 1 - Laravel API รันได้**

```bash
# เข้าโฟลเดอร์โปรเจกต์ Laravel จาก Day 1-4
cd edlgen-api

# รัน Development Server
php artisan serve
# ควรเห็น: Server running on [http://127.0.0.1:8000]

# ทดสอบ Health Check Endpoint
curl http://127.0.0.1:8000/api/v1/health
# ควรได้: {"status":"ok","app":"EDL-Gen Monitoring API"}
```

**Checklist ที่ 2 - WebSocket (Laravel Reverb) ทำงาน**

```bash
# รัน Reverb WebSocket Server (Terminal แยกอีกหน้าต่าง)
php artisan reverb:start --debug
# ควรเห็น: Starting server on 0.0.0.0:8080

# รัน Queue Worker สำหรับ Broadcast Event (Terminal ที่ 3)
php artisan queue:work
```

**Checklist ที่ 3 - Login ได้ (Sanctum ทำงาน)**

```bash
# ทดสอบ Login ด้วยบัญชีที่ Seed ไว้ตั้งแต่ Day 1
curl -X POST http://127.0.0.1:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"email":"engineer@edlgen.la","password":"password123","device_name":"postman"}'

# ควรได้ JSON ที่มี token กลับมา เช่น
# {"data":{"token":"1|xxxxxxxx...","user":{"id":1,"name":"Engineer One",...}}}
```

**Checklist ที่ 4 - Cache และ Database ทำงาน**

```bash
# ตรวจว่า MariaDB Container รันอยู่
docker compose ps
# ควรเห็น service "mariadb" สถานะ Up (Port 3306)

# ตรวจว่า Migration ครบทุกตาราง
php artisan migrate:status

# ตรวจว่า Cache ฝั่ง Laravel ทำงาน (ใช้ database/redis driver ตามที่ตั้งไว้ Day 1)
php artisan tinker --execute="cache()->put('ping','pong',60); echo cache()->get('ping');"
# ควรพิมพ์: pong
```

**Checklist ที่ 5 - ฝั่ง Flutter**

```bash
cd edlgen_monitoring_app
flutter doctor          # ทุกช่องต้องเขียว
flutter pub get         # ติดตั้ง dependency ครบ
dart run build_runner build --delete-conflicting-outputs   # สร้างไฟล์ .g.dart ล่าสุด
flutter run             # แอป Skeleton จาก Day 2-4 ต้องรันขึ้น
```

> ⚠️ **ข้อควรระวังเรื่อง Network:** เมื่อรันบน Android Emulator ให้เรียก Laravel ผ่าน `http://10.0.2.2:8000` (ไม่ใช่ `127.0.0.1`) และ WebSocket ผ่าน `ws://10.0.2.2:8080` ส่วนเครื่องจริง (Physical Device) ให้ใช้ IP ของเครื่องผู้สอนใน LAN เดียวกัน เช่น `http://192.168.1.50:8000` และตรวจว่า Firewall ไม่บล็อก Port 8000/8080

> 📌 **ตารางสรุปสิ่งที่ต้องเปิดค้างไว้ทั้งวัน (3 Terminal + 1 Emulator):**

| Terminal | คำสั่ง                          | หน้าที่                          |
| -------- | -------------------------------- | -------------------------------- |
| 1        | `php artisan serve`              | REST API (Port 8000)             |
| 2        | `php artisan reverb:start`       | WebSocket Server (Port 8080)     |
| 3        | `php artisan queue:work`         | ประมวลผล Broadcast Event / Queue |
| 4        | `flutter run` (หรือรันจาก IDE)   | ตัวแอปบน Emulator/Device         |

---

## 🗺️ ภาพรวมสถาปัตยกรรมของแอปทั้งระบบ

ก่อนลงมือ ให้ทุกคนเห็นภาพเดียวกันว่าเรากำลังประกอบอะไร แผนภาพนี้คือสถาปัตยกรรมทั้งหมดของ **EDL-Gen Monitoring App** ที่รวมทุกสิ่งจาก Day 1-4

```
┌───────────────────────────────────────────────────────────────────────────┐
│                     FLUTTER APP (EDL-Gen Monitoring)                      │
│                                                                           │
│  ┌─────────────────────────── Presentation ───────────────────────────┐  │
│  │  LoginPage   DashboardPage   ReportPage   IncidentPage   MeterPage │  │
│  │      │            │              │             │            │      │  │
│  │   GoRouter (Route Guard: redirect เมื่อไม่มี Token / Token หมดอายุ) │  │
│  └──────┬────────────┬──────────────┬─────────────┬────────────┬──────┘  │
│         │            │              │             │            │         │
│  ┌──────▼────┐ ┌─────▼──────┐ ┌─────▼─────┐ ┌─────▼─────┐ ┌────▼─────┐  │
│  │ AuthCubit │ │ Stream     │ │ Async     │ │ Mutation  │ │ Meter    │  │
│  │ (flutter_ │ │ Provider   │ │ Notifier  │ │ (Riverpod │ │ Entry    │  │
│  │  bloc)    │ │ (Riverpod) │ │ (Riverpod)│ │  3.0)     │ │ Cubit    │  │
│  │ F1: Auth  │ │ F2: Realtime│ │ F3: Report│ │ F4: แจ้ง  │ │ F5: มิเตอร์│  │
│  └──────┬────┘ └─────┬──────┘ └─────┬─────┘ └─────┬─────┘ └────┬─────┘  │
│         │            │              │             │            │         │
│  ┌──────▼────────────▼──────────────▼─────────────▼────────────▼──────┐  │
│  │                        Data Layer (Repository)                     │  │
│  │   AuthRepository │ PowerSocketService │ ReportRepository │ ...     │  │
│  │        Dio (REST + Interceptor)      web_socket_channel            │  │
│  │        flutter_secure_storage        sqflite (Offline Cache)       │  │
│  └──────────┬──────────────────────────────┬─────────────────────────┘  │
└─────────────┼──────────────────────────────┼────────────────────────────┘
              │ HTTPS (REST/JSON)            │ WebSocket (Pusher Protocol)
              ▼                              ▼
┌─────────────────────────────┐  ┌──────────────────────────────┐
│   LARAVEL 13 API (Port 8000)│  │  LARAVEL REVERB (Port 8080)  │
│  ┌───────────────────────┐  │  │  Channel: power.readings     │
│  │ routes/api.php (v1)   │  │  │  Event: PowerReadingUpdated  │
│  │ Middleware: sanctum   │  │  └──────────────▲───────────────┘
│  │ Controller → Service  │  │                 │ broadcast()
│  │  → Repository Pattern │◄─┼─────────────────┘
│  │ API Resources (JSON)  │  │   Queue Worker (queue:work)
│  └───────────┬───────────┘  │
└──────────────┼──────────────┘
               │ Eloquent ORM
               ▼
┌─────────────────────────────────────────────┐
│              MariaDB 11.x (Docker)          │
│  users │ plants │ power_readings            │
│  daily_reports │ incidents │ meter_readings │
│  personal_access_tokens (Sanctum)           │
└─────────────────────────────────────────────┘
```

> 💡 **หัวใจของสถาปัตยกรรมนี้:** State Management แบบ Hybrid ที่เราวางไว้ตั้งแต่ Day 1 คือ **Riverpod 3.0 ดูแล Data Layer และ Async State** (Dashboard, Report, Mutation) ส่วน **Cubit ดูแล Business Logic ที่มีลำดับขั้นชัดเจน** (Auth Session, Form บันทึกมิเตอร์) แต่ละ Feature ของวันนี้จะตอกย้ำการแบ่งหน้าที่นี้ให้เห็นชัดเจน

**สรุปว่าแต่ละ Feature ใช้ความรู้จากวันไหน:**

| Feature วันนี้                  | State Management       | ความรู้หลักจาก Day |
| ------------------------------- | ---------------------- | ------------------ |
| F1 Login & Auth Flow            | Cubit (AuthCubit)      | Day 1 + Day 4      |
| F2 Real-time Power Dashboard    | StreamProvider         | Day 4              |
| F3 รายงานการผลิตรายวัน + Offline | AsyncNotifier + sqflite | Day 1 + Day 3 + Day 4 |
| F4 แจ้งเหตุขัดข้องเครื่องจักร     | Mutations API          | Day 1              |
| F5 บันทึกค่ามิเตอร์               | Cubit                  | Day 2 + Day 4      |

---

## 🛠️ Feature 1 - Login & Auth Flow (Cubit + Laravel Sanctum)

### เวลา 10:00-10:45 น.

> 💡 **หัวใจของ Feature นี้:** ประตูหน้าบ้านของแอป ทุก Feature ที่เหลือต้องผ่าน Token จากด่านนี้ก่อน เราจะประกอบ AuthCubit (Day 4) เข้ากับ Sanctum API (Day 1) แล้วปิดท้ายด้วย Route Guard ที่ทำให้ผู้ใช้ที่ Token หมดอายุถูกส่งกลับหน้า Login โดยอัตโนมัติ

### ขั้นที่ 1 - ฝั่ง Laravel: Auth Endpoint ทั้ง 3 เส้น

ทบทวน Route ที่เราสร้างไว้ตั้งแต่ Day 1 และเพิ่มเส้น `refresh` ให้ครบ:

```php
<?php
// routes/api.php
use App\Http\Controllers\Api\V1\AuthController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    // Endpoint สาธารณะ - ไม่ต้องมี Token
    Route::get('/health', fn () => response()->json([
        'status' => 'ok',
        'app'    => 'EDL-Gen Monitoring API',
    ]));
    Route::post('/auth/login', [AuthController::class, 'login']);

    // Endpoint ที่ต้องมี Token (ผ่าน Middleware auth:sanctum)
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/auth/refresh', [AuthController::class, 'refresh']);
        Route::post('/auth/logout',  [AuthController::class, 'logout']);
        Route::get('/auth/me',       [AuthController::class, 'me']);
    });
});
```

```php
<?php
// app/Http/Controllers/Api/V1/AuthController.php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Login: ตรวจ email/password แล้วออก Token ใหม่ (อายุ 60 นาที)
     */
    public function login(Request $request): JsonResponse
    {
        // Validate ข้อมูลขาเข้า - ถ้าไม่ผ่านจะตอบ 422 อัตโนมัติ
        $credentials = $request->validate([
            'email'       => ['required', 'email'],
            'password'    => ['required', 'string'],
            'device_name' => ['required', 'string'], // เช่น "samsung-a54"
        ]);

        $user = User::where('email', $credentials['email'])->first();

        // ตรวจรหัสผ่านด้วย Hash::check - ห้ามเทียบ plain text เด็ดขาด
        if (! $user || ! Hash::check($credentials['password'], $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['ข้อมูลเข้าสู่ระบบไม่ถูกต้อง'],
            ]);
        }

        // ออก Token ใหม่พร้อม ability และวันหมดอายุ
        $token = $user->createToken(
            name: $credentials['device_name'],
            abilities: ['monitoring:read', 'monitoring:write'],
            expiresAt: now()->addMinutes(60),
        );

        return response()->json([
            'data' => [
                'token'      => $token->plainTextToken,
                'expires_at' => $token->accessToken->expires_at?->toIso8601String(),
                'user'       => new UserResource($user),
            ],
        ]);
    }

    /**
     * Refresh: ลบ Token เดิมที่กำลังใช้อยู่ แล้วออกใบใหม่ (Rotate Token)
     */
    public function refresh(Request $request): JsonResponse
    {
        $user = $request->user();

        // ลบเฉพาะ Token ปัจจุบันที่แนบมากับ Request นี้
        $request->user()->currentAccessToken()->delete();

        $token = $user->createToken(
            name: 'refreshed-' . now()->timestamp,
            abilities: ['monitoring:read', 'monitoring:write'],
            expiresAt: now()->addMinutes(60),
        );

        return response()->json([
            'data' => [
                'token'      => $token->plainTextToken,
                'expires_at' => $token->accessToken->expires_at?->toIso8601String(),
            ],
        ]);
    }

    /**
     * Logout: ลบ Token ปัจจุบันทิ้ง - เครื่องอื่นของ user เดิมยัง Login อยู่ได้
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'ออกจากระบบเรียบร้อย']);
    }

    /**
     * Me: คืนข้อมูลผู้ใช้ปัจจุบัน - ใช้ตรวจว่า Token ยังใช้ได้หรือไม่ตอนเปิดแอป
     */
    public function me(Request $request): JsonResponse
    {
        return response()->json(['data' => new UserResource($request->user())]);
    }
}
```

> 📌 **จุดที่มักพลาด:** อย่าลืมตั้ง `'expiration' => 60` (นาที) ใน `config/sanctum.php` เป็นค่า fallback และตรวจว่า Model `User` ใช้ trait `HasApiTokens` แล้วตั้งแต่ Day 1

### ขั้นที่ 2 - ฝั่ง Flutter: AuthState และ AuthCubit

โครงสร้างไฟล์ของ Feature นี้ (Feature-first ตามที่วางไว้ Day 2):

```
lib/features/auth/
├── data/
│   ├── auth_repository.dart       ← เรียก API ผ่าน Dio
│   └── token_storage.dart         ← flutter_secure_storage
├── logic/
│   ├── auth_cubit.dart            ← Business Logic ทั้งหมดของ Session
│   └── auth_state.dart
└── presentation/
    └── login_page.dart
```

```dart
// lib/features/auth/logic/auth_state.dart
import 'package:equatable/equatable.dart';
import '../data/models/auth_user.dart';

enum AuthStatus { unknown, authenticating, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthUser? user;       // ข้อมูลผู้ใช้เมื่อ Login สำเร็จ
  final String? errorMessage; // ข้อความ error สำหรับแสดงบน UI

  AuthState copyWith({AuthStatus? status, AuthUser? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
```

```dart
// lib/features/auth/logic/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_repository.dart';
import '../data/token_storage.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository repository,
    required TokenStorage tokenStorage,
  })  : _repository = repository,
        _tokenStorage = tokenStorage,
        super(const AuthState());

  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  /// เรียกตอนเปิดแอป - ตรวจว่ามี Token เดิมค้างอยู่และยังใช้ได้หรือไม่
  Future<void> checkSession() async {
    final token = await _tokenStorage.readToken();
    if (token == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }
    try {
      final user = await _repository.me(); // ยิง GET /auth/me เพื่อยืนยัน Token
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (_) {
      await _tokenStorage.clear(); // Token หมดอายุ/ถูกเพิกถอน - ล้างทิ้ง
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  /// Login ด้วย email/password
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    try {
      final result = await _repository.login(email: email, password: password);
      await _tokenStorage.saveToken(result.token, result.expiresAt);
      emit(state.copyWith(status: AuthStatus.authenticated, user: result.user));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'เข้าสู่ระบบไม่สำเร็จ: ตรวจสอบอีเมลหรือรหัสผ่าน',
      ));
    }
  }

  /// Refresh Token - เรียกโดย Dio Interceptor เมื่อเจอ 401
  Future<bool> refreshToken() async {
    try {
      final result = await _repository.refresh();
      await _tokenStorage.saveToken(result.token, result.expiresAt);
      return true;
    } catch (_) {
      await logout(); // Refresh ไม่ผ่าน = Session จบ ให้ Logout ทั้งแอป
      return false;
    }
  }

  /// Logout - แจ้ง Server แล้วล้าง Token ฝั่งเครื่อง
  Future<void> logout() async {
    try {
      await _repository.logout(); // best-effort: Server ลบ Token
    } catch (_) {
      // ถึง Server ล่มก็ต้อง Logout ฝั่งเครื่องให้ได้
    }
    await _tokenStorage.clear();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
```

### ขั้นที่ 3 - Dio Interceptor: แนบ Token + Auto Refresh เมื่อเจอ 401

```dart
// lib/core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/auth/data/token_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStorage, required this.authCubit, required this.dio});

  final TokenStorage tokenStorage;
  final AuthCubit authCubit;
  final Dio dio;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // แนบ Bearer Token ทุก Request (ยกเว้นเส้น login)
    final token = await tokenStorage.readToken();
    if (token != null && !options.path.contains('/auth/login')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // เจอ 401 = Token หมดอายุ → ลอง Refresh หนึ่งครั้งแล้ว Retry Request เดิม
    final isRetry = err.requestOptions.extra['retried'] == true;
    if (err.response?.statusCode == 401 && !isRetry) {
      final refreshed = await authCubit.refreshToken();
      if (refreshed) {
        final newToken = await tokenStorage.readToken();
        final opts = err.requestOptions
          ..headers['Authorization'] = 'Bearer $newToken'
          ..extra['retried'] = true; // กัน Loop Refresh ไม่รู้จบ
        final response = await dio.fetch(opts);
        return handler.resolve(response);
      }
    }
    handler.next(err);
  }
}
```

### ขั้นที่ 4 - Route Guard ด้วย GoRouter Redirect

นี่คือชิ้นส่วนสุดท้ายที่ทำให้ Auth Flow "ครบวงจร" - เมื่อ AuthCubit เปลี่ยน State ไม่ว่าจากการ Login สำเร็จหรือ Token หมดอายุกลางทาง GoRouter จะพาผู้ใช้ไปหน้าที่ถูกต้องเองเสมอ:

```dart
// lib/core/router/app_router.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/auth/logic/auth_state.dart';
// ... import หน้าต่าง ๆ

/// แปลง Stream ของ Cubit ให้เป็น Listenable เพื่อให้ GoRouter re-evaluate redirect
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

GoRouter buildRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/dashboard',
    // ทุกครั้งที่ AuthCubit emit state ใหม่ → GoRouter จะเรียก redirect ซ้ำ
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final authStatus = authCubit.state.status;
      final isLoggingIn = state.matchedLocation == '/login';

      // ยังตรวจ Session ไม่เสร็จ (ตอนเปิดแอป) → ค้างที่ Splash
      if (authStatus == AuthStatus.unknown) return '/splash';

      // ไม่ได้ Login (หรือ Token หมดอายุ) → บังคับไปหน้า Login
      final isAuthenticated = authStatus == AuthStatus.authenticated;
      if (!isAuthenticated && !isLoggingIn) return '/login';

      // Login แล้วแต่ยังอยู่หน้า Login → พาเข้า Dashboard
      if (isAuthenticated && isLoggingIn) return '/dashboard';

      return null; // ไม่ต้อง redirect
    },
    routes: [
      GoRoute(path: '/splash',    builder: (_, __) => const SplashPage()),
      GoRoute(path: '/login',     builder: (_, __) => const LoginPage()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardPage()),
      GoRoute(path: '/reports',   builder: (_, __) => const ReportPage()),
      GoRoute(path: '/incidents/new', builder: (_, __) => const IncidentFormPage()),
      GoRoute(path: '/meters/new',    builder: (_, __) => const MeterFormPage()),
    ],
  );
}
```

> ✅ **จุดเชื่อมที่สวยที่สุดของ Feature นี้:** เมื่อ Interceptor Refresh Token ไม่สำเร็จ มันเรียก `authCubit.logout()` → Cubit emit `unauthenticated` → `refreshListenable` สะกิด GoRouter → `redirect` ส่งผู้ใช้กลับหน้า Login โดยที่เราไม่ต้องเขียน `Navigator.push` เองแม้แต่บรรทัดเดียว

> **ผลลัพธ์ที่คาดหวัง Feature 1:** Login ด้วย `engineer@edlgen.la` แล้วเข้า Dashboard ได้, กด Logout แล้วเด้งกลับหน้า Login, ทดสอบ Token หมดอายุโดยลบ Token ในตาราง `personal_access_tokens` ผ่าน TablePlus แล้วดึง API ใด ๆ - แอปต้อง Refresh ไม่ผ่านและเด้งกลับหน้า Login อัตโนมัติ

---

## 🛠️ Feature 2 - Real-time Power Dashboard (StreamProvider + WebSocket)

### เวลา 10:45-11:30 น.

> 💡 **หัวใจของ Feature นี้:** หน้าจอที่ "ขายได้" ที่สุดของ PoC - ค่ากำลังผลิต (MW), ความถี่ (Hz) และ Voltage วิ่งบนกราฟแบบ Real-time โดยไม่ต้องกด Refresh เพราะ Laravel เป็นฝ่าย Push ข้อมูลผ่าน WebSocket มาให้ Flutter เอง เราประกอบ Event Broadcast (ฝั่ง Server) เข้ากับ StreamProvider (Day 4) และ `fl_chart`

### ขั้นที่ 1 - ฝั่ง Laravel: Event Broadcast

สร้าง Event ที่จะถูกยิงทุกครั้งที่มีค่าการผลิตใหม่เข้ามา (จากระบบ SCADA จริงในอนาคต วันนี้เราจำลองด้วย Command):

```php
<?php
// app/Events/PowerReadingUpdated.php
namespace App\Events;

use App\Models\PowerReading;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class PowerReadingUpdated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct(public PowerReading $reading)
    {
    }

    /** ชื่อ Channel ที่ Flutter จะ Subscribe */
    public function broadcastOn(): array
    {
        return [new Channel('power.readings')];
    }

    /** ชื่อ Event ฝั่ง Client (ไม่ต้องมี namespace ยาว ๆ) */
    public function broadcastAs(): string
    {
        return 'power.reading.updated';
    }

    /** Payload ที่ส่งไปให้ Flutter - เลือกเฉพาะ field ที่ต้องใช้ */
    public function broadcastWith(): array
    {
        return [
            'plant_id'    => $this->reading->plant_id,
            'plant_name'  => $this->reading->plant->name,
            'power_mw'    => (float) $this->reading->power_mw,     // กำลังผลิต (เมกะวัตต์)
            'frequency'   => (float) $this->reading->frequency,    // ความถี่ (Hz)
            'voltage_kv'  => (float) $this->reading->voltage_kv,   // แรงดัน (kV)
            'recorded_at' => $this->reading->recorded_at->toIso8601String(),
        ];
    }
}
```

ตั้งค่า Broadcast Driver เป็น Reverb ใน `.env` (ทำไว้แล้วบางส่วนตั้งแต่ Day 4 - ตรวจให้ครบ):

```bash
# .env (ฝั่ง Laravel)
BROADCAST_CONNECTION=reverb

REVERB_APP_ID=edlgen
REVERB_APP_KEY=edlgen-local-key
REVERB_APP_SECRET=edlgen-local-secret
REVERB_HOST=0.0.0.0
REVERB_PORT=8080
REVERB_SCHEME=http
```

สร้าง Artisan Command จำลองข้อมูลจากโรงไฟฟ้า ยิงค่าใหม่ทุก 3 วินาที:

```php
<?php
// app/Console/Commands/SimulatePowerReadings.php
namespace App\Console\Commands;

use App\Events\PowerReadingUpdated;
use App\Models\Plant;
use App\Models\PowerReading;
use Illuminate\Console\Command;

class SimulatePowerReadings extends Command
{
    protected $signature = 'edlgen:simulate-readings {--interval=3 : วินาทีระหว่างข้อมูลแต่ละชุด}';
    protected $description = 'จำลองค่าการผลิตไฟฟ้าแบบ Real-time สำหรับ Workshop';

    public function handle(): void
    {
        $interval = (int) $this->option('interval');
        $plant = Plant::first(); // ใช้โรงผลิตแรกจาก Seeder เช่น "Nam Theun Hydro"

        $this->info("เริ่มจำลองข้อมูลของโรงผลิต: {$plant->name} (Ctrl+C เพื่อหยุด)");

        while (true) {
            // สุ่มค่ารอบ ๆ จุดทำงานปกติของโรงไฟฟ้าพลังน้ำ
            $reading = PowerReading::create([
                'plant_id'    => $plant->id,
                'power_mw'    => round(mt_rand(9000, 11000) / 100, 2),  // 90.00-110.00 MW
                'frequency'   => round(mt_rand(4990, 5010) / 100, 2),   // 49.90-50.10 Hz
                'voltage_kv'  => round(mt_rand(2245, 2320) / 100, 2),   // 22.45-23.20 kV
                'recorded_at' => now(),
            ]);

            // ยิง Event → Reverb → Flutter ทุกเครื่องที่ Subscribe อยู่
            PowerReadingUpdated::dispatch($reading);
            $this->line("ส่งค่า: {$reading->power_mw} MW | {$reading->frequency} Hz");

            sleep($interval);
        }
    }
}
```

```bash
# เปิด Terminal ที่ 5 แล้วรัน (ปล่อยค้างไว้ตลอด Workshop)
php artisan edlgen:simulate-readings --interval=3
```

> ⚠️ **ทำไมใช้ `ShouldBroadcastNow`:** ใน Workshop เราต้องการเห็นผลทันทีโดยไม่รอ Queue แต่ในระบบจริงที่มี Event ถี่มากควรใช้ `ShouldBroadcast` (ผ่าน Queue) แล้ว scale Queue Worker แยกต่างหาก เพื่อไม่ให้ Request หลักช้า

### ขั้นที่ 2 - ฝั่ง Flutter: Model และ WebSocket Service

```dart
// lib/features/dashboard/data/models/power_reading.dart
class PowerReading {
  const PowerReading({
    required this.plantId,
    required this.plantName,
    required this.powerMw,
    required this.frequency,
    required this.voltageKv,
    required this.recordedAt,
  });

  final int plantId;
  final String plantName;
  final double powerMw;    // กำลังผลิต (MW)
  final double frequency;  // ความถี่ (Hz)
  final double voltageKv;  // แรงดัน (kV)
  final DateTime recordedAt;

  factory PowerReading.fromJson(Map<String, dynamic> json) {
    return PowerReading(
      plantId: json['plant_id'] as int,
      plantName: json['plant_name'] as String,
      powerMw: (json['power_mw'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      voltageKv: (json['voltage_kv'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
    );
  }
}
```

Reverb ใช้ Pusher Protocol ดังนั้นฝั่ง Flutter ต้อง (1) ต่อ WebSocket ไปที่ `/app/{APP_KEY}` (2) ส่งข้อความ `pusher:subscribe` เพื่อเข้าร่วม Channel (3) กรองเฉพาะ Event ที่ต้องการ:

```dart
// lib/features/dashboard/data/power_socket_service.dart
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'models/power_reading.dart';

class PowerSocketService {
  static const _wsUrl = 'ws://10.0.2.2:8080/app/edlgen-local-key'; // Emulator → เครื่อง host

  /// เปิดการเชื่อมต่อและคืน Stream ของ PowerReading ที่พร้อมใช้
  Stream<PowerReading> connect() {
    final channel = WebSocketChannel.connect(Uri.parse(_wsUrl));

    // ขั้นตอนตาม Pusher Protocol: ประกาศตัวเข้า Channel "power.readings"
    channel.sink.add(jsonEncode({
      'event': 'pusher:subscribe',
      'data': {'channel': 'power.readings'},
    }));

    // แปลงทุกข้อความดิบ → กรองเฉพาะ event ของเรา → parse เป็น Model
    return channel.stream
        .map((raw) => jsonDecode(raw as String) as Map<String, dynamic>)
        .where((msg) => msg['event'] == 'power.reading.updated')
        .map((msg) {
      // Pusher ส่ง data มาเป็น String ซ้อน JSON อีกชั้น ต้อง decode ซ้ำ
      final data = jsonDecode(msg['data'] as String) as Map<String, dynamic>;
      return PowerReading.fromJson(data);
    });
  }
}
```

### ขั้นที่ 3 - StreamProvider + ตัวสะสมประวัติสำหรับกราฟ

```dart
// lib/features/dashboard/logic/power_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/power_socket_service.dart';
import '../data/models/power_reading.dart';

part 'power_providers.g.dart';

/// Service เป็น Singleton ผ่าน Provider ธรรมดา
@riverpod
PowerSocketService powerSocketService(Ref ref) => PowerSocketService();

/// StreamProvider: ทุกครั้งที่ Server push → AsyncValue ใหม่ → UI rebuild เอง
@riverpod
Stream<PowerReading> latestPowerReading(Ref ref) {
  return ref.watch(powerSocketServiceProvider).connect();
}

/// Notifier สะสมค่าล่าสุด 30 จุด สำหรับวาด LineChart
@riverpod
class PowerHistory extends _$PowerHistory {
  static const _maxPoints = 30;

  @override
  List<PowerReading> build() {
    // ฟัง StreamProvider - เมื่อมีค่าใหม่ให้ต่อท้าย List แล้วตัดหัวถ้าเกิน 30
    ref.listen(latestPowerReadingProvider, (previous, next) {
      next.whenData((reading) {
        final updated = [...state, reading];
        state = updated.length > _maxPoints
            ? updated.sublist(updated.length - _maxPoints)
            : updated;
      });
    });
    return const [];
  }
}
```

### ขั้นที่ 4 - Dashboard UI ด้วย fl_chart (LineChart)

```dart
// lib/features/dashboard/presentation/dashboard_page.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/power_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(latestPowerReadingProvider); // AsyncValue<PowerReading>
    final history = ref.watch(powerHistoryProvider);      // List<PowerReading>

    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Power Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // แถวการ์ดตัวเลขล่าสุด 3 ค่า - ใช้ StatCard ที่สร้างไว้ Day 2
            latest.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => _ErrorBanner(message: 'WebSocket หลุด: $e'),
              data: (r) => Row(
                children: [
                  Expanded(child: StatCard(label: 'กำลังผลิต', value: '${r.powerMw.toStringAsFixed(1)} MW')),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(label: 'ความถี่', value: '${r.frequency.toStringAsFixed(2)} Hz')),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(label: 'แรงดัน', value: '${r.voltageKv.toStringAsFixed(2)} kV')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('กำลังผลิต (MW) - 30 ค่าล่าสุด',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // กราฟเส้น Real-time
            Expanded(
              child: history.isEmpty
                  ? const Center(child: Text('รอข้อมูลชุดแรกจาก Server...'))
                  : LineChart(
                      LineChartData(
                        minY: 85,  // ช่วงแกน Y ครอบคลุมค่าจำลอง 90-110 MW
                        maxY: 115,
                        titlesData: const FlTitlesData(
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            // แปลง history → จุด (x = ลำดับ, y = ค่า MW)
                            spots: [
                              for (var i = 0; i < history.length; i++)
                                FlSpot(i.toDouble(), history[i].powerMw),
                            ],
                            isCurved: true,
                            barWidth: 3,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: true),
                          ),
                        ],
                      ),
                      // ทำให้กราฟเลื่อนนุ่ม ๆ เมื่อข้อมูลใหม่เข้า
                      duration: const Duration(milliseconds: 250),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
```

> ✅ **จุดสังเกตสำคัญ:** UI ไม่มี Timer, ไม่มี Polling, ไม่มี `setState` แม้แต่บรรทัดเดียว - ข้อมูลไหลทางเดียวจาก `SimulatePowerReadings` → Reverb → `PowerSocketService` → `latestPowerReadingProvider` → `PowerHistory` → กราฟ ทั้งหมดเป็น Reactive ตามแนวคิดที่เรียนใน Day 4

> 📌 **การ Reconnect:** StreamProvider ใน Riverpod 3.0 รองรับ `retry` อัตโนมัติเมื่อ Stream error (ค่า default เป็น exponential backoff) ถ้าต้องการปรับแต่ง กำหนดที่ `ProviderScope(retry: ...)` ระดับแอป หรือทดสอบง่าย ๆ โดยปิด Reverb แล้วเปิดใหม่ ดูว่าแอปกลับมารับข้อมูลเองได้

> **ผลลัพธ์ที่คาดหวัง Feature 2:** เปิดหน้า Dashboard แล้วการ์ด MW/Hz/kV กระพริบค่าใหม่ทุก 3 วินาที กราฟเส้นวิ่งไปทางขวาเรื่อย ๆ โดยเก็บแค่ 30 จุดล่าสุด และเมื่อปิด `edlgen:simulate-readings` กราฟหยุดนิ่ง (ไม่ crash) เมื่อเปิดใหม่ข้อมูลไหลต่อทันที

---

## 🛠️ Feature 3 - รายงานการผลิตรายวัน (AsyncNotifier + Offline Cache)

### เวลา 11:30-12:00 น. และ 13:00-13:30 น. (คร่อมพักเที่ยง)

> 💡 **หัวใจของ Feature นี้:** โรงผลิตของ EDL-Gen หลายแห่งอยู่ในพื้นที่ห่างไกลที่สัญญาณอินเทอร์เน็ตไม่เสถียร Feature นี้จึงเป็น **Offline-First**: ดึงรายงานจาก API เมื่อออนไลน์ + เก็บสำเนาลง SQLite เสมอ เมื่อ Network หายผู้ใช้ยังเปิดดูรายงานล่าสุดได้ พร้อม Filter ตามช่วงเวลาและโรงผลิต

### ขั้นที่ 1 - ฝั่ง Laravel: Endpoint รายงานพร้อม Filter

```php
<?php
// routes/api.php (เพิ่มในกลุ่ม auth:sanctum)
use App\Http\Controllers\Api\V1\DailyReportController;

Route::get('/reports/daily', [DailyReportController::class, 'index']);
Route::get('/plants',        [PlantController::class, 'index']); // สำหรับ Dropdown โรงผลิต
```

```php
<?php
// app/Http/Controllers/Api/V1/DailyReportController.php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\DailyReportResource;
use App\Models\DailyReport;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class DailyReportController extends Controller
{
    /**
     * GET /api/v1/reports/daily?date_from=2026-07-01&date_to=2026-07-15&plant_id=2
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $filters = $request->validate([
            'date_from' => ['nullable', 'date'],
            'date_to'   => ['nullable', 'date', 'after_or_equal:date_from'],
            'plant_id'  => ['nullable', 'integer', 'exists:plants,id'],
        ]);

        $reports = DailyReport::query()
            ->with('plant')
            // when() = ใส่เงื่อนไขเฉพาะเมื่อ Filter ถูกส่งมา - Query อ่านง่ายไม่ต้อง if ซ้อน
            ->when($filters['date_from'] ?? null,
                fn ($q, $date) => $q->whereDate('report_date', '>=', $date))
            ->when($filters['date_to'] ?? null,
                fn ($q, $date) => $q->whereDate('report_date', '<=', $date))
            ->when($filters['plant_id'] ?? null,
                fn ($q, $id) => $q->where('plant_id', $id))
            ->orderByDesc('report_date')
            ->limit(60) // จำกัดขนาด payload สำหรับ Mobile
            ->get();

        return DailyReportResource::collection($reports);
    }
}
```

```php
<?php
// app/Http/Resources/DailyReportResource.php
namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DailyReportResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'             => $this->id,
            'plant_id'       => $this->plant_id,
            'plant_name'     => $this->plant->name,
            'report_date'    => $this->report_date->format('Y-m-d'),
            'energy_mwh'     => (float) $this->energy_mwh,      // พลังงานที่ผลิตได้ (MWh)
            'peak_mw'        => (float) $this->peak_mw,         // ค่าสูงสุดของวัน (MW)
            'availability'   => (float) $this->availability,    // % ความพร้อมจ่าย
            'water_level_m'  => (float) $this->water_level_m,   // ระดับน้ำ (เมตร) สำหรับเขื่อน
        ];
    }
}
```

### ขั้นที่ 2 - ฝั่ง Flutter: Local Data Source (sqflite)

```dart
// lib/features/reports/data/report_local_data_source.dart
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'models/daily_report.dart';

class ReportLocalDataSource {
  Database? _db;

  Future<Database> _open() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'edlgen_cache.db'),
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE daily_reports (
          id INTEGER PRIMARY KEY,
          plant_id INTEGER NOT NULL,
          report_date TEXT NOT NULL,
          payload TEXT NOT NULL,      -- เก็บ JSON ทั้งก้อน อ่านกลับง่าย
          cached_at TEXT NOT NULL     -- เวลาบันทึก Cache ไว้แสดง "ข้อมูล ณ เวลา"
        )
      '''),
    );
    return _db!;
  }

  /// บันทึกรายงานชุดล่าสุดทับของเดิม (Replace Strategy - ง่ายและพอสำหรับ PoC)
  Future<void> saveReports(List<DailyReport> reports) async {
    final db = await _open();
    final batch = db.batch();
    for (final r in reports) {
      batch.insert(
        'daily_reports',
        {
          'id': r.id,
          'plant_id': r.plantId,
          'report_date': r.reportDate,
          'payload': jsonEncode(r.toJson()),
          'cached_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// อ่านรายงานจาก Cache พร้อม Filter เดียวกับฝั่ง API
  Future<List<DailyReport>> loadReports({
    String? dateFrom,
    String? dateTo,
    int? plantId,
  }) async {
    final db = await _open();
    final where = <String>[];
    final args = <Object>[];

    if (dateFrom != null) { where.add('report_date >= ?'); args.add(dateFrom); }
    if (dateTo   != null) { where.add('report_date <= ?'); args.add(dateTo); }
    if (plantId  != null) { where.add('plant_id = ?');     args.add(plantId); }

    final rows = await db.query(
      'daily_reports',
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args.isEmpty ? null : args,
      orderBy: 'report_date DESC',
    );

    return rows
        .map((row) => DailyReport.fromJson(
            jsonDecode(row['payload'] as String) as Map<String, dynamic>))
        .toList();
  }
}
```

### ขั้นที่ 3 - Repository: API ก่อน Cache เสมอ, ล้มเมื่อไหร่ค่อยใช้ Cache

```dart
// lib/features/reports/data/report_repository.dart
import 'package:dio/dio.dart';
import 'models/daily_report.dart';
import 'report_local_data_source.dart';

/// ผลลัพธ์ที่บอกด้วยว่าข้อมูลมาจากไหน - UI ใช้แสดง Banner "โหมด Offline"
class ReportResult {
  const ReportResult({required this.reports, required this.fromCache});
  final List<DailyReport> reports;
  final bool fromCache;
}

class ReportRepository {
  ReportRepository({required this.dio, required this.local});

  final Dio dio;
  final ReportLocalDataSource local;

  Future<ReportResult> getDailyReports({
    String? dateFrom,
    String? dateTo,
    int? plantId,
  }) async {
    try {
      // 1) พยายามดึงจาก API ก่อนเสมอ
      final response = await dio.get('/reports/daily', queryParameters: {
        if (dateFrom != null) 'date_from': dateFrom,
        if (dateTo != null) 'date_to': dateTo,
        if (plantId != null) 'plant_id': plantId,
      });

      final reports = (response.data['data'] as List)
          .map((json) => DailyReport.fromJson(json as Map<String, dynamic>))
          .toList();

      // 2) สำเร็จ → เขียนทับ Cache ทันที (Cache สดใหม่เสมอ)
      await local.saveReports(reports);
      return ReportResult(reports: reports, fromCache: false);
    } on DioException {
      // 3) Network ล้ม → Fallback ไปอ่าน SQLite ด้วย Filter เดียวกัน
      final cached = await local.loadReports(
        dateFrom: dateFrom, dateTo: dateTo, plantId: plantId);
      if (cached.isEmpty) rethrow; // ไม่มี Cache เลย ให้ error ไปแสดงตามจริง
      return ReportResult(reports: cached, fromCache: true);
    }
  }
}
```

### ขั้นที่ 4 - AsyncNotifier + Filter State

Filter เป็น State แยกต่างหาก เมื่อผู้ใช้เปลี่ยน Filter ตัว AsyncNotifier จะดึงข้อมูลชุดใหม่เองเพราะ `build()` ไป `watch` Filter ไว้:

```dart
// lib/features/reports/logic/report_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/report_repository.dart';

part 'report_providers.g.dart';

/// เงื่อนไข Filter ปัจจุบันของหน้ารายงาน
class ReportFilter {
  const ReportFilter({this.dateFrom, this.dateTo, this.plantId});
  final String? dateFrom; // รูปแบบ 'YYYY-MM-DD'
  final String? dateTo;
  final int? plantId;

  ReportFilter copyWith({String? dateFrom, String? dateTo, int? plantId}) =>
      ReportFilter(
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        plantId: plantId ?? this.plantId,
      );
}

@riverpod
class ReportFilterState extends _$ReportFilterState {
  @override
  ReportFilter build() => const ReportFilter(); // เริ่มต้นไม่กรองอะไรเลย

  void setDateRange(String from, String to) =>
      state = state.copyWith(dateFrom: from, dateTo: to);
  void setPlant(int? plantId) => state = state.copyWith(plantId: plantId);
  void clear() => state = const ReportFilter();
}

/// AsyncNotifier หลักของหน้ารายงาน
@riverpod
class DailyReports extends _$DailyReports {
  @override
  Future<ReportResult> build() async {
    // watch Filter → เมื่อ Filter เปลี่ยน provider นี้ rebuild และดึงข้อมูลใหม่เอง
    final filter = ref.watch(reportFilterStateProvider);
    final repository = ref.watch(reportRepositoryProvider);

    return repository.getDailyReports(
      dateFrom: filter.dateFrom,
      dateTo: filter.dateTo,
      plantId: filter.plantId,
    );
  }

  /// Pull-to-refresh จาก UI
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
```

### ขั้นที่ 5 - UI: Banner โหมด Offline + Filter Bar

```dart
// lib/features/reports/presentation/report_page.dart (ส่วนสำคัญ)
class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(dailyReportsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('รายงานการผลิตรายวัน')),
      body: Column(
        children: [
          const ReportFilterBar(), // Dropdown โรงผลิต + DateRangePicker (เรียก ReportFilterState)
          Expanded(
            child: reportsAsync.when(
              loading: () => const ReportListSkeleton(), // Skeleton จาก Day 3
              error: (e, _) => ErrorRetryView(
                message: 'โหลดรายงานไม่สำเร็จและไม่มีข้อมูลใน Cache',
                onRetry: () => ref.read(dailyReportsProvider.notifier).refresh(),
              ),
              data: (result) => Column(
                children: [
                  // Banner สีเหลืองเมื่อกำลังแสดงข้อมูลจาก Cache
                  if (result.fromCache)
                    Container(
                      width: double.infinity,
                      color: Colors.amber.shade100,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        '📴 โหมด Offline - แสดงข้อมูลล่าสุดที่บันทึกไว้ในเครื่อง',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          ref.read(dailyReportsProvider.notifier).refresh(),
                      child: ListView.builder(
                        itemCount: result.reports.length,
                        itemBuilder: (_, i) =>
                            DailyReportTile(report: result.reports[i]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

> ⚠️ **การทดสอบ Offline ที่ถูกวิธี:** เปิดหน้ารายงานให้โหลดสำเร็จหนึ่งครั้งก่อน (เพื่อให้มี Cache) จากนั้นเปิด Airplane Mode บน Emulator (`...` → Cellular → Airplane) แล้ว Pull-to-refresh - ต้องเห็น Banner สีเหลืองและรายการยังอยู่ครบ ถ้าเปิด Airplane ตั้งแต่แรกโดยไม่เคยมี Cache จะเห็นหน้า Error พร้อมปุ่ม Retry ซึ่งเป็นพฤติกรรมที่ถูกต้อง

> **ผลลัพธ์ที่คาดหวัง Feature 3:** เลือกช่วงวันที่ 1-15 ก.ค. และโรงผลิต "Nam Theun Hydro" แล้วรายการกรองถูกต้อง, ปิด Network แล้วยังเปิดดูรายงานได้พร้อม Banner โหมด Offline, Filter ยังทำงานได้แม้ Offline เพราะ Query จาก SQLite ด้วยเงื่อนไขเดียวกัน

---

## 🛠️ Feature 4 - แจ้งเหตุขัดข้องเครื่องจักร (Mutations API + Push Notification)

### เวลา 13:30-14:15 น.

> 💡 **หัวใจของ Feature นี้:** งานเขียน (Write Operation) ที่ "มีน้ำหนัก" ที่สุดของแอป - ช่างภาคสนามถ่ายรูปเครื่องจักรที่มีปัญหา แนบพิกัด GPS เลือกระดับความรุนแรง แล้วส่งขึ้น Server เป็น `multipart/form-data` เราใช้ **Riverpod 3.0 Mutations API** เพื่อให้ UI แสดงสถานะ `idle → pending → success/error` ครบวงจรโดยไม่ต้องสร้าง State class เอง

### ขั้นที่ 1 - ฝั่ง Laravel: รับ multipart + Validation + Notification

```php
<?php
// routes/api.php (ในกลุ่ม auth:sanctum)
use App\Http\Controllers\Api\V1\IncidentController;

Route::post('/incidents', [IncidentController::class, 'store']);
```

```php
<?php
// app/Http/Controllers/Api/V1/IncidentController.php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\IncidentResource;
use App\Models\Incident;
use App\Models\User;
use App\Notifications\IncidentReported;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;

class IncidentController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        // Validate ครบทุก field รวมถึงไฟล์ภาพและพิกัด
        $validated = $request->validate([
            'plant_id'    => ['required', 'integer', 'exists:plants,id'],
            'title'       => ['required', 'string', 'max:150'],
            'description' => ['required', 'string', 'max:2000'],
            'severity'    => ['required', 'in:low,medium,high,critical'],
            'latitude'    => ['required', 'numeric', 'between:-90,90'],
            'longitude'   => ['required', 'numeric', 'between:-180,180'],
            'photo'       => ['required', 'image', 'mimes:jpeg,png', 'max:5120'], // สูงสุด 5 MB
        ]);

        // เก็บภาพลง storage/app/public/incidents (อย่าลืม php artisan storage:link)
        $photoPath = $request->file('photo')->store('incidents', 'public');

        $incident = Incident::create([
            ...$validated,
            'photo_path'  => $photoPath,
            'status'      => 'open',
            'reported_by' => $request->user()->id,
        ]);

        // แจ้งเตือนหัวหน้ากะทุกคน - ใน PoC ใช้ database channel
        // ระบบจริงเพิ่ม FCM channel (laravel-notification-channels/fcm) เพื่อ Push เข้ามือถือ
        $supervisors = User::where('role', 'supervisor')->get();
        Notification::send($supervisors, new IncidentReported($incident));

        return response()->json(
            ['data' => new IncidentResource($incident)],
            201, // Created
        );
    }
}
```

```php
<?php
// app/Notifications/IncidentReported.php
namespace App\Notifications;

use App\Models\Incident;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class IncidentReported extends Notification
{
    use Queueable;

    public function __construct(public Incident $incident)
    {
    }

    public function via(object $notifiable): array
    {
        return ['database']; // PoC: เก็บลงตาราง notifications / Production: เพิ่ม 'fcm'
    }

    public function toArray(object $notifiable): array
    {
        return [
            'incident_id' => $this->incident->id,
            'title'       => "แจ้งเหตุขัดข้อง: {$this->incident->title}",
            'severity'    => $this->incident->severity,
            'plant_id'    => $this->incident->plant_id,
        ];
    }
}
```

### ขั้นที่ 2 - ฝั่ง Flutter: Repository ส่ง multipart/form-data ด้วย Dio

```dart
// lib/features/incidents/data/incident_repository.dart
import 'package:dio/dio.dart';
import 'models/incident.dart';

class IncidentRepository {
  IncidentRepository({required this.dio});
  final Dio dio;

  /// ส่งเหตุขัดข้องพร้อมไฟล์ภาพเป็น multipart/form-data
  Future<Incident> submitIncident({
    required int plantId,
    required String title,
    required String description,
    required String severity,       // low | medium | high | critical
    required double latitude,
    required double longitude,
    required String photoPath,      // path ไฟล์จาก image_picker
  }) async {
    final formData = FormData.fromMap({
      'plant_id': plantId,
      'title': title,
      'description': description,
      'severity': severity,
      'latitude': latitude,
      'longitude': longitude,
      // MultipartFile ทำให้ Dio ตั้ง Content-Type เป็น multipart/form-data ให้เอง
      'photo': await MultipartFile.fromFile(photoPath, filename: 'incident.jpg'),
    });

    final response = await dio.post('/incidents', data: formData);
    return Incident.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
```

### ขั้นที่ 3 - เก็บภาพและพิกัด: image_picker + geolocator

```dart
// lib/features/incidents/logic/incident_form_providers.dart
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'incident_form_providers.g.dart';

/// เก็บ path ภาพที่ถ่าย/เลือกไว้ (null = ยังไม่มีภาพ)
@riverpod
class IncidentPhoto extends _$IncidentPhoto {
  @override
  String? build() => null;

  /// เปิดกล้องถ่ายภาพเครื่องจักร (ลดขนาดไม่เกิน 1600px เพื่อประหยัด Bandwidth)
  Future<void> takePhoto() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked != null) state = picked.path;
  }

  void clear() => state = null;
}

/// ขอพิกัด GPS ปัจจุบัน - FutureProvider เพราะดึงครั้งเดียวต่อการเปิดฟอร์ม
@riverpod
Future<Position> currentPosition(Ref ref) async {
  // 1) ตรวจว่าเปิด Location Service หรือยัง
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw Exception('กรุณาเปิด Location Service ก่อนแจ้งเหตุ');
  }
  // 2) ขอ Permission ตามขั้นตอน
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception('แอปไม่ได้รับสิทธิ์เข้าถึงตำแหน่ง');
  }
  // 3) อ่านพิกัดจริง
  return Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );
}
```

> 📌 **อย่าลืม Permission ฝั่ง Android:** เพิ่มใน `android/app/src/main/AndroidManifest.xml` ทั้ง `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />` และ `android.permission.CAMERA` มิฉะนั้น `geolocator`/`image_picker` จะ throw ทันทีบนเครื่องจริง

### ขั้นที่ 4 - Mutations API: หัวใจของ Feature นี้

Riverpod 3.0 มี `Mutation<T>` สำหรับงาน Side-effect โดยเฉพาะ จุดต่างจาก AsyncNotifier คือ Mutation **แยกสถานะของ "การกระทำ" ออกจากสถานะของ "ข้อมูล"** และเริ่มต้นที่ `idle` (ไม่ใช่ `loading`):

```dart
// lib/features/incidents/logic/incident_mutations.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/incident_repository.dart';
import '../data/models/incident.dart';

/// ประกาศ Mutation เป็น global final ตามแนวทาง Riverpod 3.0
final submitIncidentMutation = Mutation<Incident>();
```

```dart
// lib/features/incidents/presentation/incident_form_page.dart (ส่วนสำคัญ)
class IncidentFormPage extends ConsumerWidget {
  const IncidentFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoPath = ref.watch(incidentPhotoProvider);
    final position = ref.watch(currentPositionProvider);
    final submitState = ref.watch(submitIncidentMutation); // MutationState<Incident>

    // ref.listen ทำ side-effect เมื่อส่งสำเร็จ/ล้มเหลว (แนวทางเดียวกับ Day 3)
    ref.listen(submitIncidentMutation, (previous, next) {
      switch (next) {
        case MutationSuccess():
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ ส่งเหตุขัดข้องเรียบร้อย หัวหน้ากะได้รับแจ้งแล้ว')),
          );
          context.pop(); // กลับหน้าเดิม
        case MutationError(:final error):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ ส่งไม่สำเร็จ: $error')),
          );
        default:
          break; // idle / pending ไม่ต้องทำอะไร
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('แจ้งเหตุขัดข้องเครื่องจักร')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ... TextFormField (title, description), Dropdown severity,
          //     ปุ่มถ่ายภาพ (เรียก incidentPhotoProvider.notifier.takePhoto()),
          //     แถบแสดงพิกัดจาก position.when(...)
          const SizedBox(height: 24),

          // ปุ่ม Submit เปลี่ยนหน้าตาตามสถานะ Mutation ทั้ง 4 แบบ
          switch (submitState) {
            // pending → ปุ่มหมุน กดซ้ำไม่ได้ (กันส่งเบิ้ล)
            MutationPending() => const FilledButton(
                onPressed: null,
                child: SizedBox(
                  height: 20, width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            // success → ปุ่มเขียวยืนยันผล
            MutationSuccess() => FilledButton.icon(
                onPressed: null,
                icon: const Icon(Icons.check_circle),
                label: const Text('ส่งเรียบร้อย'),
              ),
            // error → ปุ่มแดง กดส่งซ้ำได้
            MutationError() => FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                icon: const Icon(Icons.refresh),
                label: const Text('ลองส่งอีกครั้ง'),
                onPressed: () => _submit(ref, photoPath, position),
              ),
            // idle (ค่าเริ่มต้น) → ปุ่มปกติ
            _ => FilledButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('ส่งเหตุขัดข้อง'),
                onPressed: (photoPath == null || !position.hasValue)
                    ? null // บังคับให้มีภาพ + พิกัดก่อนจึงกดได้
                    : () => _submit(ref, photoPath, position),
              ),
          },
        ],
      ),
    );
  }

  /// สั่งรัน Mutation - โค้ดใน callback คือ "การกระทำ" ที่ถูกติดตามสถานะให้อัตโนมัติ
  void _submit(WidgetRef ref, String? photoPath, AsyncValue<Position> position) {
    submitIncidentMutation.run(ref, (tsx) async {
      final repository = tsx.get(incidentRepositoryProvider);
      return repository.submitIncident(
        plantId: 1, // จาก Dropdown จริงในฟอร์ม
        title: 'Turbine #2 สั่นผิดปกติ',            // จาก TextFormField จริง
        description: 'พบการสั่นและเสียงดังช่วงเดินเครื่องเต็มกำลัง',
        severity: 'high',                            // จาก Dropdown จริง
        latitude: position.requireValue.latitude,
        longitude: position.requireValue.longitude,
        photoPath: photoPath!,
      );
    });
  }
}
```

> ✅ **ทำไม Mutations API เหมาะกับงานนี้กว่า AsyncNotifier:** (1) สถานะเริ่มต้นคือ `idle` ไม่ใช่ `loading` - ฟอร์มเปิดมาไม่ควรหมุน (2) ไม่ปนกับ State ของ "ข้อมูล" - รายการ incident เดิมไม่กระพริบระหว่างส่ง (3) เมื่อออกจากหน้าจอ Mutation จะกลับเป็น `idle` เอง ไม่ทิ้งสถานะ error ค้างไว้ให้หน้าอื่น (4) กันการกดซ้ำ (double submit) ได้ในตัวเพราะ `pending` ทำให้ปุ่ม disabled

> ⚠️ **หมายเหตุเวอร์ชัน:** Mutations API ใน Riverpod 3.0 ยังมีสถานะ experimental ทีมพัฒนาอาจปรับ API เล็กน้อยในรุ่นถัดไป สำหรับโปรเจคจริงของ EDL-Gen ให้ตรึงเวอร์ชัน `flutter_riverpod` ใน pubspec แบบระบุชัด และอ่าน Changelog ก่อนอัพเกรดทุกครั้ง

> **ผลลัพธ์ที่คาดหวัง Feature 4:** ถ่ายภาพ + พิกัดขึ้นครบแล้วปุ่มส่งจึงกดได้, ระหว่างส่งปุ่มหมุนและกดซ้ำไม่ได้, ส่งสำเร็จเห็น SnackBar เขียวและ record ใหม่ในตาราง `incidents` พร้อมไฟล์ภาพใน `storage/app/public/incidents`, ตาราง `notifications` มีแถวแจ้งเตือนถึง supervisor ทุกคน, ทดสอบ error โดยปิด `php artisan serve` แล้วส่ง - ปุ่มเปลี่ยนเป็นสีแดง "ลองส่งอีกครั้ง"

---

## 🛠️ Feature 5 - บันทึกค่ามิเตอร์ (Cubit + MariaDB via Laravel API)

### เวลา 14:15-14:45 น.

> 💡 **หัวใจของ Feature นี้:** งานประจำของพนักงานโรงผลิตคือจดค่ามิเตอร์รายชั่วโมง Feature นี้เน้น 2 เรื่อง: **Form Validation ที่รัดกุม** (ค่ามิเตอร์ต้องสมเหตุสมผล) และ **Optimistic UI Update** - เพิ่มรายการเข้า List ทันทีที่กดบันทึกโดยไม่รอ Server ตอบ ถ้า Server ปฏิเสธค่อย Rollback ทำให้แอป "รู้สึกเร็ว" แม้ Network ช้า

### ขั้นที่ 1 - ฝั่ง Laravel: Endpoint บันทึกค่ามิเตอร์ลง MariaDB

```php
<?php
// app/Http/Controllers/Api/V1/MeterReadingController.php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\MeterReadingResource;
use App\Models\MeterReading;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MeterReadingController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'plant_id'     => ['required', 'integer', 'exists:plants,id'],
            'meter_code'   => ['required', 'string', 'regex:/^MTR-[0-9]{4}$/'], // เช่น MTR-0042
            'reading_kwh'  => ['required', 'numeric', 'min:0', 'max:99999999'],
            'recorded_for' => ['required', 'date_format:Y-m-d H:00:00'], // บังคับชั่วโมงเต็ม
        ]);

        // กันบันทึกซ้ำ: มิเตอร์เดียวกัน + ชั่วโมงเดียวกัน มีได้ record เดียว
        $duplicated = MeterReading::where('meter_code', $validated['meter_code'])
            ->where('recorded_for', $validated['recorded_for'])
            ->exists();

        if ($duplicated) {
            return response()->json([
                'message' => 'มีการบันทึกค่ามิเตอร์นี้ในชั่วโมงดังกล่าวแล้ว',
            ], 409); // Conflict
        }

        // ใช้ Transaction ตามแนวทาง Day 1 - ถ้ามีขั้นตอนเสริม (เช่น Audit Log) จะ Commit พร้อมกัน
        $reading = DB::transaction(function () use ($validated, $request) {
            return MeterReading::create([
                ...$validated,
                'recorded_by' => $request->user()->id,
            ]);
        });

        return response()->json(['data' => new MeterReadingResource($reading)], 201);
    }
}
```

### ขั้นที่ 2 - ฝั่ง Flutter: State และ Cubit พร้อม Optimistic Update

```dart
// lib/features/meters/logic/meter_entry_state.dart
import 'package:equatable/equatable.dart';
import '../data/models/meter_reading.dart';

enum MeterEntryStatus { initial, submitting, success, failure }

class MeterEntryState extends Equatable {
  const MeterEntryState({
    this.status = MeterEntryStatus.initial,
    this.todayReadings = const [],
    this.errorMessage,
  });

  final MeterEntryStatus status;
  final List<MeterReading> todayReadings; // รายการที่บันทึกแล้ววันนี้ (แสดงใต้ฟอร์ม)
  final String? errorMessage;

  MeterEntryState copyWith({
    MeterEntryStatus? status,
    List<MeterReading>? todayReadings,
    String? errorMessage,
  }) {
    return MeterEntryState(
      status: status ?? this.status,
      todayReadings: todayReadings ?? this.todayReadings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, todayReadings, errorMessage];
}
```

```dart
// lib/features/meters/logic/meter_entry_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/meter_repository.dart';
import '../data/models/meter_reading.dart';
import 'meter_entry_state.dart';

class MeterEntryCubit extends Cubit<MeterEntryState> {
  MeterEntryCubit({required MeterRepository repository})
      : _repository = repository,
        super(const MeterEntryState());

  final MeterRepository _repository;

  Future<void> loadToday() async {
    final readings = await _repository.getTodayReadings();
    emit(state.copyWith(todayReadings: readings));
  }

  /// บันทึกค่ามิเตอร์แบบ Optimistic Update
  Future<void> submitReading({
    required int plantId,
    required String meterCode,
    required double readingKwh,
    required DateTime recordedFor,
  }) async {
    // 1) สร้างรายการชั่วคราว (id ติดลบ = ยังไม่ได้รับการยืนยันจาก Server)
    final optimistic = MeterReading(
      id: -DateTime.now().millisecondsSinceEpoch,
      plantId: plantId,
      meterCode: meterCode,
      readingKwh: readingKwh,
      recordedFor: recordedFor,
      isPending: true, // UI ใช้แสดงไอคอนนาฬิกา "รอยืนยัน"
    );

    // 2) เก็บ List เดิมไว้ก่อน เผื่อต้อง Rollback
    final previousList = state.todayReadings;

    // 3) Optimistic: ใส่เข้า List ทันที ผู้ใช้เห็นผลโดยไม่ต้องรอ Network
    emit(state.copyWith(
      status: MeterEntryStatus.submitting,
      todayReadings: [optimistic, ...previousList],
    ));

    try {
      // 4) ยิง API จริง
      final confirmed = await _repository.createReading(
        plantId: plantId,
        meterCode: meterCode,
        readingKwh: readingKwh,
        recordedFor: recordedFor,
      );

      // 5) สำเร็จ: แทนที่รายการชั่วคราวด้วยของจริงจาก Server
      emit(state.copyWith(
        status: MeterEntryStatus.success,
        todayReadings: [
          confirmed,
          ...previousList, // List เดิมโดยไม่มีตัวชั่วคราว
        ],
      ));
    } catch (e) {
      // 6) ล้มเหลว: Rollback กลับเป็น List เดิม + แจ้ง error
      emit(state.copyWith(
        status: MeterEntryStatus.failure,
        todayReadings: previousList,
        errorMessage: e.toString().contains('409')
            ? 'ชั่วโมงนี้บันทึกค่ามิเตอร์นี้ไปแล้ว'
            : 'บันทึกไม่สำเร็จ กรุณาลองใหม่',
      ));
    }
  }
}
```

### ขั้นที่ 3 - Form พร้อม Validation ฝั่ง Client

```dart
// lib/features/meters/presentation/meter_form_page.dart (ส่วนสำคัญ)
class MeterFormPage extends StatefulWidget { /* ... */ }

class _MeterFormPageState extends State<MeterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _meterCodeController = TextEditingController();
  final _readingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeterEntryCubit, MeterEntryState>(
      // listener = side-effect: SnackBar แจ้งผล (แนวทางเดียวกับ ref.listen)
      listener: (context, state) {
        if (state.status == MeterEntryStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'เกิดข้อผิดพลาด')),
          );
        }
        if (state.status == MeterEntryStatus.success) {
          _readingController.clear(); // เคลียร์ช่องค่า เตรียมจดชั่วโมงถัดไป
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _meterCodeController,
                decoration: const InputDecoration(labelText: 'รหัสมิเตอร์ (MTR-XXXX)'),
                // Validation ฝั่ง Client ต้องตรงกับกฎฝั่ง Laravel เสมอ
                validator: (v) {
                  if (v == null || v.isEmpty) return 'กรุณากรอกรหัสมิเตอร์';
                  if (!RegExp(r'^MTR-\d{4}$').hasMatch(v)) {
                    return 'รูปแบบต้องเป็น MTR-0000';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _readingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ค่าที่อ่านได้ (kWh)'),
                validator: (v) {
                  final value = double.tryParse(v ?? '');
                  if (value == null) return 'กรุณากรอกตัวเลข';
                  if (value < 0 || value > 99999999) return 'ค่าอยู่นอกช่วงที่ยอมรับ';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton(
                // disabled ระหว่างส่ง กันการกดรัว
                onPressed: state.status == MeterEntryStatus.submitting
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<MeterEntryCubit>().submitReading(
                                plantId: 1,
                                meterCode: _meterCodeController.text,
                                readingKwh: double.parse(_readingController.text),
                                recordedFor: _currentHour(), // ปัดเป็นชั่วโมงเต็ม
                              );
                        }
                      },
                child: const Text('บันทึกค่ามิเตอร์'),
              ),
              const Divider(height: 32),
              // รายการที่บันทึกวันนี้ - ตัว Optimistic จะมีไอคอนนาฬิกา
              Expanded(
                child: ListView.builder(
                  itemCount: state.todayReadings.length,
                  itemBuilder: (_, i) {
                    final r = state.todayReadings[i];
                    return ListTile(
                      leading: r.isPending
                          ? const Icon(Icons.schedule, color: Colors.orange) // รอยืนยัน
                          : const Icon(Icons.check_circle, color: Colors.green),
                      title: Text('${r.meterCode} - ${r.readingKwh} kWh'),
                      subtitle: Text('ชั่วโมง ${r.recordedFor.hour}:00'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DateTime _currentHour() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour); // นาที/วินาที = 0
  }
}
```

> ⚠️ **กฎเหล็กของ Optimistic Update:** ต้องมีแผน Rollback เสมอ และห้ามใช้กับงานที่ "ย้อนกลับไม่ได้ในสายตาผู้ใช้" เช่น การโอนเงินหรือการสั่งหยุดเครื่องจักร - งานเหล่านั้นให้รอ Server ยืนยันก่อนเท่านั้น การจดมิเตอร์เหมาะกับ Optimistic เพราะผลของความล้มเหลวคือแค่ "รายการหายไปจาก List พร้อมข้อความแจ้ง" ไม่มีความเสียหายจริง

> 📌 **สังเกตการแบ่งงานระหว่าง Client/Server Validation:** Client validate เพื่อ UX (feedback ทันที ไม่เปลือง Network) ส่วน Server validate เพื่อความถูกต้องของข้อมูล (บังคับเสมอ เชื่อ Client ไม่ได้) กฎ 409 กันบันทึกซ้ำอยู่ฝั่ง Server เท่านั้นเพราะต้องเช็คกับฐานข้อมูลจริง

> **ผลลัพธ์ที่คาดหวัง Feature 5:** กรอกฟอร์มผิดรูปแบบแล้วเห็นข้อความเตือนใต้ช่องทันที, กดบันทึกแล้วรายการเด้งขึ้นบน List ทันทีพร้อมไอคอนนาฬิกา แล้วเปลี่ยนเป็นติ๊กเขียวเมื่อ Server ตอบ 201, บันทึกมิเตอร์เดิมชั่วโมงเดิมซ้ำจะได้ 409 และรายการชั่วคราวหายไปพร้อม SnackBar อธิบายเหตุผล, เปิด TablePlus ดูตาราง `meter_readings` ใน MariaDB ต้องมีข้อมูลตรงกับหน้าจอ

---

## 🔍 Code Review & Best Practices

### เวลา 14:45-15:30 น.

> 💡 **หัวใจของช่วงนี้:** ก่อนนำเสนอ เราหยุดมองย้อนโค้ดทั้ง 5 วันด้วยสายตาของ Reviewer - อะไรคือ Anti-pattern ที่เผลอเขียนไปบ้าง จะเขียนเทสยืนยันพฤติกรรมอย่างไร และจะให้เครื่องช่วยตรวจอัตโนมัติทุกครั้งที่ Push โค้ดได้อย่างไร

### 1. Anti-patterns ที่พบบ่อยและวิธีแก้

รวบรวมจากโค้ดจริงที่วิทยากรเห็นระหว่างเดิน Workshop ตลอด 4 วันที่ผ่านมา:

| # | Anti-pattern ที่พบ                                             | ปัญหาที่เกิด                                        | วิธีแก้ที่ถูกต้อง                                                  |
| - | --------------------------------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------ |
| 1 | ใช้ `ref.watch()` ใน `onPressed`/callback                       | Subscribe ซ้ำซ้อน พฤติกรรม rebuild ผิดเพี้ยน         | ใน callback ใช้ `ref.read()` เสมอ (`watch` เฉพาะใน `build`)        |
| 2 | เรียก Dio ตรง ๆ จาก Widget                                      | ทดสอบไม่ได้ แก้ URL ทีเดียวกระทบหลายหน้า             | ผ่าน Repository เสมอ แล้ว inject ผ่าน Provider                     |
| 3 | เก็บ Token ใน `SharedPreferences`                               | อ่านได้เป็น plain text บนเครื่อง root                | ใช้ `flutter_secure_storage` (Keystore/Keychain)                   |
| 4 | Logic ธุรกิจอยู่ใน `build()` ของ Widget                          | Rebuild ทุกครั้ง = คำนวณซ้ำ, Unit Test ต้องสร้าง UI  | ย้ายเข้า Cubit/Notifier แล้วให้ Widget แสดงผลอย่างเดียว            |
| 5 | `emit()` หลัง `await` โดยไม่เช็ค `isClosed` (Cubit)             | Exception เมื่อผู้ใช้ออกจากหน้าก่อน API ตอบ          | เช็ค `if (isClosed) return;` ก่อน `emit` หลังงาน async             |
| 6 | Query ใน Loop ฝั่ง Laravel (N+1 Problem)                        | รายงาน 60 แถวยิง SQL 61 ครั้ง ช้าและหนัก DB          | ใช้ Eager Loading `->with('plant')` ตามที่ทำใน Feature 3           |
| 7 | คืน Eloquent Model ดิบ ๆ จาก Controller                         | Field หลุด (เช่น password hash), Response เปลี่ยนตาม Schema | ครอบด้วย API Resource ทุก Endpoint                            |
| 8 | Validation อยู่ฝั่ง Flutter อย่างเดียว                          | ยิงตรงด้วย Postman ก็ใส่ข้อมูลขยะเข้า DB ได้         | Server ต้อง validate เสมอ Client เป็นเพียง UX เสริม                |
| 9 | Hardcode URL/API Key กระจายทั่วโค้ด                             | สลับ Dev/Prod ต้องไล่แก้หลายไฟล์ เสี่ยง Key รั่วใน Git | รวมไว้ที่ AppConfig + `--dart-define` / `.env` (ฝั่ง Laravel)     |
| 10 | ใช้ Mutation/AsyncNotifier ปนกันมั่ว ไม่มีเกณฑ์                | ทีมสับสน โค้ดแต่ละหน้าคนละสไตล์                      | เกณฑ์ชัด: อ่านข้อมูล = AsyncNotifier, กระทำ/ส่งข้อมูล = Mutation, Flow ธุรกิจหลายขั้น = Cubit |

### 2. Unit Test Cubit ด้วย bloc_test

ติดตั้ง dev dependency ก่อน: `flutter pub add dev:bloc_test dev:mocktail`

```dart
// test/features/auth/auth_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockTokenStorage extends Mock implements TokenStorage {}

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
        // Mock: Repository ตอบสำเร็จ
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
        AuthState(status: AuthStatus.authenticated, user: fakeLoginResult.user),
      ],
      verify: (_) {
        // ยืนยันว่า Token ถูกบันทึกจริง 1 ครั้ง
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
}
```

> ✅ **จุดแข็งของ `blocTest`:** ประกาศเป็น 3 ช่วงชัดเจน - `build` (เตรียม Cubit + Mock), `act` (การกระทำ), `expect` (ลำดับ State ที่ต้อง emit) อ่านแล้วเหมือน Spec ของ Business Logic โดยไม่ต้องสร้าง Widget แม้แต่ตัวเดียว

### 3. Unit Test Riverpod Provider ด้วย ProviderContainer + Override

```dart
// test/features/reports/daily_reports_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportRepository extends Mock implements ReportRepository {}

void main() {
  late MockReportRepository repository;

  setUp(() {
    repository = MockReportRepository();
  });

  /// Helper สร้าง Container พร้อม override Repository เป็นตัว Mock
  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        // สลับ Repository จริงเป็น Mock - ไม่แตะ Network/SQLite เลย
        reportRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose); // เก็บกวาดทุกครั้งหลังจบเทส
    return container;
  }

  test('โหลดรายงานสำเร็จ ต้องได้ AsyncData และ fromCache = false', () async {
    when(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: any(named: 'plantId'),
        )).thenAnswer((_) async =>
        ReportResult(reports: fakeReports, fromCache: false));

    final container = makeContainer();

    // อ่านค่าจาก provider โดยตรง (ไม่มี Widget เกี่ยวข้อง)
    final result = await container.read(dailyReportsProvider.future);

    expect(result.reports, hasLength(fakeReports.length));
    expect(result.fromCache, isFalse);
  });

  test('เมื่อเปลี่ยน Filter provider ต้องดึงข้อมูลใหม่ด้วยเงื่อนไขใหม่', () async {
    when(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: any(named: 'plantId'),
        )).thenAnswer((_) async =>
        ReportResult(reports: fakeReports, fromCache: false));

    final container = makeContainer();
    await container.read(dailyReportsProvider.future); // โหลดรอบแรก

    // เปลี่ยน Filter → dailyReportsProvider ต้อง rebuild
    container.read(reportFilterStateProvider.notifier).setPlant(2);
    await container.read(dailyReportsProvider.future);

    // ยืนยันว่ารอบสองถูกเรียกด้วย plantId = 2
    verify(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: 2,
        )).called(1);
  });
}
```

### 4. ฝั่ง Laravel: Feature Test ตัวอย่าง

```php
<?php
// tests/Feature/MeterReadingTest.php
namespace Tests\Feature;

use App\Models\Plant;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class MeterReadingTest extends TestCase
{
    use RefreshDatabase;

    public function test_บันทึกค่ามิเตอร์สำเร็จได้_201(): void
    {
        $user = User::factory()->create();
        $plant = Plant::factory()->create();
        Sanctum::actingAs($user); // จำลองว่า Login แล้ว

        $response = $this->postJson('/api/v1/meter-readings', [
            'plant_id'     => $plant->id,
            'meter_code'   => 'MTR-0042',
            'reading_kwh'  => 15230.5,
            'recorded_for' => now()->startOfHour()->format('Y-m-d H:00:00'),
        ]);

        $response->assertCreated();
        $this->assertDatabaseHas('meter_readings', ['meter_code' => 'MTR-0042']);
    }

    public function test_บันทึกซ้ำชั่วโมงเดิม_ต้องได้_409(): void
    {
        $user = User::factory()->create();
        $plant = Plant::factory()->create();
        Sanctum::actingAs($user);

        $payload = [
            'plant_id'     => $plant->id,
            'meter_code'   => 'MTR-0042',
            'reading_kwh'  => 15230.5,
            'recorded_for' => now()->startOfHour()->format('Y-m-d H:00:00'),
        ];

        $this->postJson('/api/v1/meter-readings', $payload)->assertCreated();
        $this->postJson('/api/v1/meter-readings', $payload)->assertStatus(409);
    }
}
```

### 5. CI/CD เบื้องต้นด้วย GitHub Actions

Workflow เดียวตรวจทั้งสองฝั่ง: รัน Test ของ Laravel บน MariaDB จริง และ Analyze + Test + Build APK ของ Flutter ทุกครั้งที่ Push เข้า `main` หรือเปิด Pull Request:

```yaml
# .github/workflows/ci.yml
name: EDL-Gen Monitoring CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  laravel-tests:
    name: Laravel API Tests (PHP 8.3 + MariaDB)
    runs-on: ubuntu-latest

    # MariaDB ชั่วคราวสำหรับรันเทส - เหมือน docker compose ที่ใช้ใน Workshop
    services:
      mariadb:
        image: mariadb:11
        env:
          MARIADB_DATABASE: edlgen_test
          MARIADB_ROOT_PASSWORD: secret
        ports:
          - 3306:3306
        options: >-
          --health-cmd="healthcheck.sh --connect --innodb_initialized"
          --health-interval=10s --health-timeout=5s --health-retries=5

    defaults:
      run:
        working-directory: edlgen-api

    steps:
      - uses: actions/checkout@v4

      - name: Setup PHP 8.3
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.3'
          extensions: mbstring, pdo_mysql, bcmath
          coverage: none

      - name: Install Composer dependencies
        run: composer install --prefer-dist --no-interaction --no-progress

      - name: Prepare environment
        run: |
          cp .env.example .env
          php artisan key:generate

      - name: Run migrations and tests
        env:
          DB_CONNECTION: mysql
          DB_HOST: 127.0.0.1
          DB_PORT: 3306
          DB_DATABASE: edlgen_test
          DB_USERNAME: root
          DB_PASSWORD: secret
        run: |
          php artisan migrate --force
          php artisan test

  flutter-build:
    name: Flutter Analyze + Test + Build APK
    runs-on: ubuntu-latest
    needs: laravel-tests   # Build แอปต่อเมื่อ API เทสผ่านก่อน

    defaults:
      run:
        working-directory: edlgen_monitoring_app

    steps:
      - uses: actions/checkout@v4

      - name: Setup Java 17 (สำหรับ Android Build)
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - name: Setup Flutter (stable)
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Install dependencies + Code Generation
        run: |
          flutter pub get
          dart run build_runner build --delete-conflicting-outputs

      - name: Analyze (Lint ต้องผ่านทั้งหมด)
        run: flutter analyze

      - name: Run unit tests
        run: flutter test

      - name: Build release APK
        run: flutter build apk --release

      # เก็บ APK ไว้ให้ดาวน์โหลดจากหน้า Actions - ใช้แจกทีม QA ทดสอบ
      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: edlgen-monitoring-apk
          path: edlgen_monitoring_app/build/app/outputs/flutter-apk/app-release.apk
```

> 📌 **แนวคิดที่อยากให้จำ:** CI ไม่ใช่เรื่องของบริษัทใหญ่เท่านั้น - แค่ workflow ไฟล์เดียวนี้ ทุก Pull Request ของทีม EDL-Gen จะถูกตรวจ Lint, รันเทสทั้งสองฝั่ง และ Build APK ให้อัตโนมัติ ปัญหา "โค้ดพังแต่ไม่มีใครรู้จนวันเดโม" จะหายไปทันที

---

## 🎤 Final PoC Presentation

### เวลา 15:30-16:15 น.

แต่ละทีม (3-4 คน) มีเวลานำเสนอ **7 นาที + ถามตอบ 3 นาที** โดยเดโมจากแอปจริงบน Emulator หรือเครื่องจริงที่ต่อจอ

**หัวข้อที่ต้องนำเสนอ (บังคับครบทุกข้อ):**

1. **เดโมแอปสด 5 Feature** - ไล่ตั้งแต่ Login → Dashboard Real-time → รายงาน Offline (เปิด Airplane Mode ให้ดูจริง) → แจ้งเหตุขัดข้อง → บันทึกมิเตอร์
2. **สถาปัตยกรรมที่เลือกใช้** - ชี้บนแผนภาพว่า Feature ไหนใช้ Riverpod / Cubit เพราะอะไร (อธิบายเกณฑ์การเลือก ไม่ใช่แค่บอกว่าใช้อะไร)
3. **ปัญหาที่เจอและวิธีแก้** - เลือกปัญหาจริง 1-2 เรื่องที่ทีมติดระหว่าง Workshop และเล่าวิธี Debug จนหลุด
4. **สิ่งที่จะทำต่อ** - ถ้าได้พัฒนาต่อในงานจริงของ EDL-Gen จะเพิ่ม/แก้อะไรเป็น 3 อันดับแรก

**เกณฑ์การให้ Feedback จากวิทยากรและเพื่อนร่วมอบรม:**

| เกณฑ์                          | น้ำหนัก | สิ่งที่ดู                                                              |
| ------------------------------ | ------- | ---------------------------------------------------------------------- |
| ความสมบูรณ์ของ Feature         | 30%     | 5 Feature ทำงานได้จริงแค่ไหน Edge Case (Offline, Token หมดอายุ) รอดไหม |
| คุณภาพโค้ดและสถาปัตยกรรม       | 25%     | แยก Layer ชัด, ใช้ State Management ถูกประเภท, ไม่มี Anti-pattern เด่น |
| ความเข้าใจ (ตอบคำถาม)          | 20%     | อธิบาย "ทำไม" ได้ ไม่ใช่แค่ "ทำตาม"                                    |
| UX และความใส่ใจรายละเอียด      | 15%     | Loading/Error State ครบ, ข้อความภาษาคน, ปุ่มกันกดซ้ำ                   |
| การนำเสนอ                      | 10%     | ตรงเวลา เดโมลื่น เล่าเรื่องเข้าใจง่าย                                  |

> ✅ **เคล็ดลับการเดโม:** เตรียม "Demo Script" ไล่ลำดับหน้าจอไว้ล่วงหน้า, รีสตาร์ท `edlgen:simulate-readings` ก่อนขึ้นนำเสนอเพื่อให้กราฟวิ่งสวย, และเตรียมวิดีโอสำรองสั้น ๆ กันเหตุ Emulator ค้างกลางคัน

---

## 📝 สรุปหลักสูตรทั้ง 5 วัน

### เวลา 16:15-16:30 น. (Post-test + ปิดหลักสูตร)

ก่อนจากกัน ให้ผู้เรียนทำ **Post-test** ตามลิงก์ที่วิทยากรแจ้ง เพื่อเทียบพัฒนาการกับ Pre-test ของวันแรก จากนั้นร่วมพิธีมอบ **Certificate of Completion** จาก IT Genius Engineering

**เส้นทางที่เราเดินมาด้วยกันทั้ง 5 วัน:**

| วัน   | หัวข้อหลัก                                        | สิ่งที่สร้างเสร็จ                                              |
| ----- | ------------------------------------------------- | -------------------------------------------------------------- |
| Day 1 | Laravel 13 API Layer + Riverpod Async State       | Laravel API + Sanctum Auth + Repository Pattern, Widget แสดง AsyncValue ครบ 3 สถานะ |
| Day 2 | Flutter Foundation + Widget System                | App Skeleton, Custom Widget (StatCard, StatusBadge), GoRouter Navigation |
| Day 3 | Riverpod 3.0 พื้นฐาน - Provider Types & Consumer  | เชื่อมแอปกับ API จริง, FutureProvider/AsyncNotifier, Loading Skeleton + Error Banner |
| Day 4 | Advanced Riverpod + Cubit                         | Real-time StreamProvider + WebSocket, AuthCubit, Offline Cache, BlocObserver Audit Trail |
| Day 5 | Workshop ครบวงจร EDL-Gen Monitoring App           | แอปสมบูรณ์ 5 Feature + Unit Test + CI/CD + Final PoC Presentation |

**สิ่งที่ผู้เรียนได้รับกลับไป:**

- **Prototype แอป EDL-Gen Monitoring** ที่ทำงานได้จริงบน Android ครบ 5 Feature พร้อมต่อยอด
- **Laravel 13 API Codebase** ที่มี Repository Pattern, Sanctum Auth, Event Broadcast และ Feature Test
- **ชุด Unit Test ตัวอย่าง** ทั้ง `bloc_test` (Cubit) และ `ProviderContainer` (Riverpod) พร้อม GitHub Actions Workflow ที่ใช้ได้ทันที
- **เอกสารประกอบการอบรมทั้ง 5 วัน** (Note ฉบับนี้ + Slide + Starter Kit + Source Code ทุก Branch)
- **Certificate of Completion** จากสถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
- **Community Access** กลุ่ม LINE/Slack สำหรับถามตอบหลังจบหลักสูตร

---

## 🚀 Next Steps สำหรับ EDL-Gen

แนวทางการนำ PoC นี้ไปพัฒนาต่อเป็นระบบจริง เรียงตามลำดับที่แนะนำ:

**ระยะสั้น (1-2 เดือนแรก)**

1. **Security Hardening ฝั่ง API:** บังคับ HTTPS ทุกเส้น (TLS Certificate จริง), เพิ่ม Rate Limiting (`throttle` middleware), ตั้ง Token อายุสั้นลงพร้อม Refresh Rotation, เปิด Audit Log การเข้าถึงข้อมูลการผลิตทุกครั้ง และตรวจ OWASP API Security Top 10 ก่อนขึ้น Production
2. **เชื่อมข้อมูลจริงแทน Simulator:** แทนที่ `edlgen:simulate-readings` ด้วย Integration กับระบบ SCADA/Historian ของโรงผลิตจริง (ผ่าน Scheduled Job หรือ Message Queue) โดยโครงสร้าง Event Broadcast เดิมใช้ต่อได้ทันที
3. **Push Notification จริงด้วย FCM:** เพิ่ม FCM Channel ใน `IncidentReported` Notification และจัดการ Device Token ฝั่ง Flutter ด้วย `firebase_messaging` เพื่อให้หัวหน้ากะได้รับแจ้งเหตุแม้ไม่ได้เปิดแอป

**ระยะกลาง (3-6 เดือน)**

4. **Deployment ฝั่ง Server:** ย้าย Laravel + Reverb + MariaDB ขึ้น Server จริงด้วย Docker Compose (หรือ Kubernetes เมื่อ Scale), แยก Environment Dev/Staging/Production, ตั้ง Backup ฐานข้อมูลอัตโนมัติ และ Monitoring ด้วย Laravel Pulse/Telescope
5. **เผยแพร่แอปเข้า Store:** เตรียม App Signing, Privacy Policy, Screenshot แล้วขึ้น **Google Play Store** (Internal Testing → Production) สำหรับ iOS วางแผน Apple Developer Account และ TestFlight - หรือใช้ MDM/Enterprise Distribution ถ้าเป็นแอปภายในองค์กรล้วน
6. **i18n ภาษาลาว:** เพิ่ม Localization ด้วย `flutter_localizations` + ไฟล์ `.arb` (`app_lo.arb`, `app_th.arb`, `app_en.arb`) ให้พนักงานเลือกภาษาลาว/ไทย/อังกฤษได้ พร้อมตรวจฟอนต์รองรับอักษรลาว (เช่น Noto Sans Lao) ทั้งในแอปและใน PDF รายงานที่จะ Export

**ระยะยาว**

7. **ขยาย Feature ตาม Roadmap ของทีม:** เช่น Dashboard ระดับผู้บริหาร (รวมทุกโรงผลิต), ระบบ Work Order ต่อจากการแจ้งเหตุขัดข้อง, Export รายงานเป็น PDF/Excel และ Role-based Access Control ละเอียดขึ้น (engineer/supervisor/executive)
8. **ยกระดับคุณภาพต่อเนื่อง:** ตั้งเป้า Test Coverage ฝั่ง Logic ไม่ต่ำกว่า 70%, เพิ่ม Integration Test (`patrol`/`integration_test`), และทำ Code Review เป็นวัฒนธรรมทีมผ่าน Pull Request ทุกครั้ง

---

## 📖 เอกสารอ้างอิงและแหล่งเรียนรู้เพิ่มเติม

- **Laravel 13 Documentation:** laravel.com/docs - โดยเฉพาะหัวข้อ Sanctum, Broadcasting (Reverb), Validation, Notifications และ Testing
- **Laravel Reverb:** laravel.com/docs/reverb - การตั้งค่า WebSocket Server และ Scaling ใน Production
- **Riverpod 3.0 Official Docs:** riverpod.dev - โดยเฉพาะหน้า Mutations, AsyncNotifier และ Testing (ProviderContainer + overrides)
- **flutter_bloc / Cubit:** bloclibrary.dev - แนวทาง Cubit, BlocObserver และ bloc_test ฉบับทางการ
- **fl_chart:** pub.dev/packages/fl_chart - ตัวอย่าง LineChart/BarChart พร้อม Interactive Demo
- **Packages ที่ใช้ในวันนี้:** pub.dev/packages/web_socket_channel, sqflite, dio, go_router, flutter_secure_storage, image_picker, geolocator, equatable, mocktail
- **GitHub Actions:** docs.github.com/actions - Workflow Syntax และ Marketplace ของ Action ที่ใช้ (setup-php, flutter-action, upload-artifact)
- **OWASP API Security Top 10:** owasp.org/API-Security - Checklist ความปลอดภัยก่อนขึ้น Production
- **Flutter Internationalization:** docs.flutter.dev/ui/accessibility-and-internationalization/internationalization - แนวทาง i18n สำหรับภาษาลาว/ไทย
- **Source Code ของหลักสูตร:** Repository ที่วิทยากรแจกในห้องอบรม (Branch `day1` ถึง `day5-final`) พร้อม README ภาษาไทยทุก Branch

---

> ขอบคุณทีม EDL-Generation ทุกท่านที่ตั้งใจตลอด 5 วันเต็ม ขอให้สนุกกับการต่อยอด EDL-Gen Monitoring App สู่ระบบจริง แล้วพบกันในหลักสูตรถัดไปครับ - อ.สามิตร โกยม, สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง (www.itgenius.co.th)
