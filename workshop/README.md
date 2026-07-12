# EDL-Gen Monitoring Workshop — โปรเจกต์ครบวงจร (Laravel 13 + Flutter/Riverpod 3)

โปรเจกต์ประกอบหลักสูตร **Basic to Advanced Laravel 13 and Flutter Framework (MOB-15, 30 ชั่วโมง / 5 วัน)**
จัดอบรมให้ EDL-Generation Public Company (สปป.ลาว) — ข้อมูลทั้งหมดเป็นข้อมูลจำลอง

```
workshop/
├── docker-compose.yml        ← MariaDB 11.4 + PostgreSQL 16
├── edlgen_api/               ← Laravel 13 API (Sanctum + Reverb + Repository Pattern)
├── edlgen_monitoring/        ← Flutter App (Riverpod 3 + Cubit + GoRouter + sqflite)
└── .github/workflows/ci.yml  ← CI: Laravel test → Flutter analyze/test/build APK
```

---

## 1) เริ่มต้นใช้งานครั้งแรก

### 1.1 ฐานข้อมูล (Docker)

```bash
cd workshop
docker compose up -d          # รัน edlgen_mariadb (3306) + edlgen_postgres (5432)
docker compose ps             # STATUS ต้องเป็น Up ทั้งคู่
```

### 1.2 Laravel API

```bash
cd edlgen_api
composer install
php artisan migrate:fresh --seed   # สร้างตาราง + ผู้ใช้ทดสอบ + โรงไฟฟ้า 5 แห่ง + รายงาน 30 วัน
php artisan storage:link           # จำเป็นสำหรับรูปแจ้งเหตุ (Feature 4)
php artisan serve                  # REST API → http://127.0.0.1:8000
```

**สลับเป็น PostgreSQL:** แก้ `.env` เป็น `DB_CONNECTION=pgsql` / `DB_PORT=5432` แล้ว
`php artisan config:clear && php artisan migrate:fresh --seed` (โค้ดไม่ต้องแก้สักบรรทัด — Repository Pattern)

### 1.3 Terminal ที่ต้องเปิดค้างระหว่างสอน Day 4-5 (Real-time)

| Terminal | คำสั่ง | หน้าที่ |
|---|---|---|
| T1 | `php artisan serve` | REST API :8000 |
| T2 | `php artisan reverb:start --debug` | WebSocket :8080 |
| T3 | `php artisan edlgen:simulate-readings --interval=3` | จำลองค่าผลิตทุก 3 วิ + broadcast |
| T4 | `flutter run` (ในโฟลเดอร์ edlgen_monitoring) | ตัวแอป |

### 1.4 Flutter App

```bash
cd edlgen_monitoring
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # gen .g.dart ของ Riverpod
flutter run
```

**ผู้ใช้ทดสอบ (seed แล้ว):**

| Email | Password | Role |
|---|---|---|
| `engineer@edlgen.la` | `password123` | operator (ใช้ Login ในแอป — กรอกไว้ให้แล้ว) |
| `supervisor@edlgen.la` | `password123` | supervisor (รับ Notification เหตุขัดข้อง) |

**Base URL ตามอุปกรณ์** (ตั้งใน `lib/core/config/app_config.dart` — override ได้ด้วย `--dart-define`):

| อุปกรณ์ | REST | WebSocket |
|---|---|---|
| Android Emulator (ค่าเริ่มต้น) | `http://10.0.2.2:8000/api/v1/` | `ws://10.0.2.2:8080/app/edlgen-local-key` |
| iOS Simulator | `http://127.0.0.1:8000/api/v1/` | `ws://127.0.0.1:8080/...` |
| เครื่องจริง | `http://<IP วง LAN>:8000/api/v1/` + รัน `php artisan serve --host=0.0.0.0` | `ws://<IP>:8080/...` |

```bash
# ตัวอย่างชี้ไปเครื่องจริง
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8000/api/v1/ \
            --dart-define=WS_URL=ws://192.168.1.50:8080/app/edlgen-local-key
```

---

## 2) API Endpoints (ทั้งหมดขึ้นต้น `/api/v1`)

| Method | Path | ใช้ในวัน | หมายเหตุ |
|---|---|---|---|
| GET | `/health`, `/ping` | 1 | ตรวจความพร้อม (public) |
| POST | `/login` และ `/auth/login` | 1, 5 | คืน `token` + `data.{token,expires_at,user}` |
| POST | `/logout`, `/auth/logout` | 1 | ลบ token อุปกรณ์ปัจจุบัน |
| GET | `/me`, `/auth/me` | 1 | ตรวจ token |
| POST | `/refresh`, `/auth/refresh` | 4, 5 | Token Rotation |
| GET | `/power-plants`, `/power-plants/{id}` | 1 | Repository Pattern + Pagination + Resource |
| GET | `/dashboard/summary` | 3 | การ์ดสรุป Dashboard |
| GET | `/plants`, `/plants/{id}` | 3, 5 | รายการย่อ + dropdown + Plant detail |
| GET | `/reports/daily?date_from&date_to&plant_id` | 5 | Feature 3 (สูงสุด 60 รายการ) |
| GET/POST | `/incidents` | 5 | Feature 4 — POST เป็น multipart (photo+GPS) → 201, แจ้ง supervisor |
| GET/PATCH | `/incidents/{id}` | 5 | รายละเอียด + อัปเดตสถานะ timeline |
| GET | `/meter-readings/today` | 5 | รายการที่บันทึกวันนี้ |
| POST | `/meter-readings` | 5 | Feature 5 — regex `^MTR-[0-9]{4}$`, ซ้ำชั่วโมงเดิม → **409** |

**Broadcasting (Reverb):** channel `power.readings` · event `power.reading.updated`
payload: `plant_id, plant_name, power_mw, frequency, voltage_kv, recorded_at`

> หมายเหตุการรวมสเปค: โน้ตแต่ละวันตั้งชื่อ endpoint ไม่ตรงกัน (Day 1 `/login`, Day 5 `/auth/login`)
> โปรเจกต์นี้จึงทำ **alias ทั้งสองแบบ** ชี้ Controller เดียวกัน เพื่อให้โค้ดตัวอย่างของทุกวันใช้ได้จริง

---

## 3) แผนที่โค้ด ↔ เนื้อหารายวัน

| วัน | หัวข้อ | โค้ดที่เกี่ยวข้อง |
|---|---|---|
| 1 | Laravel API + Sanctum + Repository + AsyncValue | `edlgen_api/app/**` ทั้งหมด, `Repositories/`, `AuthController`, seeders |
| 2 | Widget System + Custom Widgets + GoRouter | `lib/core/widgets/` (StatCard/StatusBadge/AlertTile), `lib/core/router/` |
| 3 | Riverpod 3 + Dio + เชื่อม API จริง | `lib/core/network/`, `lib/features/dashboard/` (FutureProvider + AsyncNotifier + codegen) |
| 4 | Cubit + Secure Storage + WebSocket + Offline | `lib/features/auth/logic/`, `power_socket_service.dart`, `app_bloc_observer.dart`, `report_local_data_source.dart` |
| 5 | Workshop 5 Features | ทุก feature + tests + CI (`.github/workflows/ci.yml`) |

**5 Features (Day 5) → State Management ที่ใช้:**

1. **Login & Auth Flow** — `AuthCubit` + flutter_secure_storage + GoRouter guard + Dio interceptor auto-refresh 401
2. **Real-time Dashboard** — `latestPowerReading` (StreamProvider) + `PowerHistory` (สะสม 30 จุด) + fl_chart
3. **รายงานรายวัน + Offline** — `DailyReports` (AsyncNotifier) + `ReportFilterState` + sqflite fallback + banner เหลือง
4. **แจ้งเหตุขัดข้อง** — `submitIncidentMutation` (Riverpod Mutations: idle→pending→success/error) + image_picker + geolocator
5. **บันทึกค่ามิเตอร์** — `MeterEntryCubit` + Optimistic Update (นาฬิกาส้ม→ติ๊กเขียว, rollback เมื่อ 409)

---

## 4) การทดสอบ

```bash
# Laravel (9 tests: Auth flow + Meter 201/409/422)
cd edlgen_api && php artisan test

# Flutter (7 tests: AuthCubit bloc_test + DailyReports ProviderContainer)
cd edlgen_monitoring && flutter test
```

---

## 5) ข้อควรรู้เฉพาะเครื่องผู้สอน

- **พาธภาษาไทยกับ `flutter analyze`:** analyzer LSP มีบั๊กกับพาธ non-ASCII
  มีการสร้าง junction `C:\edlgen_ws` → โฟลเดอร์ workshop นี้ไว้แล้ว ให้รัน analyze/build ผ่าน
  `cd C:\edlgen_ws\edlgen_monitoring` แทน (โค้ดชุดเดียวกัน แก้ที่ไหนก็เห็นทั้งคู่)
- **ฟอนต์ลาว:** ดีไซน์กำหนด **Phetsarath OT** — ต้องหาไฟล์ `.ttf` ทางการมาวาง `assets/fonts/`
  แล้วประกาศใน `pubspec.yaml` ระหว่างนี้ใช้ **Noto Sans Lao** (google_fonts) ตาม mockup
- **ภาษาแอป:** ค่าเริ่มต้นลาว · สลับ ລາວ/ไทย/EN ได้ที่หน้า Login (segmented) และหน้า Profile (แตะวนภาษา)
- **HTTP ธรรมดา (cleartext)** เปิดไว้ใน AndroidManifest สำหรับ Dev เท่านั้น — Production ต้อง HTTPS
- **Design reference:** เปิด `../design_handoff_edlgen_monitoring/EDL-Gen Prototype.html` ในเบราว์เซอร์
  (โทเคนสี/ฟอนต์/ระยะทั้งหมดถูก port เข้า `lib/core/theme/` แล้ว)

## 6) เดโมที่แนะนำตอนสอน

1. **Token lifecycle (Day 1):** Postman → login → `/me` → logout → `/me` เดิมได้ 401
2. **Real-time (Day 4-5):** เปิดแอป + หยุด `edlgen:simulate-readings` → กราฟค้าง (ไม่ crash) → รันใหม่ → วิ่งต่อ
3. **Offline (Day 5):** เปิดหน้า Reports ให้โหลดสำเร็จ 1 ครั้ง → เปิด Airplane Mode → ปิด-เปิดแอป → ข้อมูลยังอยู่ + banner เหลือง
4. **409 dedup (Day 5):** บันทึกมิเตอร์รหัสเดิมชั่วโมงเดิมซ้ำ → รายการ pending ถูก rollback + SnackBar
