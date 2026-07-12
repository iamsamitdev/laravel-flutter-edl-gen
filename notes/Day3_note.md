# Basic to Advanced Laravel 13 & Flutter - วันที่ 3: Riverpod 3.0 พื้นฐาน - Provider Types & Consumer Patterns

**หลักสูตรอบรมเชิงปฏิบัติการ: Basic to Advanced Laravel 13 and Flutter Framework (30 ชั่วโมง, 5 วัน)**
**Course ID: MOB-15 | Category: Mobile / Full-Stack**
**จัดอบรมให้: EDL-Generation Public Company (EDL-Gen) ผู้ผลิตไฟฟ้ารายใหญ่ของ สปป.ลาว**
**วันที่ 3: Riverpod 3.0 พื้นฐาน - Provider Types & Consumer Patterns**
วันที่: วันพุธที่ 15 กรกฎาคม 2569 | เวลา 09:30-16:30 น. (พักกลางวัน 12:00-13:00 น.) | Onsite Workshop ณ สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
ผู้สอน: อ.สามิตร โกยม

---

## 🎯 วัตถุประสงค์การเรียนรู้ประจำวัน

เมื่อจบการอบรมวันที่ 3 ผู้เรียนจะสามารถ:

1. อธิบายปัญหาของการจัดการ State ด้วย `setState` (Prop-drilling, Rebuild ที่ไม่จำเป็น, ทดสอบยาก) และเหตุผลที่ต้องใช้ State Management ได้
2. ตั้งค่า `ProviderScope` ที่ Root ของแอป และอธิบาย Provider Lifecycle (Auto-dispose, Keep-alive, Override) ได้
3. เลือกใช้ Provider Types พื้นฐานได้ถูกสถานการณ์ - `Provider` (ค่าคงที่/Singleton), `StateProvider` (Filter/Toggle), `FutureProvider` (API Call แบบ Read-only)
4. เขียน `ConsumerWidget` และ `ConsumerStatefulWidget` ที่ Subscribe Provider อย่างถูกต้อง
5. แยกความแตกต่างของ `ref.watch()`, `ref.read()`, `ref.listen()` และหลีกเลี่ยง Anti-patterns ที่พบบ่อยได้
6. ใช้ `@riverpod` Annotation ร่วมกับ `riverpod_generator` + `build_runner` สร้าง Provider แบบ Type-safe ลด Boilerplate ได้
7. เชื่อม Flutter App เข้ากับ Laravel API ผ่าน Dio ได้ครบวงจร - ตั้งค่า Base URL, แนบ Bearer Token, แปลง JSON เป็น Model, จัดการ Error
8. ลงมือสร้าง Data Flow จริง Model -> Repository -> Provider -> UI แสดงข้อมูลจาก `edlgen_api` บน Dashboard พร้อม Loading Skeleton และ Error Banner (Lab วันที่ 3)

> **หมายเหตุสำคัญ:** วันนี้คือวันที่ "สองโลกมาบรรจบกัน" - Laravel Backend `edlgen_api` ที่สร้างใน Day 1 และ Flutter App Skeleton `edlgen_monitoring` ที่สร้างใน Day 2 จะถูกเชื่อมเข้าด้วยกันด้วย **Riverpod 3.0** ตั้งแต่วันนี้ Dashboard ของเราจะไม่ใช้ Mockup Data อีกต่อไป แต่แสดงข้อมูลจริงจากฐานข้อมูลผ่าน API

---

## 🧭 กำหนดการวันที่ 3 (โดยสังเขป)

| เวลา        | หัวข้อ                                                                     |
| ----------- | -------------------------------------------------------------------------- |
| 09:30-09:45 | ทบทวน Day 2 + ตรวจความพร้อมโปรเจกต์ `edlgen_api` และ `edlgen_monitoring`  |
| 09:45-10:45 | **Module 1** Why State Management? + ProviderScope & Provider Lifecycle    |
| 10:45-12:00 | **Module 2** Provider Types พื้นฐาน (Provider / StateProvider / FutureProvider) |
| 12:00-13:00 | พักกลางวัน                                                                  |
| 13:00-14:00 | **Module 3** Consumer Patterns + ref.watch / ref.read / ref.listen         |
| 14:00-14:45 | **Module 4** @riverpod Annotation + Code Generation                        |
| 14:45-15:30 | **Module 5** เชื่อม Flutter กับ Laravel API (Dio + Token + Model)          |
| 15:30-16:30 | **🛠️ Lab วันที่ 3** เชื่อม Dashboard เข้ากับ `edlgen_api` ด้วย FutureProvider + AsyncNotifier |

---

## ✅ ทบทวน Day 2 + ตรวจความพร้อม

### เวลา 09:30-09:45 น.

ก่อนเริ่มเนื้อหาใหม่ ทบทวนสิ่งที่ทำเสร็จแล้วจาก 2 วันที่ผ่านมา และตรวจว่าทุกเครื่องพร้อมทำงานต่อ:

**สิ่งที่มีอยู่แล้วจาก Day 1 (ฝั่ง Backend):**

- Laravel 13 โปรเจกต์ `edlgen_api` พร้อม Repository Pattern และ API Versioning (`/api/v1/`)
- Authentication ด้วย Laravel Sanctum (Endpoint `POST /api/v1/login` คืน Bearer Token)
- Endpoint หลักที่จะใช้วันนี้: `GET /api/v1/dashboard/summary` และ `GET /api/v1/plants`

**สิ่งที่มีอยู่แล้วจาก Day 2 (ฝั่ง Mobile):**

- Flutter App Skeleton `edlgen_monitoring` มีหน้า Login, Dashboard (Mockup), Reports, Settings
- Navigation ครบด้วย GoRouter + Bottom Navigation
- Custom Widgets ที่จะนำมาใช้ต่อวันนี้: `StatCard`, `StatusBadge`, `AlertTile`

**ตรวจความพร้อมก่อนเริ่ม** - เปิด Terminal 2 หน้าต่าง แล้วรัน:

```bash
# หน้าต่างที่ 1 - ฝั่ง Laravel: รัน API Server
cd edlgen_api
php artisan serve
# ควรเห็น: Server running on [http://127.0.0.1:8000]

# ทดสอบด้วย curl หรือ Postman (Token จาก Day 1)
curl http://127.0.0.1:8000/api/v1/dashboard/summary -H "Accept: application/json"
```

```bash
# หน้าต่างที่ 2 - ฝั่ง Flutter: ตรวจ SDK และรันแอป
cd edlgen_monitoring
flutter --version
flutter doctor
flutter run
```

> ✅ **เกณฑ์ผ่าน:** Laravel ตอบ JSON ได้ที่ port 8000, `flutter doctor` เขียวทุกช่องที่จำเป็น, และแอป `edlgen_monitoring` รันขึ้นหน้า Dashboard (Mockup) บน Emulator หรือเครื่องจริงได้
> ⚠️ ใครที่ Endpoint ของ Day 1 ยังไม่สมบูรณ์ วิทยากรมี Starter Kit branch `day3-start` ให้ clone เพื่อเริ่มพร้อมกันได้ทันที

---

## 📚 Module 1: Why State Management? + ProviderScope & Provider Lifecycle

### เวลา 09:45-10:45 น.

> 💡 **หัวใจของ Module นี้:** State Management ไม่ใช่ "ของหรูที่ใส่เพราะใคร ๆ ก็ใช้" แต่เป็นคำตอบของปัญหาจริง 3 ข้อที่เราเจอมากับมือใน Day 2 คือ Prop-drilling, Rebuild ที่ไม่จำเป็น และโค้ดที่ทดสอบไม่ได้ - เมื่อเห็นปัญหาก่อน เราจะเข้าใจว่า Riverpod แก้อะไรให้เรา

---

### 1.1 ทบทวนปัญหาของ setState จาก Day 2

ใน Day 2 เราสร้างหน้า Dashboard ด้วย `StatefulWidget` + `setState` ซึ่ง "พอทำงานได้" กับแอปเล็ก แต่พอโปรเจกต์จริงอย่าง EDL-Gen Monitoring ที่มีหลายหน้า หลาย Widget แชร์ข้อมูลกัน ปัญหา 3 ข้อจะโผล่มาทันที:

**ปัญหาที่ 1 - Prop-drilling (ส่งข้อมูลทะลุหลายชั้น)**

สมมติค่า "โรงไฟฟ้าที่ถูกเลือก" (`selectedPlant`) ถูกเก็บไว้ที่หน้า `DashboardPage` แต่ Widget ที่ต้องใช้จริงคือ `PlantStatCard` ที่อยู่ลึกลงไป 4 ชั้น เราต้องส่งค่าผ่าน constructor ทุกชั้น ทั้งที่ชั้นกลาง ๆ ไม่ได้ใช้ค่านั้นเลย:

```
setState + ส่งค่าผ่าน constructor:          Riverpod:

DashboardPage (เก็บ selectedPlant)          DashboardPage
     │ ส่งต่อ                                     │
     ▼                                            │  (ไม่ต้องส่งอะไรเลย)
DashboardBody (ไม่ได้ใช้ แต่ต้องรับ-ส่งต่อ)        │
     │ ส่งต่อ                                     ▼
     ▼                                       PlantStatCard
PlantSection (ไม่ได้ใช้ แต่ต้องรับ-ส่งต่อ)     ref.watch(selectedPlantFilterProvider)
     │ ส่งต่อ                                 ดึงค่าตรงจาก Provider ได้ทันที
     ▼
PlantStatCard (ผู้ใช้ตัวจริง)
```

**ปัญหาที่ 2 - Rebuild ที่ไม่จำเป็น**

`setState` สั่ง rebuild ทั้ง subtree ของ Widget นั้น แม้ส่วนที่เปลี่ยนจริงจะมีนิดเดียว เช่น ผู้ใช้กดเปลี่ยน Filter โรงไฟฟ้า 1 ค่า แต่ทั้งหน้า Dashboard (กราฟ, การ์ดสรุป, รายการแจ้งเตือน) ถูกวาดใหม่หมด

**ปัญหาที่ 3 - Testability ต่ำ**

Logic ฝังอยู่ใน `State` class ของ Widget การจะทดสอบว่า "กรองโรงไฟฟ้าถูกต้องไหม" ต้องปั้น Widget ขึ้นมาทั้งต้น (Widget Test) แทนที่จะทดสอบ Logic ตรง ๆ ด้วย Unit Test สั้น ๆ

### 1.2 เปรียบเทียบโค้ด: ก่อนใช้ Riverpod (setState)

โค้ดจริงจาก Day 2 - Dashboard ที่เก็บ Filter ด้วย `setState` แล้วต้องส่งค่าลงไปหลายชั้น:

```dart
// แบบเดิม (Day 2): setState + Prop-drilling
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPlant = 'ทั้งหมด'; // State ฝังอยู่ใน Widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Dashboard')),
      body: Column(
        children: [
          // ต้องส่งทั้งค่า และ callback ลงไป
          PlantFilterBar(
            selected: selectedPlant,
            onChanged: (value) {
              setState(() => selectedPlant = value); // rebuild ทั้งหน้า!
            },
          ),
          // DashboardBody ไม่ได้ใช้ selectedPlant เอง แต่ต้องรับไว้ส่งต่อ
          Expanded(child: DashboardBody(selectedPlant: selectedPlant)),
        ],
      ),
    );
  }
}

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key, required this.selectedPlant});
  final String selectedPlant; // รับมาเพื่อ "ส่งผ่าน" เท่านั้น

  @override
  Widget build(BuildContext context) {
    return PlantSection(selectedPlant: selectedPlant); // ส่งต่ออีกชั้น...
  }
}
```

### 1.3 เปรียบเทียบโค้ด: หลังใช้ Riverpod

State ย้ายออกจาก Widget ไปอยู่ใน Provider - Widget ไหนอยากใช้ก็ `watch` เอง ไม่ต้องส่งผ่านใคร:

```dart
// แบบใหม่ (Day 3): Riverpod - State อยู่นอก Widget Tree
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ประกาศ Provider ไว้นอกคลาส เข้าถึงได้จากทุก Widget
final selectedPlantFilterProvider = StateProvider<String>((ref) {
  return 'ทั้งหมด'; // ค่าเริ่มต้น
});

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Dashboard')),
      body: const Column(
        children: [
          PlantFilterBar(),            // ไม่ต้องส่งค่า ไม่ต้องส่ง callback
          Expanded(child: DashboardBody()), // ไม่ต้องรับ-ส่งต่ออะไรเลย
        ],
      ),
    );
  }
}

class PlantFilterBar extends ConsumerWidget {
  const PlantFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPlantFilterProvider); // อ่านค่าตรง
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'ทั้งหมด', label: Text('ทั้งหมด')),
        ButtonSegment(value: 'น้ำงึม 1', label: Text('น้ำงึม 1')),
        ButtonSegment(value: 'น้ำเทิน 2', label: Text('น้ำเทิน 2')),
      ],
      selected: {selected},
      onSelectionChanged: (values) {
        // แก้ค่าผ่าน .notifier - เฉพาะ Widget ที่ watch ค่านี้เท่านั้นที่ rebuild
        ref.read(selectedPlantFilterProvider.notifier).state = values.first;
      },
    );
  }
}
```

สรุปสิ่งที่เปลี่ยนไปเป็นตาราง:

| ประเด็น                    | setState (Day 2)                          | Riverpod (Day 3)                              |
| -------------------------- | ----------------------------------------- | --------------------------------------------- |
| ที่อยู่ของ State           | ฝังใน `State` class ของ Widget            | อยู่นอก Widget Tree ใน Provider               |
| การส่งข้อมูลข้าม Widget    | Prop-drilling ผ่าน constructor หลายชั้น   | Widget ไหนต้องใช้ก็ `ref.watch()` เอง         |
| ขอบเขตการ Rebuild          | ทั้ง subtree ของ Widget ที่เรียก setState | เฉพาะ Widget ที่ `watch` ค่าที่เปลี่ยนจริง    |
| การทดสอบ Logic             | ต้องปั้น Widget Test                      | ทดสอบ Provider ตรง ๆ ด้วย Unit Test ได้       |
| Async State (loading/error) | เขียน flag `isLoading`, `error` เองทุกหน้า | `FutureProvider` ให้ `AsyncValue` ครบในตัว    |
| Override ค่าตอนทดสอบ       | ทำได้ยาก ต้อง inject เอง                  | `ProviderScope(overrides: [...])` บรรทัดเดียว |

> ✅ **ข้อสรุป:** Riverpod ไม่ได้มาแทน `setState` ทั้งหมด - State เฉพาะที่ของ Widget เดียว (เช่น สถานะเปิด/ปิด animation) ยังใช้ `setState` ได้ปกติ แต่ **State ที่ถูกแชร์ข้าม Widget หรือมาจาก API** ควรอยู่ใน Provider เสมอ

### 1.4 ติดตั้ง Riverpod 3.0 ในโปรเจกต์ edlgen_monitoring

ติดตั้ง Package ทั้งหมดที่ใช้วันนี้ (รวม Dio ที่จะใช้ใน Module 5) ด้วยคำสั่งเดียว:

```bash
cd edlgen_monitoring

# Package หลักของ Riverpod 3.0 + Annotation
flutter pub add flutter_riverpod:^3.0.0 riverpod_annotation:^3.0.0

# HTTP Client สำหรับเชื่อม Laravel API
flutter pub add dio:^5.7.0

# Dev dependencies: ตัวสร้างโค้ด + ตัวตรวจ Lint เฉพาะของ Riverpod
flutter pub add dev:build_runner:^2.4.13 dev:riverpod_generator:^3.0.0 dev:custom_lint dev:riverpod_lint:^3.0.0
```

ตรวจสอบใน `pubspec.yaml` ว่ามีรายการครบ:

```yaml
# pubspec.yaml (ส่วนที่เกี่ยวกับวันนี้)
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  dio: ^5.7.0
  go_router: ^14.6.2       # มีอยู่แล้วจาก Day 2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.13
  riverpod_generator: ^3.0.0
  custom_lint: ^0.7.0
  riverpod_lint: ^3.0.0
```

> 📌 **หมายเหตุ Riverpod 3.0:** หลักสูตรนี้ใช้ Riverpod สาย 3.x ซึ่งเป็นเวอร์ชันหลักปี 2026 - จุดเปลี่ยนสำคัญจากสาย 2.x ที่ต้องรู้คือ ฟังก์ชันที่ประกาศด้วย `@riverpod` รับพารามิเตอร์เป็น **`Ref ref`** ตรง ๆ (สาย 2.x ใช้ typedef ชื่อเฉพาะ เช่น `HelloRef`) ถ้าไปอ่านบทความเก่าแล้วเห็น `XxxRef` ให้เปลี่ยนเป็น `Ref` ได้เลย

### 1.5 ProviderScope - จุดเริ่มต้นของทุกอย่าง

`ProviderScope` คือ Widget ที่เก็บ State ของทุก Provider ในแอป ต้องครอบที่ root เสมอ - ถ้าลืม จะเจอ Exception ทันทีที่ Widget แรกพยายามอ่าน Provider:

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart'; // GoRouter จาก Day 2

void main() {
  // ครอบทั้งแอปด้วย ProviderScope - ภาชนะที่เก็บ State ของทุก Provider
  runApp(
    const ProviderScope(
      child: EdlGenApp(),
    ),
  );
}

class EdlGenApp extends ConsumerWidget {
  const EdlGenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'EDL-Gen Monitoring',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routerConfig: appRouter, // Navigation จาก Day 2 ใช้ต่อได้เลย
    );
  }
}
```

```
โครงสร้างการทำงานของ ProviderScope:

┌─────────────────────────────────────────────────┐
│ ProviderScope  (เก็บ "ตู้ State" ของทั้งแอป)      │
│  ┌───────────────────────────────────────────┐  │
│  │ MaterialApp.router                        │  │
│  │   ├─ LoginPage      ──┐                   │  │
│  │   ├─ DashboardPage  ──┼── ref.watch() ────┼──▶ อ่าน/ฟัง Provider
│  │   └─ ReportsPage    ──┘                   │  │   ตัวเดียวกันได้ทุกหน้า
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

### 1.6 Provider Lifecycle: Auto-dispose และ Keep-alive

Provider ไม่ได้อยู่ค้างในหน่วยความจำตลอดไป Riverpod จัดการวงจรชีวิตให้อัตโนมัติ:

- **Auto-dispose (ค่า default เมื่อใช้ Code Generation):** เมื่อไม่มี Widget ไหน `watch` Provider นั้นแล้ว State จะถูกทำลายทิ้ง - เหมาะกับข้อมูลเฉพาะหน้า เช่น รายละเอียดโรงไฟฟ้าที่เปิดดูแล้วปิดไป
- **Keep-alive:** State อยู่ต่อแม้ไม่มีใคร watch - เหมาะกับของที่สร้างแพงหรือใช้ทั้งแอป เช่น Dio Client, ข้อมูล Session

```dart
// Auto-dispose (default) - State หายเมื่อออกจากหน้า
@riverpod
Future<PlantDetail> plantDetail(Ref ref, int plantId) async { ... }

// Keep-alive - State อยู่ตลอดอายุแอป
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) { ... }
```

| พฤติกรรม     | Auto-dispose (default)                     | Keep-alive (`keepAlive: true`)          |
| ------------- | ------------------------------------------ | ---------------------------------------- |
| เมื่อไม่มีใคร watch | ทำลาย State ทิ้ง คืนหน่วยความจำ       | เก็บ State ไว้ต่อ                        |
| กลับเข้าหน้าเดิม | สร้างใหม่ + โหลดข้อมูลใหม่               | ได้ค่าเดิมทันที ไม่โหลดซ้ำ               |
| เหมาะกับ      | ข้อมูลเฉพาะหน้า, ผลค้นหา, หน้ารายละเอียด  | Dio/Repository, Config, Auth Session     |

> ⚠️ **ข้อควรระวัง:** อย่าใส่ `keepAlive: true` พร่ำเพรื่อ เพราะ State จะกินหน่วยความจำค้างไว้ และข้อมูลอาจ "เก่าค้าง" โดยไม่รู้ตัว - เริ่มจาก Auto-dispose ก่อนเสมอ แล้วค่อยเปลี่ยนเมื่อมีเหตุผลชัดเจน

### 1.7 Override Provider ใน Test Environment

ความสามารถที่ทำให้ Riverpod เหมาะกับงานองค์กร: ตอนทดสอบเราสามารถ "สลับไส้" Provider ตัวจริงเป็นตัวปลอม (Mock/Fake) ได้โดยไม่แก้โค้ดแอปแม้แต่บรรทัดเดียว

```dart
// test/dashboard_test.dart
void main() {
  testWidgets('Dashboard แสดงกำลังผลิตรวมจาก summary', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // สลับ Provider ตัวจริง (เรียก API) เป็นค่า Mock - ไม่ต้องมี Server
          dashboardSummaryProvider.overrideWith(
            (ref) async => DashboardSummary(
              totalPowerMw: 1250.5,
              onlinePlants: 8,
              totalPlants: 10,
              alertCount: 2,
            ),
          ),
        ],
        child: const MaterialApp(home: DashboardPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('1250.5 MW'), findsOneWidget); // ตรวจผลบนจอ
  });
}
```

> ✅ **จุดสำคัญ:** เทคนิค Override นี้จะถูกใช้จริงจังใน Day 4 (Provider Scoping & Override สำหรับ Testing) วันนี้ให้เข้าใจหลักการก่อนว่า "Provider คือจุดต่อปลั๊กที่ถอดเปลี่ยนได้"

---

## 📚 Module 2: Provider Types พื้นฐาน

### เวลา 10:45-12:00 น.

> 💡 **หัวใจของ Module นี้:** Riverpod มี Provider หลายชนิด แต่วันนี้เราโฟกัส 3 ชนิดพื้นฐานที่ครอบคลุมงานส่วนใหญ่: `Provider` สำหรับของที่ไม่เปลี่ยน, `StateProvider` สำหรับค่าง่าย ๆ ที่ UI แก้ได้, และ `FutureProvider` สำหรับดึงข้อมูลจาก API - เลือกชนิดให้ถูกงาน โค้ดจะสั้นและอ่านง่ายที่สุด

---

### 2.1 แผนที่ Provider Types ของวันนี้

| ชนิด Provider    | ใช้เมื่อ                                              | ค่าที่คืน               | ตัวอย่างใน EDL-Gen Monitoring          |
| ---------------- | ------------------------------------------------------ | ----------------------- | --------------------------------------- |
| `Provider`       | ค่าคงที่ / Singleton / ออบเจกต์ที่ไม่เปลี่ยน           | ค่าใด ๆ (อ่านอย่างเดียว) | `apiClientProvider` (Dio), `appConfigProvider` |
| `StateProvider`  | State ง่าย ๆ ที่ UI เปลี่ยนได้ (Filter/Toggle/Index)   | ค่าเดี่ยวที่แก้ตรง ๆ ได้ | `selectedPlantFilterProvider`           |
| `FutureProvider` | ดึงข้อมูล Async แบบ Read-only (เรียก API ครั้งเดียว)   | `AsyncValue<T>`         | `dashboardSummaryProvider`              |

ส่วนชนิดขั้นสูง (`NotifierProvider`, `AsyncNotifier`, `StreamProvider`, Family) จะเรียนเต็ม ๆ ใน Day 4 - วันนี้จะได้ชิม `AsyncNotifier` ใน Lab ท้ายวัน

```
เลือก Provider ชนิดไหนดี? (Decision Tree)

ข้อมูลนี้เปลี่ยนแปลงได้ไหม?
 ├─ ไม่เปลี่ยน (config, Dio, Repository)
 │        └──▶ Provider
 └─ เปลี่ยนได้
      ├─ เป็นค่า sync ง่าย ๆ ที่ UI แก้ตรง ๆ (filter, toggle)
      │        └──▶ StateProvider
      └─ เป็นข้อมูล async (มาจาก API/DB)
           ├─ อ่านอย่างเดียว ──▶ FutureProvider
           └─ ต้องแก้ไข/refresh เอง ──▶ AsyncNotifier (Lab วันนี้ + Day 4)
```

### 2.2 Provider - ค่าคงที่และ Singleton

`Provider` คืนค่าที่ "อ่านอย่างเดียว" เหมาะที่สุดกับการประกาศ Dependency กลางของแอป เช่น Dio Client ที่ทุก Repository ต้องใช้ร่วมกัน (Singleton) - นี่คือรูปแบบ Dependency Injection ฉบับ Riverpod:

```dart
// lib/core/providers/api_client_provider.dart (เขียนมือแบบดั้งเดิมก่อน)
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Singleton ของ Dio - สร้างครั้งเดียว ใช้ร่วมกันทั้งแอป
final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/v1/', // Android Emulator ชี้กลับเครื่อง host
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );
  return dio;
});

// ตัวอย่างค่าคงที่อื่น ๆ: ชื่อบริษัทที่แสดงบน AppBar ทุกหน้า
final appTitleProvider = Provider<String>((ref) {
  return 'EDL-Gen Monitoring';
});
```

จุดเด่นของการประกาศ Dio ผ่าน `Provider` แทนการ `new Dio()` เองในแต่ละไฟล์:

- **Singleton จริง:** ทุกที่ที่ `ref.watch(apiClientProvider)` ได้ instance เดียวกัน ตั้งค่า Base URL/Timeout ที่เดียวจบ
- **ต่อยอดได้:** Provider อื่นเรียกใช้ต่อได้ เช่น Repository (`ref.watch(apiClientProvider)`) - Riverpod จะรู้ Dependency Graph เอง
- **Override ได้ตอนทดสอบ:** สลับเป็น Mock Dio ได้ทันทีโดยไม่แตะโค้ดจริง

> 📌 **สำคัญ:** `Provider` ไม่มี `.notifier` ให้แก้ค่า - ถ้าพบว่าตัวเองอยากแก้ค่าใน `Provider` แสดงว่าเลือกชนิดผิด ให้ไปใช้ `StateProvider` หรือ `Notifier` แทน

### 2.3 StateProvider - Filter และ Toggle

`StateProvider` เก็บค่าเดี่ยว ๆ ที่ UI แก้ไขได้ตรง ๆ เหมาะกับ Filter, Toggle, Dropdown, Tab Index - ในแอปเราคือ "Filter เลือกโรงไฟฟ้า" บนหน้า Dashboard:

```dart
// lib/features/dashboard/providers/plant_filter_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// เก็บรหัสโรงไฟฟ้าที่ถูกเลือก (null = แสดงทุกโรง)
final selectedPlantFilterProvider = StateProvider<int?>((ref) {
  return null; // ค่าเริ่มต้น: ไม่กรอง
});

// Toggle เปิด/ปิดการแจ้งเตือนบนหน้า Settings
final alertEnabledProvider = StateProvider<bool>((ref) {
  return true;
});
```

การอ่านและแก้ค่าจาก UI:

```dart
class PlantFilterChips extends ConsumerWidget {
  const PlantFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedPlantFilterProvider); // ฟังค่าปัจจุบัน

    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('ทั้งหมด'),
          selected: selectedId == null,
          // แก้ค่า: เซ็ต state ผ่าน .notifier ใน callback (ใช้ read ไม่ใช่ watch)
          onSelected: (_) =>
              ref.read(selectedPlantFilterProvider.notifier).state = null,
        ),
        FilterChip(
          label: const Text('น้ำงึม 1'),
          selected: selectedId == 1,
          onSelected: (_) =>
              ref.read(selectedPlantFilterProvider.notifier).state = 1,
        ),
        FilterChip(
          label: const Text('น้ำเทิน 2'),
          selected: selectedId == 2,
          onSelected: (_) =>
              ref.read(selectedPlantFilterProvider.notifier).state = 2,
        ),
      ],
    );
  }
}
```

> 💡 **ทิศทางปี 2026:** ทีม Riverpod แนะนำว่า State ที่เริ่มมี Logic (validate, คำนวณ, หลาย field) ควร "โต" ไปเป็น `Notifier` class (จะเรียนใน Module 4 และ Day 4) - `StateProvider` เหมาะกับค่าง่าย ๆ ที่ไม่มีเงื่อนไขจริง ๆ เท่านั้น เช่น Filter/Toggle แบบข้างบน

### 2.4 FutureProvider - API Call แบบ Read-only

`FutureProvider` คือพระเอกของวันนี้ - ห่อการเรียก API ให้กลายเป็น `AsyncValue<T>` ที่มีสถานะ loading/data/error ครบในตัว โดยเราไม่ต้องเขียน flag `isLoading` หรือ try-catch ใน Widget เองเลย:

```dart
// lib/features/dashboard/providers/dashboard_summary_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ดึงข้อมูลสรุป Dashboard จาก Laravel API (อ่านอย่างเดียว)
final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final dio = ref.watch(apiClientProvider); // ใช้ Dio Singleton จากหัวข้อ 2.2
  final response = await dio.get('dashboard/summary');
  return DashboardSummary.fromJson(response.data['data']);
});
```

ฝั่ง UI ใช้ `.when()` แตกทั้ง 3 สถานะ:

```dart
class SummarySection extends ConsumerWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSummary = ref.watch(dashboardSummaryProvider);

    return asyncSummary.when(
      loading: () => const CircularProgressIndicator(),      // กำลังโหลด
      error: (error, stack) => Text('เกิดข้อผิดพลาด: $error'), // ล้มเหลว
      data: (summary) => StatCard(                            // สำเร็จ
        title: 'กำลังผลิตรวม',
        value: '${summary.totalPowerMw} MW',
      ),
    );
  }
}
```

```
วงจรสถานะของ FutureProvider (AsyncValue):

   ref.watch ครั้งแรก
        │
        ▼
  ┌───────────┐   สำเร็จ    ┌────────────┐
  │  loading  │ ──────────▶ │    data    │──▶ ref.invalidate() แล้วเริ่มใหม่
  │ (spinner) │             │ (แสดงผล)   │
  └───────────┘             └────────────┘
        │
        │ throw / Exception
        ▼
  ┌───────────┐
  │   error   │──▶ กดปุ่ม Retry -> ref.invalidate() -> กลับไป loading
  └───────────┘
```

การสั่งโหลดใหม่ (Refresh) ทำได้ 2 วิธี:

```dart
// วิธีที่ 1: invalidate - สั่งให้ Provider สร้างค่าใหม่ (นิยมใช้กับ Pull-to-refresh)
ref.invalidate(dashboardSummaryProvider);

// วิธีที่ 2: refresh - invalidate แล้วคืน Future ใหม่ให้รอได้ทันที
await ref.refresh(dashboardSummaryProvider.future);
```

> ⚠️ **ข้อจำกัดของ FutureProvider:** เหมาะกับข้อมูล "อ่านอย่างเดียว" - ถ้าต้องมี Method แก้ไขข้อมูล (เพิ่ม/ลบ/อัปเดต แล้วอัปเดต State ตาม) ให้ใช้ `AsyncNotifier` ซึ่งเราจะใช้จริงใน Lab ท้ายวันนี้ และเรียนลึกใน Day 4

---

### 🧪 Lab 2.1 - Provider 3 ชนิดแรกในแอป edlgen_monitoring

> **เป้าหมาย:** พิสูจน์ว่า `ProviderScope` ทำงาน และใช้ Provider ทั้ง 3 ชนิดร่วมกันบนหน้าจอเดียว (ยังใช้ข้อมูลจำลอง - จะต่อ API จริงใน Module 5)

**ขั้นที่ 1** - สร้างไฟล์ `lib/labs/lab21_providers.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// (1) Provider - ค่าคงที่
final plantNamesProvider = Provider<List<String>>((ref) {
  return ['น้ำงึม 1', 'น้ำเทิน 2', 'ห้วยเหาะ', 'น้ำลิก 1'];
});

// (2) StateProvider - index โรงที่เลือก
final selectedIndexProvider = StateProvider<int>((ref) => 0);

// (3) FutureProvider - จำลองดึงกำลังผลิตของโรงที่เลือก (หน่วง 1 วินาที)
final powerOutputProvider = FutureProvider<double>((ref) async {
  final index = ref.watch(selectedIndexProvider); // provider ซ้อน provider ได้!
  await Future<void>.delayed(const Duration(seconds: 1));
  return [155.0, 620.5, 152.1, 64.7][index]; // ข้อมูลจำลอง (MW)
});

class Lab21Page extends ConsumerWidget {
  const Lab21Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plants = ref.watch(plantNamesProvider);
    final selected = ref.watch(selectedIndexProvider);
    final asyncPower = ref.watch(powerOutputProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2.1 - Provider Types')),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: List.generate(plants.length, (i) {
              return ChoiceChip(
                label: Text(plants[i]),
                selected: selected == i,
                onSelected: (_) =>
                    ref.read(selectedIndexProvider.notifier).state = i,
              );
            }),
          ),
          const SizedBox(height: 24),
          asyncPower.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('ผิดพลาด: $e'),
            data: (mw) => Text('กำลังผลิต: $mw MW',
                style: const TextStyle(fontSize: 28)),
          ),
        ],
      ),
    );
  }
}
```

**ขั้นที่ 2** - ตั้ง `Lab21Page` เป็นหน้าแรกชั่วคราว แล้ว `flutter run`

> ✅ **ผลลัพธ์ที่คาดหวัง:** กดเลือกโรงไฟฟ้าใดก็ตาม จะเห็น spinner ประมาณ 1 วินาที แล้วตัวเลข MW เปลี่ยนตามโรงที่เลือก - สังเกตว่า `powerOutputProvider` **watch** `selectedIndexProvider` อยู่ พอ Filter เปลี่ยน Future จะถูกคำนวณใหม่อัตโนมัติ นี่คือพลังของ "Provider พึ่งพา Provider" ที่ setState ทำให้ไม่ได้

---

## 📚 Module 3: Consumer Patterns + ref.watch / ref.read / ref.listen

### เวลา 13:00-14:00 น.

> 💡 **หัวใจของ Module นี้:** การประกาศ Provider เป็นเพียงครึ่งเดียวของเรื่อง อีกครึ่งคือการ "บริโภค" State ให้ถูกวิธี - กุญแจอยู่ที่การเลือก `ref.watch`, `ref.read`, `ref.listen` ให้ถูกสถานการณ์ เพราะการใช้ผิดคือต้นเหตุอันดับหนึ่งของบั๊ก Rebuild และปัญหา Performance ใน Flutter + Riverpod

---

### 3.1 ConsumerWidget - Widget ที่อ่าน Provider ได้

แทนที่จะใช้ `StatelessWidget` ให้เปลี่ยนเป็น `ConsumerWidget` ซึ่งเพิ่มพารามิเตอร์ `WidgetRef ref` เข้ามาในเมธอด `build` - `ref` คือ "บัตรผ่าน" สำหรับเข้าถึงทุก Provider:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// เดิม: class DashboardPage extends StatelessWidget
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  // เดิม: Widget build(BuildContext context)
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appTitleProvider); // เข้าถึง Provider ได้แล้ว
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const SummarySection(),
    );
  }
}
```

สรุปการ "แปลงร่าง" จาก Widget ธรรมดา:

| แบบเดิม (Day 2)                 | แบบใหม่ (Day 3)                                  | ใช้เมื่อ                                  |
| -------------------------------- | ------------------------------------------------- | ------------------------------------------ |
| `StatelessWidget`                | `ConsumerWidget`                                  | Widget ไม่มี State ของตัวเอง แต่ต้องอ่าน Provider |
| `StatefulWidget` + `State`       | `ConsumerStatefulWidget` + `ConsumerState`        | Widget มี Controller/initState/dispose + ต้องอ่าน Provider |
| `StatelessWidget` (บางจุดในหน้า) | ครอบเฉพาะจุดด้วย `Consumer(builder: ...)`         | อยาก rebuild เฉพาะส่วนเล็ก ๆ ของหน้าใหญ่   |

### 3.2 ConsumerStatefulWidget - เมื่อ Widget ต้องมีชีวิตของตัวเอง

ถ้า Widget ต้องมี `initState`, `dispose` หรือถือ Controller (เช่น `TextEditingController`, `ScrollController`) ให้ใช้ `ConsumerStatefulWidget` - ข้อดีคือเข้าถึง `ref` ได้จากทุก Lifecycle Method ไม่เฉพาะใน `build`:

```dart
// ช่องค้นหาโรงไฟฟ้าบนหน้า Reports
class PlantSearchBox extends ConsumerStatefulWidget {
  const PlantSearchBox({super.key});

  @override
  ConsumerState<PlantSearchBox> createState() => _PlantSearchBoxState();
}

class _PlantSearchBoxState extends ConsumerState<PlantSearchBox> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // เข้าถึง ref ใน initState ได้ - แต่ห้ามใช้ watch ที่นี่ ให้ใช้ read
    _controller.text = ref.read(searchKeywordProvider);
  }

  @override
  void dispose() {
    _controller.dispose(); // คืนหน่วยความจำเสมอ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ใน ConsumerState ใช้ ref ได้เลย ไม่ต้องรับเป็นพารามิเตอร์
    return TextField(
      controller: _controller,
      onChanged: (value) =>
          ref.read(searchKeywordProvider.notifier).state = value,
      decoration: const InputDecoration(
        hintText: 'ค้นหาโรงไฟฟ้า...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
```

> 📌 **กฎการเลือก:** เริ่มจาก `ConsumerWidget` ก่อนเสมอ - อัปเกรดเป็น `ConsumerStatefulWidget` เฉพาะเมื่อจำเป็นต้องใช้ Lifecycle หรือ Controller จริง ๆ ยิ่ง Widget เป็น Stateless ได้มากเท่าไร แอปยิ่งคาดเดาง่ายเท่านั้น

### 3.3 ref.watch vs ref.read vs ref.listen - หัวใจที่สุดของวันนี้

สามเมธอดนี้หน้าตาคล้ายกัน แต่พฤติกรรมต่างกันสิ้นเชิง ต้องแยกให้ออกก่อนออกจากห้องวันนี้:

| เมธอด          | ความหมาย                                            | Rebuild UI? | ใช้ที่ไหน                       | ตัวอย่างใน EDL-Gen                          |
| -------------- | ---------------------------------------------------- | ----------- | -------------------------------- | -------------------------------------------- |
| `ref.watch()`  | "ฟัง" ค่า - UI อัปเดตอัตโนมัติเมื่อค่าเปลี่ยน        | ✅ ใช่      | ใน `build()` เท่านั้น            | แสดงตัวเลข MW บน StatCard                    |
| `ref.read()`   | อ่านค่า/เรียกเมธอด "ครั้งเดียว" ไม่ subscribe        | ❌ ไม่      | ใน callback (onPressed ฯลฯ)      | กดปุ่มแล้วเปลี่ยนค่า Filter                  |
| `ref.listen()` | ทำ side effect เมื่อค่าเปลี่ยน (SnackBar, นำทาง, Log) | ❌ ไม่      | ใน `build()` (ประกาศการฟังไว้)   | เด้ง Error Banner เมื่อโหลด Dashboard ล้มเหลว |

```
ภาพเปรียบเทียบพฤติกรรม:

 Provider ค่าเปลี่ยน: 10 ─▶ 20 ─▶ 30

 ref.watch()   ▶ build ใหม่ทุกครั้ง     [10] [20] [30]  (UI ตามค่าตลอด)
 ref.read()    ▶ ได้ค่า ณ วินาทีที่เรียก  [10]            (แล้วจบ ไม่รู้ว่าเปลี่ยน)
 ref.listen()  ▶ callback ทุกครั้งที่เปลี่ยน  (prev,next)=(10,20),(20,30)
                 แต่ไม่ build ใหม่ - เอาไว้ทำ side effect
```

ตัวอย่างที่ใช้ครบทั้งสามตัวในหน้าเดียว - หน้า Dashboard ของเราเอง:

```dart
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // (1) listen - side effect: ถ้าโหลด summary ล้มเหลว ให้เด้ง SnackBar
    ref.listen<AsyncValue<DashboardSummary>>(dashboardSummaryProvider,
        (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('โหลดข้อมูลไม่สำเร็จ กรุณาลองใหม่')),
        );
      }
    });

    // (2) watch - ฟังค่าเพื่อแสดงผล (rebuild เมื่อเปลี่ยน)
    final asyncSummary = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Dashboard')),
      body: asyncSummary.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('ผิดพลาด: $e')),
        data: (summary) => Text('กำลังผลิตรวม ${summary.totalPowerMw} MW'),
      ),
      floatingActionButton: FloatingActionButton(
        // (3) read - เรียกครั้งเดียวใน callback: สั่งโหลดข้อมูลใหม่
        onPressed: () => ref.invalidate(dashboardSummaryProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### 3.4 Anti-patterns ที่ต้องหลีกเลี่ยง

รวมท่าผิดที่พบบ่อยที่สุดในสนามจริง พร้อมโค้ดถูก/ผิดเทียบกันชัด ๆ:

**Anti-pattern 1 - ใช้ `watch` ใน callback**

```dart
// ❌ ผิด: watch ใน onPressed - พฤติกรรมผิดเพี้ยน และ riverpod_lint จะเตือนทันที
ElevatedButton(
  onPressed: () {
    final filter = ref.watch(selectedPlantFilterProvider); // ห้าม!
    print(filter);
  },
  child: const Text('ตรวจ Filter'),
)

// ✅ ถูก: ใน callback ใช้ read เสมอ
ElevatedButton(
  onPressed: () {
    final filter = ref.read(selectedPlantFilterProvider);
    print(filter);
  },
  child: const Text('ตรวจ Filter'),
)
```

**Anti-pattern 2 - ใช้ `read` ใน build เพื่อแสดงผล**

```dart
// ❌ ผิด: read ใน build - ค่าเปลี่ยนแล้วจอไม่อัปเดต (บั๊กเงียบที่หายากมาก)
@override
Widget build(BuildContext context, WidgetRef ref) {
  final mw = ref.read(powerOutputProvider); // จอค้างค่าเดิมตลอด!
  ...
}

// ✅ ถูก: แสดงผลต้อง watch เท่านั้น
@override
Widget build(BuildContext context, WidgetRef ref) {
  final mw = ref.watch(powerOutputProvider);
  ...
}
```

**Anti-pattern 3 - watch ทั้งออบเจกต์ ทั้งที่ใช้ field เดียว**

```dart
// ❌ ไม่แนะนำ: watch ทั้ง summary - field ไหนเปลี่ยนก็ rebuild หมด
final summary = ref.watch(dashboardSummaryProvider).value;
final alertCount = summary?.alertCount;

// ✅ ดีกว่า: ใช้ select() ฟังเฉพาะ field ที่ใช้ - rebuild เมื่อ alertCount เปลี่ยนเท่านั้น
final alertCount = ref.watch(
  dashboardSummaryProvider.select((async) => async.value?.alertCount),
);
```

**Anti-pattern 4 - ทำ side effect ใน watch/build**

```dart
// ❌ ผิด: เด้ง SnackBar กลางเมธอด build - จะเด้งซ้ำทุกครั้งที่ rebuild
if (asyncSummary.hasError) {
  ScaffoldMessenger.of(context).showSnackBar(...); // ห้าม!
}

// ✅ ถูก: side effect ทั้งหมด (SnackBar, Dialog, นำทาง) ให้ทำใน ref.listen
ref.listen(dashboardSummaryProvider, (prev, next) {
  if (next.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(...);
  }
});
```

> ⚠️ **กฎทองประจำวัน (ท่องให้ขึ้นใจ):**
> - แสดงผลใน `build()` -> `watch`
> - เรียกเมธอด/อ่านครั้งเดียวใน callback -> `read`
> - Side effect (SnackBar/นำทาง/Log) -> `listen`
> - ติดตั้ง `riverpod_lint` แล้ว IDE จะช่วยจับท่าผิดเหล่านี้ให้อัตโนมัติ

---

### 🧪 Lab 3.1 - watch + read + listen ครบในหน้าเดียว

> **เป้าหมาย:** เห็นความต่างของสามเมธอดด้วยตาตัวเอง ผ่านหน้าจำลอง "เฝ้าระวังความถี่ระบบไฟฟ้า" (ค่าปกติ 50 Hz ถ้าหลุดช่วงต้องแจ้งเตือน)

**ขั้นที่ 1** - สร้างไฟล์ `lib/labs/lab31_watch_read_listen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ค่าความถี่ระบบ (จำลอง) - ผู้เรียนกดปุ่มเพื่อขยับค่า
final frequencyProvider = StateProvider<double>((ref) => 50.0);

class Lab31Page extends ConsumerWidget {
  const Lab31Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen: ถ้าความถี่หลุดช่วง 49.5-50.5 Hz ให้เด้งเตือน (side effect)
    ref.listen<double>(frequencyProvider, (prev, next) {
      if (next < 49.5 || next > 50.5) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('⚠️ ความถี่ผิดปกติ: $next Hz'),
          ),
        );
      }
    });

    // watch: แสดงค่าปัจจุบัน (rebuild เมื่อเปลี่ยน)
    final hz = ref.watch(frequencyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 3.1 - Frequency Monitor')),
      body: Center(
        child: Text('${hz.toStringAsFixed(1)} Hz',
            style: const TextStyle(fontSize: 56)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'down',
            // read: เรียกใน callback เท่านั้น
            onPressed: () =>
                ref.read(frequencyProvider.notifier).state = hz - 0.3,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'up',
            onPressed: () =>
                ref.read(frequencyProvider.notifier).state = hz + 0.3,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
```

**ขั้นที่ 2** - รันแล้วกดปุ่ม +/- ไปเรื่อย ๆ

> ✅ **ผลลัพธ์ที่คาดหวัง:** ตัวเลข Hz กลางจอเปลี่ยนทันทีทุกครั้งที่กด (มาจาก `watch`) และเมื่อค่าต่ำกว่า 49.5 หรือเกิน 50.5 จะมี SnackBar สีแดงเด้งขึ้น (มาจาก `listen`) - ทดลองเปลี่ยน `ref.read` ในปุ่มเป็น `ref.watch` แล้วดู warning ของ `riverpod_lint` เพื่อยืนยันว่า Lint ช่วยจับท่าผิดให้จริง

---

## 📚 Module 4: @riverpod Annotation + Code Generation

### เวลา 14:00-14:45 น.

> 💡 **หัวใจของ Module นี้:** การเขียน Provider ด้วยมือ (แบบ Module 2) ใช้งานได้ แต่มาตรฐานทีมปี 2026 คือประกาศด้วย `@riverpod` แล้วให้ `riverpod_generator` สร้างส่วนที่เหลือ - ได้ Type-safety เต็มรูปแบบ, Auto-dispose เป็นค่าเริ่มต้น, และลด Boilerplate ลงมาก โค้ดทั้งหมดตั้งแต่ Module 5 และ Lab จะใช้แนวทางนี้

---

### 4.1 ทำไมต้อง Code Generation

| ประเด็น                       | เขียนมือ (Manual)                          | Code Generation (`@riverpod`)                |
| ------------------------------ | ------------------------------------------- | --------------------------------------------- |
| ระบุชนิด Provider เอง          | ต้องเลือกเอง (Provider/Future/Notifier...) | Generator เลือกให้จาก Return Type อัตโนมัติ   |
| Type Safety                    | พิมพ์ Generic ผิดได้ รู้ตอน Runtime         | Compile-safe รู้ตั้งแต่ยังไม่รัน              |
| Auto-dispose                   | ต้องจำใส่ `.autoDispose` เอง                | เป็นค่าเริ่มต้นให้เลย                          |
| Provider แบบรับพารามิเตอร์     | ต้องใช้ `.family` ซ้อน syntax อ่านยาก       | ประกาศเป็นพารามิเตอร์ฟังก์ชันธรรมดา           |
| ปริมาณโค้ด                     | ยาว โดยเฉพาะ Notifier                       | สั้นลงชัดเจน เหลือแต่ Logic จริง              |

### 4.2 โครงสร้างไฟล์ที่ใช้ @riverpod

ทุกไฟล์ที่ใช้ `@riverpod` ต้องมี 3 องค์ประกอบนี้เสมอ:

```dart
// lib/core/providers/api_client_provider.dart (เวอร์ชัน Code Generation)

// (1) import annotation
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// (2) part directive - ชี้ไปไฟล์ .g.dart ที่ build_runner จะสร้างให้
//     ชื่อต้องตรงกับชื่อไฟล์นี้เป๊ะ ๆ ห้ามลืมเด็ดขาด!
part 'api_client_provider.g.dart';

// (3) ฟังก์ชัน/คลาสที่แปะ @riverpod
//     ⭐ Riverpod 3.x: พารามิเตอร์แรกเป็น "Ref ref" ตรง ๆ
//     (สาย 2.x เดิมใช้ typedef ชื่อเฉพาะ เช่น ApiClientRef - เลิกใช้แล้ว)
@Riverpod(keepAlive: true) // Dio เป็น Singleton ทั้งแอป จึงปิด auto-dispose
Dio apiClient(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );
}
// generator จะสร้าง "apiClientProvider" ให้ในไฟล์ .g.dart
// ชื่อ Provider = ชื่อฟังก์ชัน + คำว่า Provider เสมอ
```

จากนั้นสั่งสร้างโค้ด:

```bash
# สร้างครั้งเดียว
dart run build_runner build --delete-conflicting-outputs

# หรือเปิดโหมดเฝ้าดู - สร้างใหม่อัตโนมัติทุกครั้งที่กด Save (แนะนำระหว่างทำ Lab)
dart run build_runner watch --delete-conflicting-outputs
```

```
วงจรการทำงานของ Code Generation:

 เราเขียน                    build_runner                 เราใช้งาน
┌──────────────────────┐    ┌───────────────────┐    ┌─────────────────────────┐
│ api_client_provider  │    │ riverpod_generator │    │ ref.watch(               │
│ .dart                │───▶│ อ่าน @riverpod     │───▶│   apiClientProvider)     │
│  @riverpod           │    │ สร้างไฟล์ .g.dart  │    │ (type-safe, autocomplete)│
│  Dio apiClient(Ref r)│    │                   │    │                          │
└──────────────────────┘    └───────────────────┘    └─────────────────────────┘
        ▲                                                        │
        └──────────── แก้โค้ด -> Save -> watch สร้างใหม่ ◀───────┘
```

### 4.3 เทียบโค้ดมือ vs @riverpod ทั้ง 3 ชนิดที่เรียนเช้านี้

**Provider (ค่าคงที่/Singleton):**

```dart
// เขียนมือ
final appTitleProvider = Provider<String>((ref) => 'EDL-Gen Monitoring');

// Code Generation - generator เห็นว่าคืน String ธรรมดา จึงสร้าง Provider ให้
@riverpod
String appTitle(Ref ref) => 'EDL-Gen Monitoring';
```

**StateProvider (Filter/Toggle) - แนวทางใหม่คือเขียนเป็น Notifier class:**

```dart
// เขียนมือ (แบบเก่า)
final selectedPlantFilterProvider = StateProvider<int?>((ref) => null);

// Code Generation - เขียนเป็นคลาส Notifier ขนาดจิ๋ว ชัดเจนกว่าและทดสอบง่ายกว่า
@riverpod
class SelectedPlantFilter extends _$SelectedPlantFilter {
  @override
  int? build() => null; // ค่าเริ่มต้น: ไม่กรอง

  void select(int? plantId) => state = plantId;
  void clear() => state = null;
}
// ใช้งาน: ref.watch(selectedPlantFilterProvider)
//         ref.read(selectedPlantFilterProvider.notifier).select(2)
```

**FutureProvider (API Call แบบ Read-only):**

```dart
// เขียนมือ
final dashboardSummaryProvider =
    FutureProvider<DashboardSummary>((ref) async { ... });

// Code Generation - คืน Future<T> generator จึงสร้าง FutureProvider ให้
@riverpod
Future<DashboardSummary> dashboardSummary(Ref ref) async {
  final dio = ref.watch(apiClientProvider);
  final response = await dio.get('dashboard/summary');
  return DashboardSummary.fromJson(response.data['data']);
}
```

**โบนัส - Provider รับพารามิเตอร์ (แทน .family):**

```dart
// อยากได้รายละเอียดโรงไฟฟ้ารายตัว? แค่เพิ่มพารามิเตอร์ต่อจาก ref
@riverpod
Future<PowerPlant> plantDetail(Ref ref, int plantId) async {
  final dio = ref.watch(apiClientProvider);
  final response = await dio.get('plants/$plantId');
  return PowerPlant.fromJson(response.data['data']);
}
// ใช้งาน: ref.watch(plantDetailProvider(3)) - type-safe ทั้งเส้นทาง
```

> ⚠️ **ข้อผิดพลาดยอดฮิตกับ build_runner:**
> 1. ลืมบรรทัด `part 'ชื่อไฟล์.g.dart';` -> generator ไม่สร้างไฟล์ให้ และ error หา `_$...` ไม่เจอ
> 2. ตั้งชื่อ part ไม่ตรงชื่อไฟล์จริง -> error เหมือนข้อ 1
> 3. แก้โค้ดแล้วลืมรัน build_runner (และไม่ได้เปิดโหมด watch) -> โค้ดใหม่ไม่มีผล
> 4. ไฟล์ .g.dart ขัดแย้งกัน -> รันด้วย `--delete-conflicting-outputs` เสมอ
> 5. อย่าแก้ไฟล์ `.g.dart` ด้วยมือเด็ดขาด - มันถูกเขียนทับทุกครั้งที่ build

---

### 🧪 Lab 4.1 - แปลง Provider จาก Lab 2.1 เป็น @riverpod

> **เป้าหมาย:** ฝึกวงจร Code Generation เต็มรอบ - เขียน annotation, รัน build_runner, ใช้ Provider ที่ถูกสร้างขึ้น

**ขั้นที่ 1** - สร้างไฟล์ `lib/labs/lab41_codegen.dart` แล้วย้าย Provider ทั้งสามจาก Lab 2.1 มาเขียนแบบใหม่:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lab41_codegen.g.dart'; // ⬅ ห้ามลืม!

// (1) Provider - ค่าคงที่
@riverpod
List<String> plantNames(Ref ref) {
  return ['น้ำงึม 1', 'น้ำเทิน 2', 'ห้วยเหาะ', 'น้ำลิก 1'];
}

// (2) Notifier - แทน StateProvider เดิม
@riverpod
class SelectedIndex extends _$SelectedIndex {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

// (3) FutureProvider - จำลองดึงกำลังผลิต
@riverpod
Future<double> powerOutput(Ref ref) async {
  final index = ref.watch(selectedIndexProvider);
  await Future<void>.delayed(const Duration(seconds: 1));
  return [155.0, 620.5, 152.1, 64.7][index];
}
```

**ขั้นที่ 2** - รัน `dart run build_runner build --delete-conflicting-outputs` แล้วสังเกตไฟล์ `lab41_codegen.g.dart` โผล่ขึ้นมา

**ขั้นที่ 3** - แก้หน้า UI ของ Lab 2.1 เพียง 1 จุด: เปลี่ยนการแก้ค่า index จาก `.state = i` เป็นเรียกเมธอด

```dart
onSelected: (_) => ref.read(selectedIndexProvider.notifier).select(i),
```

> ✅ **ผลลัพธ์ที่คาดหวัง:** พฤติกรรมบนจอเหมือน Lab 2.1 ทุกประการ แต่โค้ดฝั่ง Provider สั้นลง, ปลอดภัยกว่า (compile-safe), และเป็น Auto-dispose โดยอัตโนมัติ - นับจากนี้ทุก Provider ในหลักสูตรจะเขียนด้วย `@riverpod` เท่านั้น

---

## 📚 Module 5: การเชื่อม Flutter กับ Laravel API

### เวลา 14:45-15:30 น.

> 💡 **หัวใจของ Module นี้:** จุดที่สองโปรเจกต์มาเจอกัน - เราจะตั้งค่า Dio ให้คุยกับ `edlgen_api` ได้จริง ครอบคลุม 4 เรื่องที่งานเชื่อม API ทุกงานต้องเจอ: Base URL ที่ถูกต้องตามอุปกรณ์, การแนบ Bearer Token, การแปลง JSON เป็น Dart Model และการจัดการ Error อย่างเป็นระบบ

---

### 5.1 Base URL - ทำไม localhost ใช้ไม่ได้บน Emulator

ความเข้าใจผิดอันดับหนึ่งของการเชื่อม API ครั้งแรก: บน Android Emulator คำว่า `localhost` (หรือ `127.0.0.1`) หมายถึง "ตัว Emulator เอง" ไม่ใช่เครื่องคอมพิวเตอร์ที่รัน Laravel!

```
เครื่องคอมของเรา (Host)                 Android Emulator (เครื่องเสมือนอีกเครื่อง)
┌──────────────────────────┐            ┌──────────────────────────┐
│ Laravel API              │            │ Flutter App              │
│ php artisan serve        │            │                          │
│ 127.0.0.1:8000           │◀───────────│ ต้องเรียก 10.0.2.2:8000  │
│                          │  10.0.2.2  │ (alias พิเศษที่ Emulator  │
│                          │            │  ใช้ชี้กลับมาที่ Host)    │
└──────────────────────────┘            └──────────────────────────┘
                                          ❌ ถ้าเรียก 127.0.0.1:8000
                                             = เรียกตัว Emulator เอง -> Connection refused
```

| อุปกรณ์ที่รันแอป          | Base URL ที่ต้องใช้                          | หมายเหตุ                                          |
| -------------------------- | --------------------------------------------- | -------------------------------------------------- |
| Android Emulator           | `http://10.0.2.2:8000/api/v1/`                | alias พิเศษชี้กลับ Host                            |
| iOS Simulator              | `http://127.0.0.1:8000/api/v1/`               | Simulator แชร์ network กับ Host โดยตรง             |
| เครื่องจริง (Android/iOS)  | `http://192.168.x.x:8000/api/v1/`             | ใช้ IP วง LAN ของเครื่อง Host + ต้องอยู่ Wi-Fi เดียวกัน |
| Production จริง            | `https://api.edlgen.la/api/v1/` (ตัวอย่าง)   | ต้องเป็น HTTPS เสมอ                                |

> ⚠️ **สำหรับเครื่องจริง:** ต้องรัน Laravel ให้ฟังทุก interface ด้วย `php artisan serve --host=0.0.0.0` และเปิด Firewall port 8000 ด้วย มิฉะนั้นมือถือจะต่อไม่ติดแม้ IP ถูกต้อง
> 📌 **HTTP บน Android 9+:** การเรียก `http://` (ไม่ใช่ https) ต้องประกาศ `android:usesCleartextTraffic="true"` ใน `android/app/src/main/AndroidManifest.xml` (แท็ก `<application>`) - ใช้เฉพาะตอนพัฒนาเท่านั้น ห้ามติดไปถึง Production

### 5.2 ตั้งค่า Dio Client กลางของแอป (ฉบับสมบูรณ์)

รวมทุกอย่างเป็น `apiClientProvider` ฉบับเต็มที่จะใช้จริงตลอดหลักสูตร - มี Base URL, Timeout, การแนบ Token อัตโนมัติ และ Log สำหรับ Debug:

```dart
// lib/core/network/api_client_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

// เก็บ Token ปัจจุบัน (null = ยังไม่ Login)
// Day 4 จะย้ายไปเก็บใน flutter_secure_storage ผ่าน AuthCubit
@Riverpod(keepAlive: true)
class AuthToken extends _$AuthToken {
  @override
  String? build() => null;

  void set(String token) => state = token;
  void clear() => state = null;
}

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  // Interceptor: ด่านตรวจที่ request/response ทุกตัวต้องผ่าน
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // แนบ Bearer Token อัตโนมัติทุก request (ถ้า Login แล้ว)
        final token = ref.read(authTokenProvider);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options); // ปล่อย request ไปต่อ
      },
      onError: (error, handler) {
        // 401 = Token หมดอายุ/ไม่ถูกต้อง -> ล้าง Token (Day 4 จะเพิ่ม redirect ไป Login)
        if (error.response?.statusCode == 401) {
          ref.read(authTokenProvider.notifier).clear();
        }
        handler.next(error);
      },
    ),
  );

  // Log request/response ตอน debug เท่านั้น
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  return dio;
}
```

ทดสอบ Login เพื่อให้ได้ Token จาก Sanctum (Endpoint จาก Day 1):

```dart
// lib/features/auth/data/auth_repository.dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._dio, this._ref);
  final Dio _dio;
  final Ref _ref;

  Future<void> login(String email, String password) async {
    final response = await _dio.post('login', data: {
      'email': email,
      'password': password,
      'device_name': 'edlgen_monitoring_app', // Sanctum ใช้ระบุอุปกรณ์
    });
    final token = response.data['token'] as String;
    _ref.read(authTokenProvider.notifier).set(token); // เก็บ Token เข้าระบบ
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(apiClientProvider), ref);
}
```

### 5.3 แปลง JSON เป็น Dart Model (fromJson)

Laravel API Resource ของเราคืน JSON รูปนี้ (ออกแบบไว้ตั้งแต่ Day 1):

```json
{
  "data": {
    "total_power_mw": 1250.5,
    "online_plants": 8,
    "total_plants": 10,
    "alert_count": 2,
    "updated_at": "2026-07-15T09:45:00+07:00"
  }
}
```

ฝั่ง Dart สร้าง Model ที่ Immutable พร้อม factory `fromJson` - สังเกตการแปลงชื่อ field จาก snake_case (ธรรมเนียม Laravel) เป็น camelCase (ธรรมเนียม Dart):

```dart
// lib/features/dashboard/models/dashboard_summary.dart
class DashboardSummary {
  const DashboardSummary({
    required this.totalPowerMw,
    required this.onlinePlants,
    required this.totalPlants,
    required this.alertCount,
    this.updatedAt,
  });

  final double totalPowerMw; // กำลังผลิตรวม (เมกะวัตต์)
  final int onlinePlants;    // จำนวนโรงไฟฟ้าที่ online
  final int totalPlants;     // จำนวนโรงไฟฟ้าทั้งหมด
  final int alertCount;      // จำนวนการแจ้งเตือนที่ยังไม่ปิด
  final DateTime? updatedAt; // เวลาอัปเดตล่าสุดจาก Server

  // แปลง Map (จาก JSON) -> Object
  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      // ใช้ (num).toDouble() กันเคสที่ JSON ส่งมาเป็น int (เช่น 1250)
      totalPowerMw: (json['total_power_mw'] as num).toDouble(),
      onlinePlants: json['online_plants'] as int,
      totalPlants: json['total_plants'] as int,
      alertCount: json['alert_count'] as int,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}
```

> 💡 **เขียนมือ vs Generate:** วันนี้เขียน `fromJson` ด้วยมือเพื่อให้เข้าใจกลไก - โปรเจกต์จริงที่ Model เยอะแนะนำใช้ `json_serializable` หรือ `freezed` สร้างให้อัตโนมัติ (จะใช้ใน Day 4 เมื่อ Model ซับซ้อนขึ้น)
> ⚠️ **กับดัก num vs int/double:** JSON ไม่แยก int/double - ถ้า Laravel ส่ง `1250` มาแล้วเรา cast `as double` ตรง ๆ จะได้ TypeError ตอน Runtime ให้ cast ผ่าน `as num` แล้ว `.toDouble()` เสมอสำหรับค่าที่อาจเป็นทศนิยม

### 5.4 Error Handling อย่างเป็นระบบ

Error จากการเรียก API มีหลายแบบ ต้องแยกให้ผู้ใช้เห็นข้อความที่เข้าใจได้ ไม่ใช่โยน `DioException` ดิบ ๆ ใส่หน้าจอ:

```dart
// lib/core/network/api_exception.dart
import 'package:dio/dio.dart';

// Exception กลางของแอป - ข้อความพร้อมแสดงต่อผู้ใช้ (ภาษาไทย)
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  // โรงงานแปลง DioException -> ApiException ที่อ่านรู้เรื่อง
  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException('เชื่อมต่อ Server ไม่ทัน กรุณาลองใหม่');
      case DioExceptionType.connectionError:
        return const ApiException(
            'เชื่อมต่อเครือข่ายไม่ได้ ตรวจสอบว่า Server ทำงานอยู่');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        // พยายามอ่าน message ที่ Laravel ส่งมา (เช่น validation error)
        final serverMessage = e.response?.data is Map
            ? (e.response!.data['message'] as String?)
            : null;
        return switch (code) {
          401 => const ApiException('Session หมดอายุ กรุณา Login ใหม่',
              statusCode: 401),
          403 => const ApiException('ไม่มีสิทธิ์เข้าถึงข้อมูลนี้',
              statusCode: 403),
          404 => const ApiException('ไม่พบข้อมูลที่ต้องการ', statusCode: 404),
          422 => ApiException(serverMessage ?? 'ข้อมูลไม่ถูกต้อง',
              statusCode: 422),
          >= 500 => const ApiException('Server ขัดข้อง กรุณาลองใหม่ภายหลัง',
              statusCode: 500),
          _ => ApiException(serverMessage ?? 'เกิดข้อผิดพลาด ($code)',
              statusCode: code),
        };
      default:
        return const ApiException('เกิดข้อผิดพลาดที่ไม่คาดคิด');
    }
  }

  @override
  String toString() => message; // ทำให้ Text('$error') แสดงข้อความไทยสวย ๆ
}
```

จุดที่ต้องดักคือชั้น Repository - แปลง Error ให้จบก่อนถึง Provider:

```dart
Future<DashboardSummary> fetchSummary() async {
  try {
    final response = await _dio.get('dashboard/summary');
    return DashboardSummary.fromJson(response.data['data']);
  } on DioException catch (e) {
    throw ApiException.fromDioException(e); // โยนต่อเป็นภาษาที่ UI ใช้ได้เลย
  }
}
```

```
เส้นทางของ Error ในสถาปัตยกรรมของเรา:

 Laravel API          Repository                Provider              UI
┌────────────┐   ┌──────────────────────┐   ┌───────────────┐   ┌─────────────────┐
│ 500 / 422  │──▶│ จับ DioException      │──▶│ AsyncValue    │──▶│ .when(error:)   │
│ / timeout  │   │ แปลงเป็น ApiException │   │ .error เก็บไว้ │   │ Error Banner +  │
└────────────┘   └──────────────────────┘   └───────────────┘   │ ปุ่มลองใหม่      │
                                                                └─────────────────┘
 หลักการ: UI ไม่ควรรู้จัก DioException เลย - รู้จักแค่ ApiException ที่มีข้อความพร้อมแสดง
```

> ✅ **Checklist ก่อนเข้า Lab:** (1) `php artisan serve` รันอยู่ (2) `apiClientProvider` ชี้ Base URL ถูกต้องตามอุปกรณ์ (3) Login ผ่าน Postman แล้วได้ Token (4) `build_runner watch` เปิดค้างไว้

---

## 🛠️ Lab วันที่ 3 - เชื่อม Flutter App กับ Laravel API ด้วย FutureProvider และ AsyncNotifier

### เวลา 15:30-16:30 น.

> **โจทย์:** เปลี่ยนหน้า Dashboard ของ `edlgen_monitoring` จาก Mockup Data เป็นข้อมูลจริงจาก `edlgen_api` โดยสร้าง Data Flow ครบสาย **Model -> Repository -> Provider -> UI** ประกอบด้วย (1) การ์ดสรุปจาก `FutureProvider` (2) รายการโรงไฟฟ้าจาก `AsyncNotifier` ที่กด Refresh ได้ (3) Loading Skeleton ระหว่างรอข้อมูล และ (4) Error Banner พร้อมปุ่มลองใหม่เมื่อ API ล้มเหลว

โครงสร้างไฟล์ที่จะได้เมื่อจบ Lab (Feature-first):

```
lib/
├── core/
│   └── network/
│       ├── api_client_provider.dart    ← จาก Module 5 (Dio + Token)
│       └── api_exception.dart          ← จาก Module 5 (Error กลาง)
└── features/
    └── dashboard/
        ├── models/
        │   ├── dashboard_summary.dart  ← ขั้นที่ 1
        │   └── power_plant.dart        ← ขั้นที่ 1
        ├── data/
        │   └── dashboard_repository.dart ← ขั้นที่ 2
        ├── providers/
        │   └── dashboard_providers.dart  ← ขั้นที่ 3
        └── presentation/
            ├── dashboard_page.dart       ← ขั้นที่ 4
            └── widgets/
                ├── summary_skeleton.dart ← ขั้นที่ 5
                └── error_banner.dart     ← ขั้นที่ 6
```

### ขั้นที่ 1 - สร้าง Model

`DashboardSummary` ใช้ตามที่เขียนใน Module 5 (หัวข้อ 5.3) เพิ่มอีก 1 Model คือ `PowerPlant` สำหรับรายการโรงไฟฟ้า:

```dart
// lib/features/dashboard/models/power_plant.dart
class PowerPlant {
  const PowerPlant({
    required this.id,
    required this.name,
    required this.capacityMw,
    required this.currentOutputMw,
    required this.status,
  });

  final int id;
  final String name;            // ชื่อโรงไฟฟ้า เช่น "น้ำงึม 1"
  final double capacityMw;      // กำลังผลิตติดตั้ง
  final double currentOutputMw; // กำลังผลิตปัจจุบัน
  final String status;          // online / offline / maintenance

  bool get isOnline => status == 'online';

  // เปอร์เซ็นต์การเดินเครื่อง (กันหารศูนย์)
  double get loadFactor =>
      capacityMw == 0 ? 0 : (currentOutputMw / capacityMw) * 100;

  factory PowerPlant.fromJson(Map<String, dynamic> json) {
    return PowerPlant(
      id: json['id'] as int,
      name: json['name'] as String,
      capacityMw: (json['capacity_mw'] as num).toDouble(),
      currentOutputMw: (json['current_output_mw'] as num).toDouble(),
      status: json['status'] as String,
    );
  }
}
```

### ขั้นที่ 2 - สร้าง Repository

Repository คือชั้นเดียวที่รู้จัก Dio และ URL - Provider กับ UI ไม่ต้องรู้เลยว่าข้อมูลมาจากไหน:

```dart
// lib/features/dashboard/data/dashboard_repository.dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';
import '../../../core/network/api_exception.dart';
import '../models/dashboard_summary.dart';
import '../models/power_plant.dart';

part 'dashboard_repository.g.dart';

class DashboardRepository {
  DashboardRepository(this._dio);
  final Dio _dio;

  // GET /api/v1/dashboard/summary
  Future<DashboardSummary> fetchSummary() async {
    try {
      final response = await _dio.get('dashboard/summary');
      return DashboardSummary.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // GET /api/v1/plants (กรองด้วย status ได้ เช่น ?status=online)
  Future<List<PowerPlant>> fetchPlants({String? status}) async {
    try {
      final response = await _dio.get(
        'plants',
        queryParameters: {if (status != null) 'status': status},
      );
      final items = response.data['data'] as List<dynamic>;
      return items
          .map((item) => PowerPlant.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

// Repository เป็น Singleton - ผูกกับ apiClientProvider
@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepository(ref.watch(apiClientProvider));
}
```

### ขั้นที่ 3 - สร้าง Provider (FutureProvider + AsyncNotifier)

```dart
// lib/features/dashboard/providers/dashboard_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/dashboard_repository.dart';
import '../models/dashboard_summary.dart';
import '../models/power_plant.dart';

part 'dashboard_providers.g.dart';

// (A) FutureProvider - การ์ดสรุป (อ่านอย่างเดียว refresh ด้วย invalidate)
@riverpod
Future<DashboardSummary> dashboardSummary(Ref ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.fetchSummary();
}

// (B) AsyncNotifier - รายการโรงไฟฟ้า (มีเมธอด refresh ของตัวเอง)
//     คืน Future<T> จากเมธอด build -> ได้ AsyncValue<List<PowerPlant>>
@riverpod
class PlantList extends _$PlantList {
  @override
  Future<List<PowerPlant>> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository.fetchPlants();
  }

  // Pull-to-refresh: โหลดใหม่แบบคุมสถานะเอง
  Future<void> refresh() async {
    state = const AsyncValue.loading(); // บังคับกลับสู่สถานะ loading
    // AsyncValue.guard = try-catch สำเร็จรูป: สำเร็จได้ data, พังได้ error
    state = await AsyncValue.guard(() {
      final repository = ref.read(dashboardRepositoryProvider);
      return repository.fetchPlants();
    });
  }
}
```

รัน build_runner (ถ้ายังไม่ได้เปิดโหมด watch):

```bash
dart run build_runner build --delete-conflicting-outputs
```

> 📌 **ทำไมรายการโรงไฟฟ้าใช้ AsyncNotifier แต่การ์ดสรุปใช้ FutureProvider?** การ์ดสรุปเป็นข้อมูลอ่านอย่างเดียวล้วน ๆ `FutureProvider` + `ref.invalidate` จึงพอ ส่วนรายการโรงไฟฟ้าใน Day 4 จะมี Logic เพิ่ม (filter, sort, sync) การเริ่มจาก `AsyncNotifier` วันนี้ทำให้พรุ่งนี้เพิ่มเมธอดได้เลยโดยไม่ต้องรื้อ

### ขั้นที่ 4 - ประกอบหน้า Dashboard

```dart
// lib/features/dashboard/presentation/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_summary.dart';
import '../providers/dashboard_providers.dart';
import 'widgets/error_banner.dart';
import 'widgets/summary_skeleton.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSummary = ref.watch(dashboardSummaryProvider);
    final asyncPlants = ref.watch(plantListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Dashboard')),
      body: RefreshIndicator(
        // ดึงลงเพื่อโหลดใหม่ทั้งสองส่วนพร้อมกัน
        onRefresh: () async {
          ref.invalidate(dashboardSummaryProvider);
          await ref.read(plantListProvider.notifier).refresh();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // ส่วนที่ 1: การ์ดสรุป (FutureProvider)
            asyncSummary.when(
              loading: () => const SummarySkeleton(),      // ขั้นที่ 5
              error: (error, _) => ErrorBanner(            // ขั้นที่ 6
                message: '$error',
                onRetry: () => ref.invalidate(dashboardSummaryProvider),
              ),
              data: (summary) => _SummaryCards(summary: summary),
            ),
            const SizedBox(height: 24),
            Text('โรงไฟฟ้า', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            // ส่วนที่ 2: รายการโรงไฟฟ้า (AsyncNotifier)
            asyncPlants.when(
              loading: () => const Column(
                children: [ListTileSkeleton(), ListTileSkeleton(), ListTileSkeleton()],
              ),
              error: (error, _) => ErrorBanner(
                message: '$error',
                onRetry: () => ref.read(plantListProvider.notifier).refresh(),
              ),
              data: (plants) => Column(
                children: plants.map((plant) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.bolt,
                        color: plant.isOnline ? Colors.green : Colors.grey,
                      ),
                      title: Text(plant.name),
                      subtitle: Text(
                        '${plant.currentOutputMw.toStringAsFixed(1)} / '
                        '${plant.capacityMw.toStringAsFixed(1)} MW '
                        '(${plant.loadFactor.toStringAsFixed(0)}%)',
                      ),
                      // StatusBadge = Custom Widget จาก Day 2 นำกลับมาใช้
                      trailing: StatusBadge(status: plant.status),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// การ์ดสรุป 3 ใบ - ใช้ StatCard จาก Day 2
class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.summary});
  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'กำลังผลิตรวม',
            value: '${summary.totalPowerMw.toStringAsFixed(1)} MW',
            icon: Icons.electric_bolt,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: 'โรงไฟฟ้า Online',
            value: '${summary.onlinePlants}/${summary.totalPlants}',
            icon: Icons.factory,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: 'แจ้งเตือน',
            value: '${summary.alertCount}',
            icon: Icons.warning_amber,
          ),
        ),
      ],
    );
  }
}
```

### ขั้นที่ 5 - Loading Skeleton

Skeleton ทำให้ผู้ใช้รู้ว่า "กำลังโหลด และเลย์เอาต์จะหน้าตาประมาณนี้" ดีกว่า spinner ลอย ๆ กลางจอ:

```dart
// lib/features/dashboard/presentation/widgets/summary_skeleton.dart
import 'package:flutter/material.dart';

// กล่องสีเทากะพริบ - วางแทนตำแหน่งการ์ดจริงระหว่างรอข้อมูล
class SummarySkeleton extends StatefulWidget {
  const SummarySkeleton({super.key});

  @override
  State<SummarySkeleton> createState() => _SummarySkeletonState();
}

class _SummarySkeletonState extends State<SummarySkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true); // กะพริบไป-กลับ

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      // ความโปร่งใสแกว่งระหว่าง 0.4-1.0 ให้ความรู้สึก "กำลังโหลด"
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(_controller),
      child: Row(
        children: List.generate(3, (i) {
          return Expanded(
            child: Container(
              height: 96,
              margin: EdgeInsets.only(right: i < 2 ? 12 : 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Skeleton ของแถวรายการโรงไฟฟ้า
class ListTileSkeleton extends StatelessWidget {
  const ListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
```

### ขั้นที่ 6 - Error Banner พร้อมปุ่มลองใหม่

```dart
// lib/features/dashboard/presentation/widgets/error_banner.dart
import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message, required this.onRetry});

  final String message;       // ข้อความจาก ApiException (ภาษาไทยพร้อมแสดง)
  final VoidCallback onRetry; // สั่งโหลดใหม่ (invalidate หรือ refresh)

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message,
                style: TextStyle(color: Colors.red.shade700)),
          ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('ลองใหม่'),
          ),
        ],
      ),
    );
  }
}
```

### ขั้นที่ 7 - รันและทดสอบ 4 สถานการณ์

```bash
# Terminal 1: Laravel
cd edlgen_api && php artisan serve

# Terminal 2: build_runner (เปิดค้างไว้)
cd edlgen_monitoring && dart run build_runner watch --delete-conflicting-outputs

# Terminal 3: Flutter
cd edlgen_monitoring && flutter run
```

| # | สถานการณ์ทดสอบ                                     | วิธีทำ                                             | ผลที่ต้องเห็น                                        |
| - | ---------------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------ |
| 1 | Happy Path                                           | เปิดหน้า Dashboard ตามปกติ                          | Skeleton กะพริบสั้น ๆ -> การ์ด + รายการโรงไฟฟ้าข้อมูลจริง |
| 2 | Pull-to-refresh                                      | ดึงหน้าจอลง                                         | ข้อมูลโหลดใหม่ (ดู Log ใน Terminal 1 มี request เข้า)  |
| 3 | Server ล่ม                                           | กด Ctrl+C หยุด `php artisan serve` แล้ว refresh    | Error Banner "เชื่อมต่อเครือข่ายไม่ได้..." + ปุ่มลองใหม่ |
| 4 | ฟื้นตัวจาก Error                                     | รัน `php artisan serve` ใหม่ แล้วกด "ลองใหม่"       | กลับสู่ Skeleton -> แสดงข้อมูลจริงตามเดิม               |

> ✅ **ผลลัพธ์ที่คาดหวังเมื่อจบ Lab:** Dashboard ของ `edlgen_monitoring` แสดงข้อมูลจริงจากฐานข้อมูลผ่าน `edlgen_api` ครบทั้งการ์ดสรุปและรายการโรงไฟฟ้า, มี Loading Skeleton ระหว่างรอ, มี Error Banner + ปุ่มลองใหม่เมื่อ API ล้มเหลว และ Pull-to-refresh ทำงานได้ - นี่คือ Data Flow มาตรฐาน (Model -> Repository -> Provider -> UI) ที่จะใช้กับทุก Feature ที่เหลือของหลักสูตร

**โจทย์เสริมสำหรับคนที่เสร็จก่อนเวลา (Challenge):**

1. เพิ่ม Filter สถานะโรงไฟฟ้า (ทั้งหมด/online/offline) ด้วย Notifier + ส่ง `status` เข้า `fetchPlants`
2. ใช้ `select()` กับ `dashboardSummaryProvider` ให้การ์ด "แจ้งเตือน" rebuild เฉพาะเมื่อ `alertCount` เปลี่ยน
3. แสดงเวลา `updatedAt` ใต้การ์ดสรุปในรูปแบบ "อัปเดตล่าสุด HH:mm น."

---

## 📝 สรุปประจำวันที่ 3

วันนี้เราเดินทางจาก "ปัญหา" สู่ "เครื่องมือ" สู่ "ระบบจริง" ครบหนึ่งวงจร:

1. **Why State Management:** setState สร้างปัญหา Prop-drilling, Rebuild เกินจำเป็น และทดสอบยาก - Riverpod ย้าย State ออกนอก Widget Tree ทำให้ Widget ไหนก็เข้าถึงได้ตรง ๆ ผ่าน `ref`
2. **ProviderScope & Lifecycle:** ครอบ `ProviderScope` ที่ root หนึ่งครั้งจบ, Provider เป็น Auto-dispose โดย default, ใช้ `keepAlive: true` เฉพาะ Singleton อย่าง Dio/Repository และ Override ได้ตอนทดสอบ
3. **Provider Types:** `Provider` = ค่าคงที่/Singleton, `StateProvider` (หรือ Notifier จิ๋ว) = Filter/Toggle, `FutureProvider` = API Call อ่านอย่างเดียวที่คืน `AsyncValue` ครบ loading/data/error
4. **Consumer Patterns:** `ConsumerWidget` สำหรับ Widget ทั่วไป, `ConsumerStatefulWidget` เมื่อต้องมี Controller/Lifecycle
5. **กฎทอง ref สามตัว:** แสดงผล -> `watch`, callback -> `read`, side effect -> `listen` - และเปิด `riverpod_lint` ให้ช่วยจับท่าผิด
6. **Code Generation:** `@riverpod` + `part '....g.dart'` + `build_runner watch` = Provider ที่ Type-safe, Boilerplate น้อย และใน Riverpod 3.x ฟังก์ชันรับ `Ref ref` ตรง ๆ
7. **เชื่อม Laravel API:** Android Emulator ใช้ `10.0.2.2` แทน localhost, แนบ Bearer Token ผ่าน Dio Interceptor, แปลง JSON ด้วย `fromJson` (ระวัง num/double), แปลง DioException เป็น ApiException ภาษาคน
8. **Lab:** Dashboard แสดงข้อมูลจริงด้วยสาย Model -> Repository -> Provider -> UI พร้อม Skeleton, Error Banner และ Pull-to-refresh

```
ภาพรวมสถาปัตยกรรมที่ได้หลังจบวันที่ 3:

┌─────────────────────────  Flutter (edlgen_monitoring)  ─────────────────────────┐
│                                                                                  │
│  UI (ConsumerWidget)      Providers (@riverpod)         Data                     │
│  ┌─────────────────┐      ┌──────────────────────┐      ┌────────────────────┐   │
│  │ DashboardPage   │─watch│ dashboardSummary     │─────▶│ DashboardRepository│   │
│  │  ├ StatCard     │      │ (FutureProvider)     │      │   └─ Dio           │   │
│  │  ├ Skeleton     │      │ PlantList            │      │      (apiClient)   │   │
│  │  └ ErrorBanner  │─read─│ (AsyncNotifier)      │      └─────────┬──────────┘   │
│  └─────────────────┘      └──────────────────────┘                │              │
└───────────────────────────────────────────────────────────────────┼──────────────┘
                                                     HTTP + Bearer Token
                                                                    │
                                    ┌───────────────────────────────▼───────────┐
                                    │ Laravel 13 (edlgen_api)                   │
                                    │  /api/v1/dashboard/summary  /api/v1/plants│
                                    │  Sanctum Auth + Repository Pattern (Day 1)│
                                    └────────────────────────────────────────────┘
```

---

## ✅ ตรวจสอบความพร้อมก่อนวันพรุ่งนี้ (Day 4: Advanced Riverpod + Cubit)

ก่อนกลับวันนี้ ให้ตรวจสอบรายการต่อไปนี้ - Day 4 จะต่อยอดจากโค้ดวันนี้ทันที:

- [ ] Dashboard แสดงข้อมูลจริงจาก `edlgen_api` ได้ (Lab วันที่ 3 ผ่านครบ 4 สถานการณ์ทดสอบ)
- [ ] `dart run build_runner build` ผ่านโดยไม่มี error และเข้าใจวงจร annotation -> .g.dart
- [ ] ตอบได้โดยไม่เปิดโน้ต: `watch` / `read` / `listen` ต่างกันอย่างไร และใช้ที่ไหน
- [ ] `apiClientProvider` แนบ Bearer Token อัตโนมัติผ่าน Interceptor และ Login จากแอปได้ Token จริง
- [ ] Commit โค้ดวันนี้เข้า Git (แนะนำ branch `day3-done`) เพื่อให้ rollback ได้ถ้าพรุ่งนี้ทดลองแล้วพัง
- [ ] (เตรียมของ Day 4) รัน `flutter pub add flutter_bloc flutter_secure_storage` ล่วงหน้าได้เลย - พรุ่งนี้ใช้ทำ AuthCubit
- [ ] (เตรียมของ Day 4) ตรวจว่า Docker ยังรันได้ - Day 4 มี WebSocket Server (Laravel Echo/Pusher protocol) สำหรับ Real-time Dashboard

**หัวข้อที่จะเจอใน Day 4:** `NotifierProvider` สำหรับ State หลาย field, `StreamProvider` + WebSocket Real-time, Provider Family, Offline Persistence ด้วย `riverpod_sqflite`, และการนำ **Cubit** มาคุม Enterprise Logic (AuthCubit + BlocObserver/Audit Trail)

---

## 📖 เอกสารอ้างอิงและแหล่งเรียนรู้เพิ่มเติม

**เอกสารทางการ:**

- Riverpod Documentation - https://riverpod.dev (ครอบคลุม Provider ทุกชนิด, Code Generation, Testing)
- Riverpod: Migration to 3.0 - https://riverpod.dev/docs/3.0_migration (สรุปความต่างจากสาย 2.x รวมถึงเรื่อง `Ref`)
- pub.dev/packages/flutter_riverpod - Package หลัก + ตัวอย่างการใช้งาน
- pub.dev/packages/riverpod_annotation - Annotation `@riverpod` สำหรับ Code Generation
- pub.dev/packages/riverpod_generator - ตัวสร้างโค้ด (dev dependency)
- pub.dev/packages/riverpod_lint - ชุดกฎ Lint จับ Anti-patterns (เช่น watch ใน callback)
- pub.dev/packages/dio - HTTP Client ที่ใช้ในหลักสูตร (Interceptor, Timeout, FormData)
- pub.dev/packages/build_runner - Engine ของ Code Generation

**ฝั่ง Laravel (ทบทวน Day 1):**

- Laravel Sanctum - https://laravel.com/docs/sanctum (Token-based Auth สำหรับ Mobile)
- Laravel API Resources - https://laravel.com/docs/eloquent-resources (โครง JSON ที่ Flutter นำมา fromJson)

**บทความ/แหล่งเรียนรู้เสริม:**

- Flutter Docs: Networking - https://docs.flutter.dev/data-and-backend/networking (รวมเรื่อง 10.0.2.2 และ cleartext traffic)
- Code with Andrea: Riverpod Tutorials - https://codewithandrea.com/tags/riverpod/ (ซีรีส์ Riverpod ที่ละเอียดที่สุดชุดหนึ่ง)
- AsyncValue คืออะไรและใช้อย่างไร - https://riverpod.dev/docs/essentials/side_effects

**ติดต่อผู้สอน:**

> อ.สามิตร โกยม - สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
> โทร. 02-570-8449 | มือถือ 088-807-9770
> เว็บไซต์: www.itgenius.co.th | Email: contact@itgenius.co.th
> LINE Official: @itgenius | Facebook: IT Genius Engineering

---

*เอกสารประกอบการอบรมวันที่ 3 - หลักสูตร Basic to Advanced Laravel 13 and Flutter Framework (MOB-15) สำหรับ EDL-Generation Public Company - ห้ามเผยแพร่ก่อนได้รับอนุญาต*
