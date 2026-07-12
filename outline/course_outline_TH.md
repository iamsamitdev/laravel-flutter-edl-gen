# Basic to Advanced Laravel 13 and Flutter Framework

**30 ชั่วโมง (อบรม 5 วัน วันละ 6 ชั่วโมง)**  
*หลักสูตรอบรมเชิงปฏิบัติการ (Hands-on Workshop) — สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง*  
Course ID: **MOB-15** | Category: Mobile / Full-Stack

---

## บทนำ

การพัฒนาแอปพลิเคชันสมัยใหม่ต้องการสถาปัตยกรรมที่แยกชั้นการทำงานอย่างชัดเจน ทั้งฝั่ง Backend ที่ให้บริการข้อมูลผ่าน API และฝั่ง Mobile ที่ต้องตอบสนองผู้ใช้ได้อย่างรวดเร็ว ทำงานได้แม้ในสภาวะเครือข่ายไม่เสถียร และดูแลรักษาได้ในระยะยาว การเลือก Stack ที่เหมาะสมและรู้จักใช้เครื่องมือให้ถูกจุดจึงเป็นทักษะสำคัญของนักพัฒนายุคปัจจุบัน

หลักสูตรนี้ออกแบบมาเพื่อพานักพัฒนาเดินทางจากพื้นฐานสู่ระดับสูง (Basic to Advanced) ในการสร้างระบบ Full-Stack แบบครบวงจร เริ่มตั้งแต่การสร้าง Backend API ด้วย **Laravel 13** บน MariaDB/PostgreSQL ไปจนถึงการสร้าง **Flutter Mobile App** ที่ใช้ **Riverpod 3.0 + Cubit** เป็น State Management ในแนวทาง Hybrid Approach ที่เหมาะกับงานระดับ Enterprise ผู้เรียนจะได้ลงมือเขียนโค้ดจริงทุกวัน และนำทุกองค์ประกอบมาประกอบเป็น Workshop ที่สมบูรณ์ในวันสุดท้าย

> **หมายเหตุ:** หลักสูตรเน้นการลงมือปฏิบัติจริง (Hands-on) ทุกวันจะมี Lab ให้ผู้เรียนเขียนโค้ดตามทีละขั้น ผู้เรียนควรติดตั้ง Flutter SDK, Android Studio, Docker, PHP 8.3 และ Composer ก่อนวันอบรม

---

## กำหนดการอบรม

- **ระยะเวลา:** 5 วัน วันละ 6 ชั่วโมง รวม 30 ชั่วโมง
- **เวลาอบรม:** 09:00–12:00 น. และ 13:00–16:00 น. (พักกลางวัน 1 ชั่วโมง)
- **รูปแบบ:** In-house Training หรือ Online ผ่าน Zoom
- **Lab ทุกวัน:** ผู้เรียนลงมือเขียนโค้ดจริงบนเครื่องของตนเอง พร้อม Starter Kit ที่เตรียมไว้ให้

---

## ภาพรวมหัวข้อการฝึกอบรม

- **Laravel 13 API Layer:** ออกแบบ RESTful API ด้วย Laravel Sanctum/JWT, API Resources, Repository Pattern บน MariaDB/PostgreSQL
- **Riverpod 3.0 Async State:** AsyncValue, AsyncNotifier, Mutations API (idle→pending→success/error) และ Automatic Retry
- **Flutter Foundation:** Widget Tree, BuildContext, Stateless vs Stateful Widget — เรียนรู้ 'ปัญหา' ก่อนเพื่อเข้าใจ Why State Management
- **Riverpod 3.0 พื้นฐาน:** Provider types, ConsumerWidget, ref.watch/read/listen และ @riverpod code generation
- **Riverpod Advanced + Cubit:** NotifierProvider, StreamProvider (WebSocket), Offline Persistence, AuthCubit, BlocObserver
- **Workshop ครบวงจร:** ประกอบทุกองค์ประกอบเป็นแอป Monitoring จริง ครอบคลุม Login, Real-time Dashboard, รายงาน Offline, แจ้งเหตุขัดข้อง, บันทึกข้อมูล

---

## ผู้สอน

**อาจารย์สามิตร โกยม** — ผู้เชี่ยวชาญด้านการพัฒนาซอฟต์แวร์และการออกแบบ Mobile Application มีประสบการณ์มากกว่า 15 ปีในวงการ IT Training และการพัฒนาระบบสำหรับองค์กรขนาดใหญ่ในภูมิภาคอาเซียน

- **ประสบการณ์สอน:** วิทยากรด้าน Mobile App Development, API Design และ Database Architecture มากกว่า 10 ปี
- **ความเชี่ยวชาญ:** Laravel, Flutter, Node.js, React Native, PostgreSQL, Docker และ Cloud-Native Architecture
- **งานที่ผ่านมา:** ออกแบบและพัฒนาระบบสำหรับองค์กรภาครัฐและเอกชนในไทย, ลาว และกัมพูชา รวมถึงโครงการด้านพลังงานและโครงสร้างพื้นฐาน
- **ปรัชญาการสอน:** 'เรียนจากปัญหาจริง แก้ด้วยโค้ดจริง' — ทุก Lab ออกแบบให้ตรงกับ Use Case ของผู้เรียนโดยตรง

---

## ผู้เรียนต้องมีพื้นฐานอะไรบ้าง?

- **ภาษาโปรแกรมพื้นฐาน:** มีความรู้ PHP (พื้นฐาน OOP) และ Dart/Flutter เบื้องต้น หรือผ่านประสบการณ์พัฒนา App อื่น ๆ มาบ้าง
- **ฐานข้อมูล:** เข้าใจ SQL พื้นฐาน (SELECT, INSERT, JOIN) บน MariaDB หรือ PostgreSQL
- **Git & Terminal:** ใช้ git clone, commit, push ได้ และพิมพ์คำสั่ง Terminal / Command Prompt ได้
- **ไม่จำเป็นต้องรู้จัก:** Riverpod, Cubit, Laravel Sanctum, หรือ WebSocket มาก่อน — หลักสูตรนี้สอนตั้งแต่พื้นฐาน

---

## จุดเด่นของหลักสูตร

- **Basic to Advanced ในคอร์สเดียว:** เริ่มจากพื้นฐาน Laravel และ Flutter ค่อย ๆ ยกระดับสู่ State Management ขั้นสูงและ Offline-First Architecture จนสร้างแอปจริงได้
- **Hybrid State Management (Riverpod 3.0 + Cubit):** ใช้ทั้งสองร่วมกันอย่างถูกจุด Riverpod สำหรับ Data Layer และ Async State ส่วน Cubit สำหรับ Business Logic ที่ซับซ้อน เช่น Auth Flow และ Audit Trail
- **Offline-First Architecture:** ออกแบบให้แอปทำงานได้แม้สัญญาณเครือข่ายขาดหาย ด้วย riverpod_sqflite Cache ที่ Sync กลับเมื่อออนไลน์
- **Laravel 13 + Repository Pattern:** เขียน API ที่ Clean, Testable และรองรับการสลับฐานข้อมูลระหว่าง MariaDB และ PostgreSQL ได้โดยไม่แตะ Business Logic
- **เนื้อหาอัพเดทปี 2026:** ใช้ Flutter 3.x, Dart 3.x, Riverpod 3.0 (Mutations API ใหม่), Laravel 13 และ PHP 8.3 — เครื่องมือล่าสุดที่ Community รองรับ
- **BlocObserver / Audit Trail:** ทุก State Change ถูก Log อัตโนมัติ เหมาะกับมาตรฐานความปลอดภัยและการตรวจสอบย้อนหลังขององค์กร

---

## วัตถุประสงค์ของหลักสูตร

- เพื่อให้ผู้เรียนสามารถออกแบบและสร้าง RESTful API ด้วย Laravel 13 พร้อม Authentication (Sanctum/JWT) และ Repository Pattern บน MariaDB/PostgreSQL
- เพื่อให้ผู้เรียนเข้าใจโครงสร้าง Flutter Widget Tree และสามารถสร้าง UI Component สำหรับ Dashboard ได้
- เพื่อให้ผู้เรียนประยุกต์ใช้ Riverpod 3.0 ในการจัดการ Async State ครอบคลุม AsyncValue, AsyncNotifier และ Mutations API ใหม่
- เพื่อให้ผู้เรียนนำ Cubit มาจัดการ Business Logic ระดับ Enterprise เช่น Auth Session, Status Management และ Audit Logging
- เพื่อให้ผู้เรียนสร้าง Offline-First Mobile App ที่ Cache ข้อมูลและ Sync กลับเมื่อเชื่อมต่อเครือข่ายได้
- เพื่อให้ผู้เรียนมี Prototype แอปพลิเคชันที่พร้อมต่อยอดนำไปใช้งานจริง

---

## หลักสูตรนี้เหมาะกับใคร?

- **นักพัฒนาซอฟต์แวร์:** ที่ต้องการสร้างหรือบำรุงรักษาระบบ Full-Stack ด้วย Laravel และ Flutter
- **Backend Developer:** ที่มีพื้นฐาน PHP/Laravel และต้องการเชื่อมระบบ API กับ Flutter Mobile App
- **Mobile Developer:** ที่ต้องการเรียนรู้ State Management ขั้นสูงด้วย Riverpod 3.0 และ Cubit ในโปรเจคจริง
- **Junior Developer:** ที่เพิ่งเริ่มต้น Flutter และต้องการเรียน State Management ในโปรเจคจริงตั้งแต่ต้น

---

## คอมพิวเตอร์และสภาพแวดล้อมที่รองรับ

- **ระบบปฏิบัติการ:** Windows 10/11 (64-bit), macOS 13+, หรือ Ubuntu 22.04
- **Flutter & Dart:** Flutter SDK 3.x (stable channel), Dart 3.x, Android Studio Ladybug หรือ VS Code + Flutter Extension
- **PHP & Laravel:** PHP 8.3+, Composer 2.x, Laravel 13 — ติดตั้งผ่าน Laragon (Windows) หรือ Homebrew/Docker
- **Database:** MariaDB 11.x หรือ PostgreSQL 16+ (Docker Image ให้บริการพร้อม)
- **เครื่องมืออื่น ๆ:** Git 2.x, Postman/Bruno (ทดสอบ API), Android Emulator หรือ Physical Device (Android 9+)
- **RAM:** แนะนำ 16 GB ขึ้นไป (Android Studio + Laravel + PostgreSQL รันพร้อมกัน)

---

## เนื้อหาการอบรม

### Day 1: Laravel 13 API Layer + Riverpod Async State

**Laravel 13 API Layer**

- **Laravel 13 Project Setup + API Architecture:** ติดตั้งและตั้งค่า Laravel 13 ด้วย Repository Pattern — แยก Controller, Service, Repository ให้ Clean และ Testable พร้อมกำหนด API versioning (`/api/v1/`)
- **Authentication ด้วย Laravel Sanctum + JWT:** ออกแบบ Login/Logout Flow, Token-based Auth สำหรับ Mobile Client, และ Middleware Guard สำหรับ Route ที่ต้องล็อกอินก่อนเข้า
- **API Resources & Collections:** แปลง Eloquent Model เป็น JSON Response ที่ Clean ด้วย Resource Classes, Nested Collection และ Conditional Fields — ป้องกัน Over-fetching ข้อมูล
- **MariaDB / PostgreSQL Repository Pattern:** เขียน Repository Interface และ Concrete Implementation ที่สามารถสลับ Driver ได้โดยไม่แก้ Business Logic — รวมถึง Migration, Seeder และ Database Transaction

**Riverpod Async State**

- **Riverpod 3.0 AsyncValue:** ทำความเข้าใจ State Machine (data / loading / error) และวิธี Consume ผล API ด้วย `when()` / `guard()` แบบ Null-safe
- **AsyncNotifier + Mutations API (3.0):** สร้าง AsyncNotifier สำหรับ CRUD โดยใช้ Mutations API ใหม่ที่มี lifecycle: `idle → pending → success/error`
  - เพิ่มข้อมูล
  - อัปเดตสถานะ
  - UI Feedback แต่ละ State
- **Automatic Retry:** เพิ่ม Retry Logic ด้วย Riverpod `retry` parameter และ Custom Exception Handler สำหรับ Unstable Network

> 🔬 **Lab วันที่ 1:** สร้าง Laravel API Endpoint พร้อม Sanctum Auth และ Flutter Widget ที่แสดง AsyncValue Loading/Error/Data State ครบถ้วน

---

### Day 2: Flutter Foundation + Widget System

**Flutter Architecture Overview**

- **Flutter Rendering Pipeline:** ทำความเข้าใจ Widget Tree, Element Tree และ RenderObject Tree — รู้ว่าทำไม Flutter ถึง Rebuild เร็วกว่า Native ในหลายกรณี
- **StatelessWidget vs StatefulWidget + setState:** สร้าง UI ด้วย StatefulWidget และ setState จนเห็น 'ปัญหา' ของ State ที่กระจัดกระจาย Prop-drilling และ Rebuild ที่ไม่จำเป็น ⚡ _สอนเพื่อให้เข้าใจ "ปัญหา" ก่อน_
- **Widget Tree & BuildContext:** เรียนรู้การใช้ BuildContext อย่างถูกต้อง, ความแตกต่างของ context ในแต่ละระดับ, และการหลีกเลี่ยง Context-related Bugs ที่พบบ่อย

**Layout & Navigation**

- **Layout Widgets:** Column, Row, Stack, Expanded, Flexible, ListView.builder, GridView.builder — สร้าง Responsive Layout สำหรับ Dashboard ที่รองรับทั้งโทรศัพท์และ Tablet
- **Custom Widgets + Composition Pattern:** แยก UI ออกเป็น Widget เล็ก ๆ ที่ Reusable เช่น `StatCard`, `StatusBadge`, `AlertTile` — ฝึก DRY Principle
- **Navigation + GoRouter:** ตั้งค่า GoRouter สำหรับ Named Routes, Route Guard (Auth Check), Deep Link และ Bottom Navigation

> 🔬 **Lab วันที่ 2:** สร้าง Flutter App Skeleton — มีหน้า Login, Dashboard (Mockup), รายงาน และการตั้งค่า พร้อม Navigation ครบถ้วนและ Custom Widget อย่างน้อย 3 ตัว

---

### Day 3: Riverpod 3.0 พื้นฐาน — Provider Types & Consumer Patterns

**ProviderScope & Provider Types**

- **Why State Management?** ทบทวนปัญหาจาก Day 2 `setState`: เปรียบเทียบ Code ก่อน/หลัง Riverpod — เห็น Prop-drilling, Rebuild ที่ไม่จำเป็น และ Testability
- **ProviderScope + Provider Lifecycle:** ตั้งค่า ProviderScope ที่ Root, Auto-dispose, Keep-alive, และวิธี Override Provider ใน Test Environment
- **Provider Types พื้นฐาน:**
  - `Provider` — ค่าคงที่ / Singleton
  - `StateProvider` — ค่าที่ UI เปลี่ยนได้ง่าย (Filter/Toggle)
  - `FutureProvider` — API Call แบบ Read-only

**Consumer Patterns & Code Generation**

- **ConsumerWidget & ConsumerStatefulWidget:** เขียน Widget ที่ Subscribe Riverpod Provider อย่างถูกต้อง
- **ref.watch vs ref.read vs ref.listen:** ความแตกต่างที่สำคัญที่สุดใน Riverpod — `watch` (rebuild), `read` (one-time), `listen` (side effect) + Anti-patterns ที่ควรหลีกเลี่ยง
- **@riverpod Annotation + Code Generation:** ใช้ `riverpod_generator` และ `riverpod_annotation` เพื่อสร้าง Provider ด้วย Annotation แบบ Type-safe ลด Boilerplate

> 🔬 **Lab วันที่ 3:** เชื่อม Flutter App กับ Laravel API จาก Day 1 ด้วย FutureProvider และ AsyncNotifier — แสดงข้อมูลจริงใน Dashboard พร้อม Loading Skeleton และ Error Banner

---

### Day 4: Advanced Riverpod + Cubit สำหรับ Enterprise Logic

**Riverpod Advanced**

- **NotifierProvider:** ใช้สำหรับ State ที่มีหลาย Field และ Method เช่น Report State ที่มี filter, sort, pagination และ refresh
- **StreamProvider + WebSocket Real-time:** เชื่อมต่อ Laravel WebSocket (Pusher/Ably หรือ Laravel Echo) — แสดงข้อมูล Real-time ✅ _Real-time monitoring_
- **Provider Family:** สร้าง Provider ที่รับ Parameter เช่น `detailProvider(id)` สำหรับ List/Detail Pattern
- **Offline Persistence (riverpod_sqflite):** Cache ข้อมูลลง SQLite — กำหนด TTL, Sync Strategy และ Conflict Resolution เมื่อ Online กลับมา
- **Provider Scoping & Override:** สำหรับ Testing และ Multi-tenant Architecture

**Cubit — เสริมสำหรับ Enterprise Logic**

- **Cubit vs BLoC:** เปรียบเทียบและอธิบายว่าทำไมเลือก Cubit เพราะง่ายกว่าและเหมาะกับ Enterprise Logic ขนาดนี้
- **AuthCubit (Login / Logout / Session):** Token Storage (`flutter_secure_storage`), Auto-refresh Token, Session Timeout, Logout ทั่วทั้งแอป
- **StatusCubit:** ติดตาม State พร้อม `BlocObserver` ที่ Log ทุก Transition เป็น Audit Trail ✅ _Audit trail_

> 🔬 **Lab วันที่ 4:** เพิ่ม Real-time Dashboard ด้วย StreamProvider + WebSocket, AuthCubit สำหรับ Login Flow และ Offline Cache — ทดสอบโดยปิด Network แล้วดูว่าแอป Fallback อย่างไร

---

### Day 5: Workshop ครบวงจร — EDL-Generation Monitoring App

**Feature 1 — Login & Auth Flow (Cubit + Laravel Sanctum)**

- ประกอบ AuthCubit กับ Laravel Sanctum API — Login, Token Refresh, Logout
- Route Guard ด้วย GoRouter Redirect เมื่อ Token หมดอายุ

**Feature 2 — Real-time Power Dashboard (StreamProvider + WebSocket)**

- แสดงค่ากำลังผลิต (MW), ความถี่ (Hz) และ Voltage Real-time ด้วย `fl_chart`
- อัพเดทอัตโนมัติทุกครั้งที่ Server Push ข้อมูลใหม่

**Feature 3 — รายงานการผลิตรายวัน (AsyncNotifier + Offline Cache)**

- ดึงรายงานผลิตรายวันจาก Laravel API, Cache ลง SQLite
- Filter ตามช่วงเวลาและโรงผลิต — ใช้ได้แม้ Network ไม่มี

**Feature 4 — แจ้งเหตุขัดข้องเครื่องจักร (Mutations API + Push Notification)**

- ส่งเหตุขัดข้องพร้อมภาพถ่าย, พิกัด GPS และระดับความรุนแรง
- แสดง `idle/pending/success/error` ครบถ้วน

**Feature 5 — บันทึกค่ามิเตอร์ (Cubit + MariaDB via Laravel API)**

- Form บันทึกค่ามิเตอร์รายชั่วโมงพร้อม Validation
- Optimistic UI Update และบันทึกลง MariaDB ผ่าน Laravel API

**Code Review & Best Practices**

- ทบทวนโค้ดที่เขียนตลอด 5 วัน ชี้ Anti-pattern ที่ควรแก้
- วิธี Unit Test Cubit และ Riverpod Provider
- แนวทาง CI/CD เบื้องต้น (GitHub Actions)

> 🔬 **Workshop วันที่ 5 — Final PoC Presentation:** แต่ละทีมนำเสนอ Prototype ที่สมบูรณ์ พร้อมรับ Feedback และวางแผน Next Step สำหรับการพัฒนาต่อในโปรเจคจริง

---

## สิ่งที่ผู้เรียนจะได้รับเมื่อจบหลักสูตร

- **Prototype แอป Monitoring:** Flutter App ที่ทำงานได้จริงบน Android พร้อม Feature ครบ 5 ด้าน
- **Laravel API Codebase:** Source Code Laravel 13 API ที่สะอาด มี Repository Pattern, Authentication และ Test Cases เบื้องต้น
- **เอกสารประกอบการอบรม:** Slide, Lab Guide และ Starter Kit Code พร้อม README ภาษาไทย
- **Certificate of Completion:** ใบประกาศนียบัตรจาก IT Genius Engineering
- **Community Access:** เข้ากลุ่ม LINE/Slack ของ IT Genius สำหรับถามตอบปัญหาและ Networking

---

## ภาพรวมหลักสูตร (Big Picture)

หลักสูตรนี้ออกแบบให้แต่ละวันต่อยอดจากวันก่อนอย่างต่อเนื่อง Day 1 วางรากฐาน Backend API และ Async State, Day 2–3 สร้าง Flutter UI และเรียน Riverpod พื้นฐาน, Day 4 ยกระดับสู่ Advanced State Management ด้วย Cubit และ Offline-First Architecture, และ Day 5 ประกอบทุกส่วนเป็น Prototype แอป Monitoring จริง

| วัน | โฟกัส | ผลลัพธ์ของวัน |
|-----|-------|--------------|
| Day 1 | Laravel 13 API + Authentication + Riverpod Async State | Laravel API พร้อม Auth, Flutter Widget แสดง AsyncValue State |
| Day 2 | Flutter Foundation — Widget System & Navigation | App Skeleton พร้อม Navigation, Custom Widget และ Layout |
| Day 3 | Riverpod 3.0 พื้นฐาน — Provider Types & Consumer Patterns | Flutter App เชื่อมต่อ Laravel API จริง แสดงข้อมูล |
| Day 4 | Advanced State: StreamProvider, Cubit, Offline Cache | Real-time Dashboard, Auth Flow และ Offline Mode ทำงานได้ |
| Day 5 | Workshop: EDL-Generation Monitoring App ครบ 5 Feature | Prototype พร้อมนำเสนอและต่อยอดใช้งานจริง |

---

## Tech Stack และเครื่องมือที่ใช้

| Layer | Technology |
|-------|-----------|
| Backend | Laravel 13, PHP 8.3, Laravel Sanctum, JWT Auth, Eloquent ORM, Laravel Echo |
| Database | MariaDB 11.x / PostgreSQL 16+ (Repository Pattern รองรับทั้งสอง Driver) |
| Mobile | Flutter 3.x (stable), Dart 3.x, GoRouter, fl_chart, flutter_secure_storage |
| State Management | Riverpod 3.0, riverpod_annotation, riverpod_generator, riverpod_sqflite, flutter_bloc (Cubit) |
| Dev Tools | Android Studio / VS Code, Postman/Bruno, Docker Compose, Git, TablePlus/DBeaver |
| DevOps | GitHub Actions สำหรับ Laravel API Test + Flutter Build (แนะนำวันที่ 5) |

---

## ข้อเสนอแนะก่อนจัดอบรม

- **เตรียม Dataset ตัวอย่างหรือ Mockup:** ควรมีตัวอย่างข้อมูลที่ใกล้เคียงกับงานจริงเพื่อใช้ใน Lab และ Workshop
- **ติดตั้งเครื่องมือก่อนอบรม:** ส่ง Pre-install Guide ให้ผู้เรียนอย่างน้อย 3 วันก่อน (Flutter SDK, Android Studio, Docker, PHP 8.3, Composer, Postman)
- **Test Android Device / Emulator:** ทดสอบว่า Android Emulator รันได้บนเครื่องของผู้เรียนทุกคน — หาก CPU ไม่รองรับ Hardware Acceleration อาจต้องใช้ Physical Device แทน
- **Network ของสถานที่อบรม:** ตรวจสอบว่า Port ที่ Laravel ใช้ (8000, 6001 สำหรับ WebSocket) ไม่ถูก Firewall ขวาง

---

## ติดต่อ

> **สนใจจัดอบรม In-house หรือสอบถามรายละเอียดเพิ่มเติม**
>
> สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง  
> โทร. 02-570-8449 | มือถือ 088-807-9770  
> เว็บไซต์: [www.itgenius.co.th](https://www.itgenius.co.th) | Email: contact@itgenius.co.th  
> LINE Official: @itgenius | Facebook: IT Genius Engineering
