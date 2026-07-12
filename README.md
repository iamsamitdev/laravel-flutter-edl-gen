# Basic to Advanced Laravel 13 and Flutter Framework — EDL-Gen Laos

**Course ID: MOB-15** | Category: Mobile / Full-Stack | 30 ชั่วโมง (5 วัน × 6 ชั่วโมง)

หลักสูตรอบรมเชิงปฏิบัติการ (Hands-on Workshop) จัดโดย **สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง** ให้กับ **EDL-Generation Public Company (สปป.ลาว)**
ผู้เรียนจะสร้างระบบ Full-Stack แบบครบวงจร — **"EDL-Gen Monitoring App"** ระบบตรวจสอบข้อมูลการผลิตไฟฟ้า (ข้อมูลจำลองทั้งหมด) — ประกอบด้วย Backend API ด้วย **Laravel 13** และ Mobile App ด้วย **Flutter + Riverpod 3.0 + Cubit**

- **วันอบรม:** 13–17 กรกฎาคม 2026 (จันทร์–ศุกร์), 09:30–16:30 น.
- **ผู้สอน:** อาจารย์สามิตร โกยม (Samit Koyom)

---

## 📁 โครงสร้างโปรเจกต์

```
.
├── outline/                          # เอกสารหลักสูตรฉบับทางการ (TH/EN)
├── notes/                            # สรุปเนื้อหาการสอนรายวัน (Day1-5)
├── pre-test/                         # แบบทดสอบก่อนเรียน + ไฟล์ CSV สำหรับ Quizizz
├── presentation/                     # สไลด์ประกอบการสอน
├── design_handoff_edlgen_monitoring/ # UI/UX Design System และ Prototype (HTML/JSX)
└── workshop/                         # โค้ดจริงของโปรเจกต์
    ├── docker-compose.yml            # MariaDB 11.4 + PostgreSQL 16
    ├── edlgen_api/                   # Laravel 13 API (Sanctum + Reverb + Repository Pattern)
    └── edlgen_monitoring/            # Flutter App (Riverpod 3 + Cubit + GoRouter + sqflite)
```

> **หมายเหตุ:** ไฟล์ [note_example.md](note_example.md), [pre-test-example.md](pre-test-example.md) และไฟล์ในโฟลเดอร์ `notes/` ที่ชื่อ `Setup Checklist.md`, `Code Generation - build_runner explain.md`, `Riverpod Codegen - เมื่อไหร่ต้อง gen.md` เป็นเอกสารอ้างอิง/เทมเพลตทั่วไปที่หยิบยืมมาจากคอร์สอื่น (Advanced Flutter 2026) ไม่ใช่เนื้อหาเฉพาะของคอร์ส EDL-Gen Laos นี้

---

## 🧰 Tech Stack

| Layer | Technology |
|---|---|
| Backend | Laravel 13, PHP 8.3, Laravel Sanctum, Laravel Reverb (WebSocket), Eloquent ORM, Repository Pattern |
| Database | MariaDB 11.4 หรือ PostgreSQL 16 (สลับได้โดยไม่แก้โค้ด) |
| Mobile | Flutter 3.x, Dart 3.12, GoRouter, fl_chart, flutter_secure_storage |
| State Management | Riverpod 3.0 (AsyncNotifier/Mutations API), riverpod_annotation/generator, flutter_bloc (Cubit) |
| Persistence | sqflite (offline-first cache), shared_preferences |
| Dev Tools | Docker Compose, Postman/Bruno, GitHub Actions (CI) |

---

## 🗓️ เนื้อหาการอบรมโดยสรุป

| วัน | หัวข้อหลัก |
|---|---|
| **Day 1** | Laravel 13 API Layer (Repository Pattern, Sanctum Auth, API Resources) + Riverpod `AsyncValue`/`AsyncNotifier`/Mutations API |
| **Day 2** | Flutter Foundation (Widget/Element/RenderObject Tree, BuildContext, Layout Widgets) + GoRouter |
| **Day 3** | Riverpod 3.0 พื้นฐาน (Provider types, `ref.watch/read/listen`, `@riverpod` codegen) + เชื่อมต่อ API จริงด้วย Dio |
| **Day 4** | Riverpod ขั้นสูง (`NotifierProvider`, `StreamProvider` + WebSocket ผ่าน Reverb, Offline Persistence) + Cubit (`AuthCubit`, `StatusCubit`, `BlocObserver`) |
| **Day 5** | Workshop ครบวงจร: ประกอบ 5 ฟีเจอร์ (Login, Real-time Dashboard, รายงาน Offline, แจ้งเหตุขัดข้อง, บันทึกมิเตอร์), Code Review, CI/CD เบื้องต้น, นำเสนอ PoC |

รายละเอียดฉบับเต็มดูได้ที่ [outline/course_outline_TH.md](outline/course_outline_TH.md) / [outline/course_outline_EN.md](outline/course_outline_EN.md) และสรุปการสอนรายวันที่ [notes/](notes/)

---

## 🚀 เริ่มต้นใช้งานโปรเจกต์ (Workshop)

### 1) ฐานข้อมูล (Docker)

```bash
cd workshop
docker compose up -d          # รัน edlgen_mariadb (3306) + edlgen_postgres (5432)
docker compose ps
```

### 2) Laravel API

```bash
cd workshop/edlgen_api
composer install
php artisan migrate:fresh --seed   # สร้างตาราง + ผู้ใช้ทดสอบ + โรงไฟฟ้า 5 แห่ง + รายงาน 30 วัน
php artisan storage:link
php artisan serve                  # REST API → http://127.0.0.1:8000
```

สลับเป็น PostgreSQL: แก้ `.env` เป็น `DB_CONNECTION=pgsql` / `DB_PORT=5432` แล้วรัน `php artisan config:clear && php artisan migrate:fresh --seed` (ไม่ต้องแก้โค้ด — Repository Pattern)

สำหรับสาธิต Real-time (Day 4-5) ต้องเปิดเพิ่มอีก 2 terminal:

```bash
php artisan reverb:start --debug                          # WebSocket :8080
php artisan edlgen:simulate-readings --interval=3          # จำลองค่าผลิตไฟฟ้า
```

### 3) Flutter App

```bash
cd workshop/edlgen_monitoring
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # gen โค้ด Riverpod
flutter run
```

### บัญชีทดสอบ (seed แล้ว)

| Email | Password | Role |
|---|---|---|
| `engineer@edlgen.la` | `password123` | operator |
| `supervisor@edlgen.la` | `password123` | supervisor (รับแจ้งเตือน incident) |

---

## ✅ Prerequisites

- Windows 10/11 (64-bit), macOS 13+ หรือ Ubuntu 22.04
- Flutter SDK 3.x + Dart 3.x, Android Studio หรือ VS Code + Flutter Extension
- PHP 8.3+, Composer 2.x
- Docker (สำหรับ MariaDB/PostgreSQL) หรือ MariaDB 11.x/PostgreSQL 16+ ที่ติดตั้งเอง
- Git 2.x, Postman/Bruno, Android emulator หรืออุปกรณ์จริง (Android 9+)
- แนะนำ RAM 16 GB ขึ้นไป

พื้นฐานที่ผู้เรียนควรมี: PHP/OOP เบื้องต้น, Dart/Flutter เบื้องต้น (หรือประสบการณ์พัฒนาแอปอื่น), SQL เบื้องต้น, ใช้งาน Git/Terminal ได้ — ไม่จำเป็นต้องรู้จัก Riverpod, Cubit, Sanctum หรือ WebSocket มาก่อน

---

## 📚 เอกสารอื่น ๆ ในโปรเจกต์

- **แบบทดสอบก่อนเรียน:** [pre-test/laravel13-flutter-pretest.md](pre-test/laravel13-flutter-pretest.md)
- **สไลด์ประกอบการสอน:** [presentation/](presentation/)
- **UI/UX Design System และ Prototype:** [design_handoff_edlgen_monitoring/README.md](design_handoff_edlgen_monitoring/README.md)
- **คำแนะนำการติดตั้ง/รันโปรเจกต์แบบละเอียด:** [workshop/README.md](workshop/README.md)
