# Basic to Advanced Laravel 13 & Flutter - วันที่ 4: Advanced Riverpod + Cubit สำหรับ Enterprise Logic

**หลักสูตรอบรมเชิงปฏิบัติการ: Basic to Advanced Laravel 13 and Flutter Framework (30 ชั่วโมง, 5 วัน)**
**Course ID: MOB-15 | จัดอบรมให้: EDL-Generation Public Company (EDL-Gen) ผู้ผลิตไฟฟ้ารายใหญ่ของ สปป.ลาว**
**วันที่ 4: Advanced Riverpod + Cubit สำหรับ Enterprise Logic**
วันที่: วันพฤหัสบดีที่ 16 กรกฎาคม 2569 | เวลา 09:30-16:30 น. (พักกลางวัน 12:00-13:00 น.) | Onsite Workshop ณ สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
ผู้สอน: อ.สามิตร โกยม

---

## 🎯 วัตถุประสงค์การเรียนรู้ประจำวัน

เมื่อจบการอบรมวันที่ 4 ผู้เรียนจะสามารถ:

1. สร้าง `NotifierProvider` ที่จัดการ State หลาย Field พร้อม Method เช่น filter, sort, pagination และ refresh สำหรับหน้ารายงานได้
2. เชื่อมต่อ Laravel WebSocket (Laravel Reverb + Echo Protocol) กับ Flutter ผ่าน `StreamProvider` เพื่อแสดงข้อมูลค่ากำลังผลิตแบบ Real-time ได้
3. ใช้ Provider Family สร้าง Provider ที่รับ Parameter เช่น `plantDetailProvider(id)` สำหรับ List/Detail Pattern ได้
4. ออกแบบ Offline Persistence ด้วย `riverpod_sqflite` ครอบคลุม TTL, Sync Strategy และ Conflict Resolution เมื่อกลับมา Online ได้
5. ใช้ Provider Scoping และ Override สำหรับการเขียน Test และรองรับ Multi-tenant Architecture ได้
6. เปรียบเทียบ Cubit กับ BLoC และอธิบายแนวทาง Hybrid Approach (Riverpod = Data Layer, Cubit = Business Logic) ได้
7. สร้าง `AuthCubit` จัดการ Login/Logout/Session ครบวงจร ด้วย `flutter_secure_storage`, Auto-refresh Token และ Session Timeout เชื่อมกับ Laravel Sanctum ได้
8. ติดตั้ง `BlocObserver` เพื่อ Log ทุก State Transition เป็น Audit Trail ตามมาตรฐานองค์กรได้

> **โปรเจกต์ต่อเนื่องของหลักสูตร:** เราพัฒนาแอปเดียวต่อเนื่องทั้ง 5 วันคือ **EDL-Gen Monitoring App** ประกอบด้วย Laravel Backend `edlgen_api` และ Flutter App `edlgen_monitoring` - จาก Day 3 แอปของเราเชื่อม API และแสดงข้อมูลจริงใน Dashboard แล้ว วันนี้เราจะเพิ่ม 3 ความสามารถระดับ Enterprise คือ **Real-time**, **Auth Flow** และ **Offline Mode**

---

## 🧭 กำหนดการวันที่ 4 (โดยสังเขป)

| เวลา        | หัวข้อ                                                                     |
| ----------- | -------------------------------------------------------------------------- |
| 09:30-09:45 | ทบทวน Day 3 + ตรวจความพร้อมโปรเจกต์ `edlgen_api` และ `edlgen_monitoring`  |
| 09:45-10:45 | **Module 1** NotifierProvider - Report State (filter, sort, pagination)    |
| 10:45-12:00 | **Module 2** StreamProvider + WebSocket Real-time (Laravel Reverb)         |
| 12:00-13:00 | พักกลางวัน                                                                  |
| 13:00-13:30 | **Module 3** Provider Family - List/Detail Pattern                         |
| 13:30-14:20 | **Module 4** Offline Persistence ด้วย riverpod_sqflite                     |
| 14:20-14:40 | **Module 5** Provider Scoping & Override                                   |
| 14:40-15:00 | **Module 6** Cubit vs BLoC + Hybrid Approach                               |
| 15:00-15:30 | **Module 7** AuthCubit - Login/Logout/Session + Secure Storage             |
| 15:30-15:50 | **Module 8** StatusCubit + BlocObserver (Audit Trail)                      |
| 15:50-16:30 | **🔬 Lab วันที่ 4** Real-time Dashboard + AuthCubit + Offline Cache        |

---

## ✅ ทบทวน Day 3 + ตรวจความพร้อม

### เวลา 09:30-09:45 น.

ก่อนเริ่มเนื้อหาขั้นสูงของวันนี้ ทบทวนสิ่งที่ทำสำเร็จแล้วเมื่อวาน (Day 3) และตรวจว่าโปรเจกต์ของทุกคนอยู่ในสถานะเดียวกัน:

**สิ่งที่ได้จาก Day 3 (ต้องทำงานได้แล้วทุกข้อ):**

- Flutter App `edlgen_monitoring` เชื่อมต่อ Laravel API `edlgen_api` ผ่าน `FutureProvider` และ `AsyncNotifier` ได้
- Dashboard แสดงข้อมูลโรงไฟฟ้าจริงจากตาราง `plants` และ `power_readings` พร้อม Loading Skeleton และ Error Banner
- เข้าใจความแตกต่างของ `ref.watch` / `ref.read` / `ref.listen` และใช้ `@riverpod` Code Generation เป็นแล้ว

**ตรวจความพร้อมก่อนเริ่ม** - เปิด Terminal สองหน้าต่างแล้วรัน:

```bash
# หน้าต่างที่ 1: ฝั่ง Laravel (ในโฟลเดอร์ edlgen_api)
php artisan serve
# ควรเห็น: Server running on [http://127.0.0.1:8000]

# หน้าต่างที่ 2: ฝั่ง Flutter (ในโฟลเดอร์ edlgen_monitoring)
flutter run
# ควรเห็น Dashboard แสดงข้อมูลโรงไฟฟ้าจาก API จริง
```

> ⚠️ **ถ้า Dashboard ขึ้น Error Banner:** ตรวจว่า Laravel รันอยู่, ตรวจ Base URL ใน `lib/core/network/api_client.dart` (Android Emulator ต้องใช้ `10.0.2.2` แทน `127.0.0.1`) และตรวจว่า Token จาก Day 1 ยังไม่หมดอายุ

**ภาพรวมสถาปัตยกรรมที่จะเพิ่มในวันนี้:**

```
                    EDL-Gen Monitoring App (หลังจบ Day 4)
┌──────────────────────────────────────────────────────────────────┐
│  Flutter (edlgen_monitoring)                                     │
│  ┌───────────────┐  ┌────────────────┐  ┌────────────────────┐  │
│  │ AuthCubit     │  │ Riverpod       │  │ StreamProvider     │  │
│  │ (Login/Token) │  │ Notifier/Family│  │ (Real-time)        │  │
│  └───────┬───────┘  └───────┬────────┘  └─────────┬──────────┘  │
│          │ REST             │ REST + SQLite Cache │ WebSocket   │
└──────────┼──────────────────┼─────────────────────┼─────────────┘
           ▼                  ▼                     ▼
┌──────────────────────────────────────────────────────────────────┐
│  Laravel 13 (edlgen_api)                                         │
│  Sanctum Auth ── API Resources ── Repository ── Reverb Broadcast │
│                        │                                         │
│                   MariaDB / PostgreSQL                           │
└──────────────────────────────────────────────────────────────────┘
```

---

## 📚 Module 1: NotifierProvider - State หลาย Field + Method

### เวลา 09:45-10:45 น.

> 💡 **หัวใจของ Module นี้:** State ในงานจริงไม่ใช่ค่าเดี่ยว ๆ หน้ารายงานการผลิตมีทั้งรายการข้อมูล, ตัวกรองโรงไฟฟ้า, ช่วงวันที่, การเรียงลำดับ, หน้าปัจจุบัน (pagination) และสถานะกำลังโหลดเพิ่ม - ทั้งหมดต้องอยู่ด้วยกันอย่างเป็นระเบียบใน "State Class เดียว" แล้วให้ Notifier เป็นผู้แก้ไขผ่าน Method ที่ตั้งชื่อสื่อความหมาย

---

### 1.1 ปัญหา: State หน้ารายงานมีหลายมิติ

หน้า "รายงานการผลิตรายวัน" ของ EDL-Gen ต้องรองรับพฤติกรรมผู้ใช้ดังนี้:

- กรองตามโรงไฟฟ้า (เช่น เขื่อนน้ำงึม 1, น้ำเทิน 2) และช่วงวันที่
- เรียงลำดับตามวันที่หรือตามกำลังผลิต (มาก-น้อย / น้อย-มาก)
- เลื่อนจอลงสุดแล้วโหลดหน้าถัดไปต่ออัตโนมัติ (Infinite Scroll Pagination)
- ดึงลงเพื่อรีเฟรชข้อมูลใหม่ (Pull-to-refresh)

ถ้าแยกเป็น `StateProvider` หลายตัว (filterProvider, sortProvider, pageProvider, ...) จะเกิดปัญหา State กระจัดกระจาย แก้ตัวหนึ่งแล้วต้องจำไปรีเซ็ตอีกตัว (เช่น เปลี่ยน filter แล้วต้องรีเซ็ต page กลับเป็น 1) - ทางที่ถูกต้องคือรวมเป็น **State Class เดียว + Notifier เดียว**

### 1.2 สร้าง ReportState (Immutable State Class)

```dart
// lib/features/report/domain/report_state.dart
import 'package:edlgen_monitoring/features/report/domain/daily_report.dart';

/// ทิศทางการเรียงลำดับรายงาน
enum ReportSort { dateDesc, dateAsc, outputDesc, outputAsc }

/// State ของหน้ารายงานการผลิต - รวมทุกมิติไว้ในคลาสเดียว (Immutable)
class ReportState {
  const ReportState({
    this.reports = const [],       // รายการรายงานที่โหลดมาแล้ว (สะสมทุกหน้า)
    this.plantId,                  // กรองตามโรงไฟฟ้า (null = ทุกโรง)
    this.startDate,                // วันที่เริ่มต้นของช่วงที่กรอง
    this.endDate,                  // วันที่สิ้นสุดของช่วงที่กรอง
    this.sort = ReportSort.dateDesc, // ค่าเริ่มต้น: วันที่ล่าสุดก่อน
    this.page = 1,                 // หน้าปัจจุบันที่โหลดถึง
    this.hasMore = true,           // ยังมีหน้าถัดไปให้โหลดหรือไม่
    this.isLoadingMore = false,    // กำลังโหลดหน้าถัดไปอยู่หรือไม่ (แสดง spinner ท้ายลิสต์)
  });

  final List<DailyReport> reports;
  final int? plantId;
  final DateTime? startDate;
  final DateTime? endDate;
  final ReportSort sort;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  /// สร้าง State ใหม่โดยเปลี่ยนเฉพาะ Field ที่ระบุ (หัวใจของ Immutable State)
  ReportState copyWith({
    List<DailyReport>? reports,
    int? Function()? plantId,   // ใช้ Function เพื่อให้ set ค่ากลับเป็น null ได้
    DateTime? Function()? startDate,
    DateTime? Function()? endDate,
    ReportSort? sort,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ReportState(
      reports: reports ?? this.reports,
      plantId: plantId != null ? plantId() : this.plantId,
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      sort: sort ?? this.sort,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
```

> 📌 **สังเกตเทคนิค `int? Function()? plantId`:** ถ้าประกาศ `copyWith({int? plantId})` ตรง ๆ จะไม่สามารถ "ล้าง filter กลับเป็น null" ได้ เพราะการส่ง null จะถูกตีความว่า "ไม่เปลี่ยนค่า" - การห่อด้วย Function ทำให้แยกสองกรณีนี้ออกจากกันได้ (ในโปรเจกต์จริงอาจใช้ `freezed` ที่จัดการเรื่องนี้ให้อัตโนมัติ)

### 1.3 สร้าง ReportNotifier ด้วย @riverpod (AsyncNotifier + State หลาย Field)

เนื่องจากการโหลดรายงานเป็นงาน Async เราจะห่อ `ReportState` ด้วย `AsyncValue` โดยประกาศเป็นคลาส `@riverpod` ที่ `build()` คืน `Future<ReportState>` - Riverpod 3.0 จะสร้าง `AsyncNotifierProvider` ให้อัตโนมัติ

```dart
// lib/features/report/application/report_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:edlgen_monitoring/features/report/data/report_repository.dart';
import 'package:edlgen_monitoring/features/report/domain/report_state.dart';

part 'report_notifier.g.dart';

@riverpod
class ReportList extends _$ReportList {
  static const _pageSize = 20; // จำนวนรายการต่อหน้า (ตรงกับ per_page ฝั่ง Laravel)

  @override
  Future<ReportState> build() async {
    // โหลดหน้าแรกด้วยค่าเริ่มต้น (ไม่มี filter, เรียงวันที่ล่าสุดก่อน)
    return _fetchPage(const ReportState());
  }

  /// Helper กลาง: ดึงข้อมูล 1 หน้าจาก API ตามเงื่อนไขใน state ที่ส่งเข้ามา
  Future<ReportState> _fetchPage(ReportState current) async {
    final repo = ref.read(reportRepositoryProvider);
    final items = await repo.fetchReports(
      plantId: current.plantId,
      startDate: current.startDate,
      endDate: current.endDate,
      sort: current.sort,
      page: current.page,
      perPage: _pageSize,
    );
    return current.copyWith(
      // หน้าแรก = แทนที่ทั้งหมด, หน้าถัดไป = ต่อท้ายของเดิม
      reports: current.page == 1 ? items : [...current.reports, ...items],
      hasMore: items.length == _pageSize, // ได้มาไม่ครบหน้า = หมดแล้ว
      isLoadingMore: false,
    );
  }

  /// เปลี่ยนตัวกรองโรงไฟฟ้า/ช่วงวันที่ - ต้องรีเซ็ตกลับหน้า 1 เสมอ
  Future<void> setFilter({
    int? plantId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final current = state.valueOrNull ?? const ReportState();
    state = const AsyncLoading(); // ให้ UI แสดง Loading ระหว่างกรองใหม่
    state = await AsyncValue.guard(() => _fetchPage(current.copyWith(
          plantId: () => plantId,
          startDate: () => startDate,
          endDate: () => endDate,
          page: 1,          // กติกาสำคัญ: เปลี่ยน filter ต้องกลับหน้า 1
          hasMore: true,
        )));
  }

  /// เปลี่ยนการเรียงลำดับ - รีเซ็ตหน้า 1 เช่นกัน
  Future<void> setSort(ReportSort sort) async {
    final current = state.valueOrNull ?? const ReportState();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetchPage(current.copyWith(sort: sort, page: 1, hasMore: true)),
    );
  }

  /// โหลดหน้าถัดไป (เรียกเมื่อผู้ใช้เลื่อนใกล้ท้ายลิสต์)
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    // กันเรียกซ้ำ: ไม่มีข้อมูลแล้ว หรือกำลังโหลดอยู่ ให้ออกทันที
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    // อัปเดตธง isLoadingMore ก่อน เพื่อให้ท้ายลิสต์แสดง spinner
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await _fetchPage(current.copyWith(page: current.page + 1));
      state = AsyncData(next);
    } catch (e, st) {
      // โหลดหน้าถัดไปพลาด: คง state เดิมไว้ แค่ปิด spinner (ไม่ทำให้ทั้งจอ error)
      state = AsyncData(current.copyWith(isLoadingMore: false));
      // จุดต่อยอด Production: ส่ง e, st เข้า Error Logger กลางขององค์กร
    }
  }

  /// Pull-to-refresh: โหลดหน้า 1 ใหม่โดยคง filter/sort เดิมไว้
  Future<void> refresh() async {
    final current = state.valueOrNull ?? const ReportState();
    state = await AsyncValue.guard(
      () => _fetchPage(current.copyWith(page: 1, hasMore: true)),
    );
  }
}
```

> ✅ **สิ่งที่ควรสังเกตในโค้ดนี้:**
> 1. ทุก Method ที่เปลี่ยนเงื่อนไข (filter/sort) รีเซ็ต `page: 1` เสมอ - นี่คือประโยชน์ของการรวม State ไว้ที่เดียว กติกาทางธุรกิจถูกบังคับในจุดเดียว
> 2. `loadMore()` ที่พลาดจะ "ไม่ทำให้ทั้งจอ error" - ผู้ใช้ยังเห็นข้อมูลเดิม เป็น UX Pattern มาตรฐานของ Infinite Scroll
> 3. `AsyncValue.guard()` แปลง Exception เป็น `AsyncError` ให้อัตโนมัติ ไม่ต้องเขียน try/catch เอง

### 1.4 ฝั่ง UI: บริโภค ReportState ใน ListView

```dart
// lib/features/report/presentation/report_page.dart (ส่วนสำคัญ)
class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(reportListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('รายงานการผลิตรายวัน')),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('โหลดรายงานไม่สำเร็จ: $e')),
        data: (s) => RefreshIndicator(
          // ดึงลงเพื่อรีเฟรช - เรียก refresh() ใน Notifier
          onRefresh: () => ref.read(reportListProvider.notifier).refresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              // เลื่อนถึง 90% ของลิสต์ = สั่งโหลดหน้าถัดไป
              if (n.metrics.pixels >= n.metrics.maxScrollExtent * 0.9) {
                ref.read(reportListProvider.notifier).loadMore();
              }
              return false;
            },
            child: ListView.builder(
              // +1 ช่องท้ายลิสต์สำหรับ spinner ตอนกำลังโหลดเพิ่ม
              itemCount: s.reports.length + (s.isLoadingMore ? 1 : 0),
              itemBuilder: (context, i) {
                if (i >= s.reports.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final r = s.reports[i];
                return ListTile(
                  title: Text(r.plantName),
                  subtitle: Text('${r.date} - ผลิตได้ ${r.energyMwh} MWh'),
                  trailing: Text('${r.avgOutputMw} MW'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
```

### 🧪 Lab 1.1 - ทดสอบ filter + pagination + refresh

> **เป้าหมาย:** พิสูจน์ว่า Method ทั้ง 4 ของ `ReportNotifier` ทำงานถูกต้องบนหน้าจอจริง

**ขั้นที่ 1** เพิ่ม Dropdown เลือกโรงไฟฟ้าไว้ใน AppBar แล้วเรียก `setFilter`:

```dart
PopupMenuButton<int?>(
  icon: const Icon(Icons.filter_alt),
  onSelected: (id) =>
      ref.read(reportListProvider.notifier).setFilter(plantId: id),
  itemBuilder: (_) => const [
    PopupMenuItem(value: null, child: Text('ทุกโรงไฟฟ้า')),
    PopupMenuItem(value: 1, child: Text('เขื่อนน้ำงึม 1')),
    PopupMenuItem(value: 2, child: Text('เขื่อนน้ำเทิน 2')),
  ],
)
```

**ขั้นที่ 2** รัน `dart run build_runner build --delete-conflicting-outputs` แล้ว `flutter run`

**ขั้นที่ 3** ทดสอบตามลำดับ: เลือกโรงไฟฟ้าจาก Dropdown → เลื่อนลงสุดจนโหลดหน้า 2 → ดึงลงเพื่อรีเฟรช

> ✅ **ผลลัพธ์ที่คาดหวัง:** เลือก filter แล้วลิสต์กรองเฉพาะโรงที่เลือกและกลับไปเริ่มหน้า 1 · เลื่อนลงใกล้สุดแล้วเห็น spinner ท้ายลิสต์ตามด้วยรายการหน้าถัดไปต่อท้าย · ดึงลงแล้วข้อมูลหน้า 1 ถูกโหลดใหม่โดย filter เดิมยังอยู่

---

## 📚 Module 2: StreamProvider + WebSocket Real-time (Laravel Reverb)

### เวลา 10:45-12:00 น.

> 💡 **หัวใจของ Module นี้:** งาน Monitoring โรงไฟฟ้าต้องเห็นค่ากำลังผลิต "วินาทีนี้" ไม่ใช่ค่าเมื่อ 30 วินาทีก่อน การให้แอป Polling ถาม API ซ้ำ ๆ ทั้งเปลืองแบตเตอรี่และหน่วงเวลา ทางที่ถูกต้องคือให้ Server "Push" ข้อมูลมาที่แอปผ่าน WebSocket แล้วฝั่ง Flutter รับด้วย `StreamProvider` ซึ่งแปลง Stream เป็น `AsyncValue` ให้ UI อัตโนมัติ

---

### 2.1 Polling vs WebSocket - ทำไมต้องเปลี่ยน

| ประเด็น                  | HTTP Polling (ถามซ้ำทุก N วินาที)    | WebSocket (Server Push)             |
| ------------------------ | ------------------------------------ | ----------------------------------- |
| ความหน่วงของข้อมูล       | สูงสุด = รอบ Polling (เช่น 30 วิ)    | เกือบทันที (< 1 วินาที)             |
| ภาระ Server              | Request ซ้ำจากทุกเครื่องตลอดเวลา     | เชื่อมต่อค้างไว้ ส่งเฉพาะเมื่อมีข้อมูลใหม่ |
| การใช้แบตเตอรี่/Network  | สิ้นเปลือง (ส่วนใหญ่ได้คำตอบเดิม)    | ประหยัด (รับเฉพาะที่เปลี่ยน)        |
| ความซับซ้อนในการติดตั้ง  | ต่ำ                                  | ปานกลาง (ต้องมี WebSocket Server)   |
| เหมาะกับ                 | ข้อมูลเปลี่ยนช้า (รายงานรายวัน)      | **Monitoring Real-time (งานของเรา)** |

```
HTTP Polling:                          WebSocket:
App ──req──▶ API   (ทุก 30 วิ)         App ══════ เชื่อมต่อค้างไว้ ══════ Reverb
App ◀──res── API   "ค่าเดิม"                          ▲
App ──req──▶ API                                      │ broadcast ทันที
App ◀──res── API   "ค่าเดิม"           Laravel Event ─┘ (เมื่อมีค่าใหม่)
App ──req──▶ API
App ◀──res── API   "ค่าใหม่ (ช้าไป 28 วิ)"
```

ตัวเลือกฝั่ง Laravel มี 3 ทาง: **Laravel Reverb** (WebSocket Server ทางการของ Laravel, ติดตั้งในเครื่องเอง ฟรี), **Pusher** (Cloud Service, จ่ายตามการใช้งาน) และ **Ably** - ทั้งหมดพูด "Pusher Protocol" เหมือนกัน โค้ดฝั่งแอปจึงแทบไม่ต่างกัน ในหลักสูตรนี้เลือก **Reverb** เพราะข้อมูลการผลิตไฟฟ้าเป็นข้อมูลภายในองค์กร ควบคุมเองได้ทั้งหมดและไม่มีค่าใช้จ่ายรายเดือน

### 2.2 ฝั่ง Laravel: ติดตั้ง Reverb + สร้าง Broadcast Event

**ขั้นที่ 1 - ติดตั้ง Laravel Reverb**

```bash
# ในโฟลเดอร์ edlgen_api
php artisan install:broadcasting
# ตอบ Yes เมื่อถามว่าจะติดตั้ง Reverb และรัน migration
```

คำสั่งนี้จะเพิ่มค่าใน `.env` ให้อัตโนมัติ ตรวจสอบให้ตรงดังนี้:

```env
# .env (ส่วน Broadcast)
BROADCAST_CONNECTION=reverb

REVERB_APP_ID=edlgen
REVERB_APP_KEY=edlgen-key
REVERB_APP_SECRET=edlgen-secret
REVERB_HOST="0.0.0.0"      # ให้เครื่องอื่นในวง LAN เชื่อมได้ (สำหรับมือถือจริง)
REVERB_PORT=8080
REVERB_SCHEME=http
```

**ขั้นที่ 2 - สร้าง Event ที่ Broadcast ค่ากำลังผลิต**

```bash
php artisan make:event PowerReadingUpdated
```

```php
<?php
// app/Events/PowerReadingUpdated.php

namespace App\Events;

use App\Models\PowerReading;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

/**
 * Event นี้ถูกยิงทุกครั้งที่มีค่าอ่านกำลังผลิตใหม่เข้าระบบ
 * implements ShouldBroadcast = Laravel จะส่งออกไปทาง WebSocket ให้อัตโนมัติ
 */
class PowerReadingUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct(
        public PowerReading $reading, // ค่าอ่านล่าสุดที่เพิ่งบันทึก
    ) {}

    /**
     * Channel ที่จะ Broadcast ออกไป
     * ใช้ Public Channel ชื่อ power.monitoring (Lab นี้ยังไม่ทำ Private Channel)
     */
    public function broadcastOn(): array
    {
        return [
            new Channel('power.monitoring'),
        ];
    }

    /**
     * ชื่อ Event ที่ฝั่ง Client ใช้ subscribe (ถ้าไม่กำหนดจะเป็นชื่อคลาสเต็ม)
     */
    public function broadcastAs(): string
    {
        return 'power.updated';
    }

    /**
     * เลือกเฉพาะ Field ที่จำเป็นส่งออกไป - อย่าส่งทั้ง Model โดยไม่กรอง
     */
    public function broadcastWith(): array
    {
        return [
            'plant_id'    => $this->reading->plant_id,
            'plant_name'  => $this->reading->plant->name,
            'output_mw'   => (float) $this->reading->output_mw,   // กำลังผลิต (เมกะวัตต์)
            'frequency_hz'=> (float) $this->reading->frequency_hz, // ความถี่ระบบ (เฮิรตซ์)
            'voltage_kv'  => (float) $this->reading->voltage_kv,   // แรงดัน (กิโลโวลต์)
            'recorded_at' => $this->reading->recorded_at->toIso8601String(),
        ];
    }
}
```

**ขั้นที่ 3 - ยิง Event เมื่อมีข้อมูลใหม่** (ใน Service หรือ Controller ที่บันทึกค่าอ่าน)

```php
<?php
// app/Http/Controllers/Api/V1/PowerReadingController.php (ส่วน store)

use App\Events\PowerReadingUpdated;

public function store(StorePowerReadingRequest $request)
{
    $reading = $this->repository->create($request->validated());

    // Broadcast ออก WebSocket ทันทีที่บันทึกสำเร็จ
    PowerReadingUpdated::dispatch($reading);

    return new PowerReadingResource($reading);
}
```

**ขั้นที่ 4 - สร้างคำสั่งจำลองข้อมูลสำหรับใช้สาธิตในห้องอบรม**

```php
<?php
// app/Console/Commands/SimulatePowerReadings.php

namespace App\Console\Commands;

use App\Events\PowerReadingUpdated;
use App\Models\PowerReading;
use Illuminate\Console\Command;

class SimulatePowerReadings extends Command
{
    protected $signature = 'edlgen:simulate {--interval=3 : วินาทีระหว่างค่าอ่านแต่ละครั้ง}';
    protected $description = 'จำลองค่ากำลังผลิตแบบ Real-time สำหรับสาธิต WebSocket';

    public function handle(): void
    {
        $interval = (int) $this->option('interval');
        $this->info("เริ่มจำลองข้อมูล ทุก {$interval} วินาที (กด Ctrl+C เพื่อหยุด)");

        while (true) {
            $reading = PowerReading::create([
                'plant_id'     => rand(1, 3),
                // ค่ากำลังผลิตแกว่งรอบ 150 MW เพื่อให้กราฟดูมีชีวิต
                'output_mw'    => 150 + (rand(-200, 200) / 10),
                'frequency_hz' => 50 + (rand(-15, 15) / 100),
                'voltage_kv'   => 115 + (rand(-30, 30) / 10),
                'recorded_at'  => now(),
            ]);

            PowerReadingUpdated::dispatch($reading);
            $this->line("ส่งค่า: โรง {$reading->plant_id} = {$reading->output_mw} MW");
            sleep($interval);
        }
    }
}
```

**ขั้นที่ 5 - เปิด Reverb Server แล้วเริ่มจำลอง** (ใช้ Terminal 3 หน้าต่าง)

```bash
php artisan serve                 # หน้าต่าง 1: REST API (port 8000)
php artisan reverb:start          # หน้าต่าง 2: WebSocket Server (port 8080)
php artisan edlgen:simulate       # หน้าต่าง 3: จำลองข้อมูลทุก 3 วินาที
```

> ⚠️ **ข้อควรระวังเรื่อง Queue:** โดยค่าเริ่มต้น Event ที่ `implements ShouldBroadcast` จะถูกส่งผ่าน Queue - ถ้าไม่ได้รัน `php artisan queue:work` ข้อความจะค้างไม่ออกไป ในห้องอบรมให้ตั้ง `QUEUE_CONNECTION=sync` ใน `.env` เพื่อส่งทันทีแบบไม่ผ่าน Queue (งาน Production จริงควรใช้ Queue เสมอ)

### 2.3 ฝั่ง Flutter: web_socket_channel + StreamProvider

Reverb พูด Pusher Protocol ดังนั้นเราเชื่อมด้วย `web_socket_channel` ตรง ๆ ได้ โดยต้อง (1) เปิด Socket ไปที่ `/app/{APP_KEY}` (2) ส่งข้อความ subscribe เข้า Channel (3) กรองเฉพาะ Event ที่สนใจ

```bash
flutter pub add web_socket_channel
```

```dart
// lib/features/dashboard/domain/power_reading_live.dart
/// โมเดลค่ากำลังผลิตที่รับจาก WebSocket
class PowerReadingLive {
  const PowerReadingLive({
    required this.plantId,
    required this.plantName,
    required this.outputMw,
    required this.frequencyHz,
    required this.voltageKv,
    required this.recordedAt,
  });

  final int plantId;
  final String plantName;
  final double outputMw;
  final double frequencyHz;
  final double voltageKv;
  final DateTime recordedAt;

  factory PowerReadingLive.fromJson(Map<String, dynamic> json) {
    return PowerReadingLive(
      plantId: json['plant_id'] as int,
      plantName: json['plant_name'] as String,
      outputMw: (json['output_mw'] as num).toDouble(),
      frequencyHz: (json['frequency_hz'] as num).toDouble(),
      voltageKv: (json['voltage_kv'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
    );
  }
}
```

```dart
// lib/features/dashboard/application/power_stream_provider.dart
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:edlgen_monitoring/features/dashboard/domain/power_reading_live.dart';

part 'power_stream_provider.g.dart';

/// StreamProvider เชื่อม Laravel Reverb แล้วปล่อยค่ากำลังผลิตแบบ Real-time
/// - Android Emulator ใช้ 10.0.2.2 แทน localhost ของเครื่อง Host
@riverpod
Stream<PowerReadingLive> powerStream(Ref ref) async* {
  const wsUrl = 'ws://10.0.2.2:8080/app/edlgen-key'; // {REVERB_APP_KEY}
  final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

  // ปิด Socket อัตโนมัติเมื่อไม่มีใคร watch provider นี้แล้ว (Auto-dispose)
  ref.onDispose(() => channel.sink.close());

  // ขั้นที่ 1: ส่งข้อความ subscribe เข้า Channel 'power.monitoring' (Pusher Protocol)
  channel.sink.add(jsonEncode({
    'event': 'pusher:subscribe',
    'data': {'channel': 'power.monitoring'},
  }));

  // ขั้นที่ 2: อ่านทุกข้อความจาก Socket แล้ว yield เฉพาะ Event ที่เราสนใจ
  await for (final message in channel.stream) {
    final decoded = jsonDecode(message as String) as Map<String, dynamic>;

    // ข้าม Event ระบบของ Pusher Protocol เช่น pusher:connection_established
    if (decoded['event'] != 'power.updated') continue;

    // ตาม Protocol ตัว data ซ้อนมาเป็น JSON String อีกชั้น ต้อง decode ซ้ำ
    final payload = jsonDecode(decoded['data'] as String) as Map<String, dynamic>;
    yield PowerReadingLive.fromJson(payload);
  }
}
```

```dart
// lib/features/dashboard/presentation/live_power_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edlgen_monitoring/features/dashboard/application/power_stream_provider.dart';

/// การ์ดแสดงค่ากำลังผลิตล่าสุดแบบ Real-time บน Dashboard
class LivePowerCard extends ConsumerWidget {
  const LivePowerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(powerStreamProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: live.when(
          // ยังไม่ได้รับค่าแรก = กำลังรอการเชื่อมต่อ
          loading: () => const Row(children: [
            SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 12),
            Text('กำลังเชื่อมต่อ Real-time...'),
          ]),
          error: (e, _) => Text('การเชื่อมต่อ Real-time ขัดข้อง: $e'),
          data: (r) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.bolt, color: Colors.amber),
                const SizedBox(width: 8),
                Text(r.plantName, style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                // จุดเขียวบอกว่าสัญญาณ Live กำลังมา
                const CircleAvatar(radius: 5, backgroundColor: Colors.green),
              ]),
              const SizedBox(height: 8),
              Text('${r.outputMw.toStringAsFixed(1)} MW',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('ความถี่ ${r.frequencyHz.toStringAsFixed(2)} Hz | '
                  'แรงดัน ${r.voltageKv.toStringAsFixed(1)} kV'),
              Text('อัปเดตล่าสุด: ${r.recordedAt.toLocal()}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
```

> 📌 **ทำไม `StreamProvider` จึงเหมาะกับงานนี้:** มันแปลง Stream เป็น `AsyncValue` ให้อัตโนมัติ (loading = ยังไม่ได้ค่าแรก, data = ค่าล่าสุด, error = Stream พัง) UI จึงใช้ `.when()` แบบเดียวกับ `FutureProvider` ที่เรียนใน Day 3 ทุกประการ และเมื่อไม่มี Widget ไหน watch อยู่ Riverpod จะ dispose Provider แล้ว `ref.onDispose` จะปิด Socket ให้ ไม่มี Connection รั่ว

### 🧪 Lab 2.1 - เห็นตัวเลขวิ่ง Real-time ครั้งแรก

**ขั้นที่ 1** เปิด 3 Terminal ฝั่ง Laravel: `serve` + `reverb:start` + `edlgen:simulate`
**ขั้นที่ 2** วาง `LivePowerCard()` ไว้บนสุดของ Dashboard แล้ว `flutter run`
**ขั้นที่ 3** สังเกตหน้าต่าง `reverb:start` จะพิมพ์ Log ทุกครั้งที่มี Connection และ Message

> ✅ **ผลลัพธ์ที่คาดหวัง:** การ์ดขึ้น "กำลังเชื่อมต่อ Real-time..." ประมาณ 1-2 วินาที จากนั้นตัวเลข MW / Hz / kV เปลี่ยนเองทุก 3 วินาทีโดยไม่ต้องแตะจอ · ปิดหน้าต่าง `edlgen:simulate` แล้วตัวเลขหยุดนิ่ง (ค่าล่าสุดค้างไว้ ไม่ error) · ปิด `reverb:start` แล้วการ์ดเปลี่ยนเป็นข้อความขัดข้อง

---

## 📚 Module 3: Provider Family - Provider ที่รับ Parameter

### เวลา 13:00-13:30 น.

> 💡 **หัวใจของ Module นี้:** หน้า List กับหน้า Detail คือคู่หูที่พบในแทบทุกแอป คำถามคือ "จะสร้าง Provider สำหรับหน้า Detail อย่างไร ในเมื่อไม่รู้ล่วงหน้าว่าผู้ใช้จะกดดูโรงไฟฟ้าตัวไหน" - คำตอบคือ **Provider Family**: Provider ที่รับ Parameter แล้ว Riverpod สร้าง Instance แยกให้ต่อหนึ่งค่า Parameter โดยอัตโนมัติ

---

### 3.1 แนวคิด Family: หนึ่ง Parameter = หนึ่ง Instance

```
plantDetailProvider (Family)
├── plantDetailProvider(1) ── state ของโรงไฟฟ้า id=1 (เขื่อนน้ำงึม 1)
├── plantDetailProvider(2) ── state ของโรงไฟฟ้า id=2 (เขื่อนน้ำเทิน 2)
└── plantDetailProvider(7) ── state ของโรงไฟฟ้า id=7 (แต่ละตัวแยก cache กัน)
```

ในโหมด Code Generation แค่เพิ่มพารามิเตอร์ในฟังก์ชัน Provider - Riverpod จะสร้าง Family ให้เองโดยไม่ต้องประกาศอะไรพิเศษ:

```dart
// lib/features/plant/application/plant_detail_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:edlgen_monitoring/features/plant/data/plant_repository.dart';
import 'package:edlgen_monitoring/features/plant/domain/plant_detail.dart';

part 'plant_detail_provider.g.dart';

/// Provider Family: รับ plantId แล้วดึงรายละเอียดโรงไฟฟ้าตัวนั้นจาก API
/// เรียกใช้: ref.watch(plantDetailProvider(id))
@riverpod
Future<PlantDetail> plantDetail(Ref ref, int plantId) async {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.fetchPlantDetail(plantId); // GET /api/v1/plants/{id}
}
```

### 3.2 ใช้งานใน List/Detail Pattern ร่วมกับ GoRouter

```dart
// หน้า List (Day 3): กดแล้วส่ง id ไปหน้า Detail ผ่าน route
ListTile(
  title: Text(plant.name),
  onTap: () => context.go('/plants/${plant.id}'),
)
```

```dart
// lib/features/plant/presentation/plant_detail_page.dart
class PlantDetailPage extends ConsumerWidget {
  const PlantDetailPage({super.key, required this.plantId});
  final int plantId; // รับมาจาก path parameter ของ GoRouter

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch แบบส่ง parameter - id ต่างกันคือ state คนละก้อน ไม่ปนกัน
    final detail = ref.watch(plantDetailProvider(plantId));

    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียดโรงไฟฟ้า')),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('โหลดข้อมูลไม่สำเร็จ: $e')),
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(p.name, style: Theme.of(context).textTheme.headlineSmall),
            Text('กำลังผลิตติดตั้ง: ${p.installedCapacityMw} MW'),
            Text('แขวง: ${p.province} | ประเภท: ${p.type}'),
            Text('สถานะ: ${p.status}'),
          ],
        ),
      ),
    );
  }
}
```

> ⚠️ **กติกาสำคัญของ Family:** Parameter ต้องเป็นชนิดที่เทียบเท่ากันได้ (มี `==`/`hashCode` ที่ถูกต้อง) เช่น `int`, `String`, `enum` หรือคลาสที่ทำ equality แล้ว (freezed/record) - ถ้าส่ง Object ธรรมดาที่ไม่ override `==` ทุกครั้งที่ rebuild จะถือเป็น "parameter ใหม่" ทำให้ยิง API ซ้ำไม่รู้จบ
> ✅ **Auto-dispose ช่วยเรื่องหน่วยความจำ:** Provider จาก Code Generation เป็น auto-dispose โดยค่าเริ่มต้น เมื่อออกจากหน้า Detail ของ id นั้น state จะถูกทำลาย ไม่สะสมค้างทุก id ที่เคยเปิด (ถ้าต้องการ cache ข้าม navigation ให้ใช้ `ref.keepAlive()` ประกอบกับ TTL - ต่อยอดใน Module 4)

### 🧪 Lab 3.1 - List/Detail ด้วย Family

**ขั้นที่ 1** เพิ่ม route ใน GoRouter: `GoRoute(path: '/plants/:id', builder: (c, s) => PlantDetailPage(plantId: int.parse(s.pathParameters['id']!)))`
**ขั้นที่ 2** รัน build_runner แล้วกดจากหน้า List เข้าไปดูโรงไฟฟ้า 2-3 ตัวสลับกัน

> ✅ **ผลลัพธ์ที่คาดหวัง:** แต่ละ id แสดงข้อมูลของตัวเองถูกต้อง ไม่ปนกัน · เปิด id เดิมซ้ำภายในหน้าเดิม (เช่น rebuild) ไม่ยิง API ซ้ำ · สังเกต Log ฝั่ง Laravel ว่า request `/plants/{id}` เกิดเฉพาะครั้งแรกที่เข้าแต่ละหน้า

---

## 📚 Module 4: Offline Persistence ด้วย riverpod_sqflite

### เวลา 13:30-14:20 น.

> 💡 **หัวใจของ Module นี้:** เจ้าหน้าที่ EDL-Gen ทำงานที่เขื่อนและสถานีไฟฟ้าห่างไกลซึ่งสัญญาณมือถือไม่เสถียร แอปที่ "เปิดไม่ขึ้นเพราะไม่มีเน็ต" ใช้งานจริงไม่ได้ หลักการคือ **Offline-First**: แสดงข้อมูลจาก Cache ในเครื่องก่อนเสมอ แล้วค่อยอัปเดตจากเครือข่ายเมื่อเชื่อมต่อได้ - `riverpod_sqflite` ทำให้ Provider ของเรา Persist ลง SQLite ได้โดยแก้โค้ดเพียงไม่กี่บรรทัด

---

### 4.1 สถาปัตยกรรม Offline-First

```
                  เปิดแอป / เปิดหน้ารายงาน
                           │
                           ▼
              ┌─────────────────────────┐
              │ มี Cache ใน SQLite ไหม?  │
              └─────┬──────────────┬────┘
              มี    │              │ ไม่มี
                    ▼              ▼
        ┌────────────────┐   ┌────────────────┐
        │ แสดง Cache ทันที │   │ แสดง Loading    │
        │ (ผู้ใช้เห็นข้อมูล │   └───────┬────────┘
        │  ใน < 100 ms)   │           │
        └───────┬────────┘           │
                ▼                    ▼
        ┌──────────────────────────────────┐
        │ ยิง API เบื้องหลัง (ถ้า Online)     │
        ├───────────────┬──────────────────┤
        │ สำเร็จ         │ ล้มเหลว (Offline)  │
        ▼               ▼                  │
  อัปเดตจอ + เขียน   คงข้อมูล Cache ไว้      │
  Cache ใหม่ + ตั้ง   + แสดงป้าย "ข้อมูล      │
  เวลา TTL ใหม่      Offline ล่าสุดเมื่อ..."  │
        └───────────────┴──────────────────┘
```

### 4.2 ติดตั้งและตั้งค่า Storage กลาง

```bash
flutter pub add riverpod_sqflite sqflite path
```

```dart
// lib/core/storage/storage_provider.dart
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

part 'storage_provider.g.dart';

/// Storage กลางของทั้งแอป - เปิดไฟล์ SQLite หนึ่งไฟล์ใช้ร่วมกันทุก Provider
/// keepAlive: true เพราะ Database Connection ควรเปิดค้างตลอดอายุแอป
@Riverpod(keepAlive: true)
Future<JsonSqFliteStorage> storage(Ref ref) async {
  return JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'edlgen_cache.db'),
  );
}
```

### 4.3 ทำให้ Provider รายงาน Persist ลง SQLite (พร้อม TTL)

`riverpod_sqflite` ทำงานร่วมกับ Persist API ของ Riverpod 3.0 (สถานะ experimental) - เพิ่ม mixin `JsonPersist` แล้วเรียก `persist()` ใน `build()`:

```dart
// lib/features/report/application/cached_reports_provider.dart
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:edlgen_monitoring/core/storage/storage_provider.dart';
import 'package:edlgen_monitoring/features/report/data/report_repository.dart';
import 'package:edlgen_monitoring/features/report/domain/daily_report.dart';

part 'cached_reports_provider.g.dart';

@riverpod
@JsonPersist() // สร้างโค้ด encode/decode JSON สำหรับ persist ให้อัตโนมัติ
class CachedDailyReports extends _$CachedDailyReports {
  @override
  FutureOr<List<DailyReport>> build() async {
    // ขั้นที่ 1: ผูก Provider นี้กับ SQLite Storage
    persist(
      ref.watch(storageProvider.future),
      options: const StorageOptions(
        // TTL: Cache มีอายุ 6 ชั่วโมง - พ้นจากนี้ถือว่า "stale" ต้องดึงใหม่
        cacheTime: StorageCacheTime(Duration(hours: 6)),
      ),
    );

    // ขั้นที่ 2: ถ้ามี Cache ที่ยังไม่หมดอายุ Riverpod จะตั้ง state ให้ก่อนแล้ว
    // ผู้ใช้เห็นข้อมูลเก่าทันที ระหว่างที่โค้ดด้านล่างดึงของใหม่เบื้องหลัง
    try {
      return await ref.watch(reportRepositoryProvider).fetchLatestReports();
    } catch (e) {
      // ขั้นที่ 3: Offline - ถ้ามี Cache อยู่แล้วให้ใช้ Cache ต่อ (ไม่โยน error)
      final cached = state.valueOrNull;
      if (cached != null && cached.isNotEmpty) return cached;
      rethrow; // ไม่มี Cache เลยจริง ๆ จึงปล่อยให้ UI แสดง error
    }
  }

  /// บังคับดึงข้อมูลใหม่จาก API (ผูกกับ Pull-to-refresh)
  Future<void> forceRefresh() async {
    state = await AsyncValue.guard(
      () => ref.read(reportRepositoryProvider).fetchLatestReports(),
    );
  }
}
```

> ⚠️ **หมายเหตุ API:** Persist API ของ Riverpod 3.0 ยังติดป้าย experimental รายละเอียดชื่อเมธอด/ออปชันอาจปรับเปลี่ยนได้ ให้ตรวจสอบกับ riverpod.dev ประกอบ - แนวคิดหลักที่ต้องจำคือ 3 ขั้น: **ผูก storage → อ่าน cache ก่อน → ดึงของใหม่ทับ**
> 📌 **โมเดลต้องมี `fromJson`/`toJson`:** `@JsonPersist()` ต้องแปลง State เป็น JSON ได้ ดังนั้น `DailyReport` ต้องประกาศ `factory DailyReport.fromJson(...)` และ `Map<String, dynamic> toJson()` (เรามีอยู่แล้วจาก Day 3 เพราะใช้แปลงผล API)

### 4.4 Sync Strategy: เขียนข้อมูลตอน Offline แล้วส่งย้อนหลัง

การ "อ่าน" ตอน Offline แก้ด้วย Cache แต่การ "เขียน" (เช่น เจ้าหน้าที่บันทึกค่ามิเตอร์ที่สถานีไม่มีสัญญาณ) ต้องใช้ **Outbox Pattern**: เก็บรายการที่รอส่งไว้ในตาราง local แล้วไล่ส่งเมื่อกลับมา Online

```
เจ้าหน้าที่กดบันทึกค่ามิเตอร์
        │
        ▼
┌──────────────────┐   Online    ┌──────────────────────┐
│ ลองส่งเข้า API     │──สำเร็จ──▶ │ บันทึกจริงที่ Server    │
└───────┬──────────┘            │ ลบออกจาก Outbox       │
        │ ล้มเหลว/Offline        └──────────────────────┘
        ▼
┌──────────────────────────────┐
│ เขียนลงตาราง outbox (SQLite)  │  status = pending
│ + แสดงในจอทันที (Optimistic)  │  พร้อม client_uuid กันส่งซ้ำ
└───────┬──────────────────────┘
        │  ...เวลาผ่านไป สัญญาณกลับมา...
        ▼
┌──────────────────────────────┐
│ connectivity_plus ตรวจพบ      │
│ Online → ไล่ส่ง outbox ทีละแถว │──▶ สำเร็จ: ลบแถว / ชนกัน: เข้าสู่
└──────────────────────────────┘     Conflict Resolution (4.5)
```

หลักการสำคัญของ Outbox ที่ต้องออกแบบร่วมกับฝั่ง Laravel:

- **Idempotency Key:** ทุกแถวใน Outbox มี `client_uuid` และฝั่ง Laravel ตรวจ unique - ถ้าแอปส่งซ้ำ (เพราะ timeout แล้ว retry) Server จะไม่บันทึกซ้ำ
- **เรียงลำดับตามเวลา:** ส่งตาม `created_at` เพื่อรักษาลำดับเหตุการณ์
- **Retry แบบ Exponential Backoff:** ล้มเหลวครั้งแรกรอ 2 วินาที, ครั้งถัดไป 4, 8, ... เพื่อไม่ถล่ม Server ตอนสัญญาณเพิ่งกลับมา

### 4.5 Conflict Resolution - เมื่อข้อมูล Local ชนกับ Server

| กลยุทธ์                    | หลักการ                                             | เหมาะกับข้อมูล                                  |
| -------------------------- | ---------------------------------------------------- | ----------------------------------------------- |
| **Server Wins**            | ถ้าชนกัน ให้ยึดค่าบน Server ทิ้งค่า Local            | ข้อมูล Master เช่น รายชื่อโรงไฟฟ้า, สิทธิ์ผู้ใช้ |
| **Client Wins (Last-Write-Wins)** | ค่าที่เขียนล่าสุดชนะ (เทียบ `updated_at`)      | ค่าที่เจ้าหน้าที่จดจากหน้างาน เช่น ค่ามิเตอร์    |
| **Merge ตาม Field**        | รวมการแก้ไขคนละ Field เข้าด้วยกัน                    | ฟอร์มยาวที่หลายคนแก้คนละส่วน                    |
| **Manual Resolution**      | เก็บทั้งสองเวอร์ชันแล้วให้ผู้ใช้/หัวหน้างานเลือก      | ข้อมูลวิกฤต เช่น รายงานเหตุขัดข้อง               |

> ✅ **ข้อสรุปสำหรับ EDL-Gen Monitoring App:** ข้อมูล Master (โรงไฟฟ้า, ผู้ใช้) ใช้ **Server Wins** · ค่ามิเตอร์ที่จดจากหน้างานใช้ **Last-Write-Wins เทียบเวลาที่จดจริง** (`recorded_at` ไม่ใช่เวลาที่ sync ถึง Server) · รายงานเหตุขัดข้องถ้า `client_uuid` ซ้ำให้ Server ตอบ 409 พร้อมข้อมูลเดิม แล้วแอปแสดงให้ผู้ใช้ตัดสิน

### 🧪 Lab 4.1 - พิสูจน์ว่า Cache ทำงาน

**ขั้นที่ 1** สลับหน้า Report ให้ watch `cachedDailyReportsProvider` แล้วรัน build_runner + `flutter run`
**ขั้นที่ 2** เปิดหน้า Report ให้โหลดสำเร็จ 1 ครั้ง (ข้อมูลถูกเขียนลง `edlgen_cache.db`)
**ขั้นที่ 3** ปิดแอปสนิท (Stop) → ปิด `php artisan serve` → เปิดแอปใหม่

> ✅ **ผลลัพธ์ที่คาดหวัง:** แม้ Server ปิดอยู่ หน้า Report ยังแสดงข้อมูลชุดเดิมจาก SQLite ได้ทันที (ไม่มี Error เต็มจอ) - นี่คือ Offline-First ของจริง · เปิด Server กลับมาแล้วดึงรีเฟรช ข้อมูลอัปเดตและ Cache ถูกเขียนใหม่

---

## 📚 Module 5: Provider Scoping & Override

### เวลา 14:20-14:40 น.

> 💡 **หัวใจของ Module นี้:** `ProviderScope` ไม่ได้มีไว้แค่ครอบ root ของแอป - ความสามารถ **override** ของมันคือกลไกที่ทำให้เรา (1) เขียน Test โดยแทนที่ Repository จริงด้วย Mock และ (2) ทำ Multi-tenant โดยให้คนละส่วนของแอปเห็นค่า Provider คนละชุด

---

### 5.1 Override เพื่อการ Test - แทน Repository จริงด้วย Mock

```dart
// test/features/report/report_notifier_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock Repository: คืนข้อมูลปลอมโดยไม่แตะ Network เลย
class FakeReportRepository implements ReportRepository {
  @override
  Future<List<DailyReport>> fetchReports({/* ...พารามิเตอร์เดิม... */}) async {
    return [
      DailyReport(plantId: 1, plantName: 'เขื่อนทดสอบ', energyMwh: 999),
    ];
  }
}

void main() {
  test('ReportList โหลดหน้าแรกจาก Repository ได้', () async {
    // สร้าง Container พร้อม override - หัวใจของการทดสอบ Riverpod
    final container = ProviderContainer(
      overrides: [
        reportRepositoryProvider.overrideWithValue(FakeReportRepository()),
      ],
    );
    addTearDown(container.dispose);

    // อ่านค่าจาก provider โดยตรง ไม่ต้องสร้าง Widget แม้แต่ตัวเดียว
    final stateFuture = container.read(reportListProvider.future);
    final state = await stateFuture;

    expect(state.reports.length, 1);
    expect(state.reports.first.plantName, 'เขื่อนทดสอบ');
  });
}
```

> ✅ **จุดขายของ Riverpod ในองค์กร:** Business Logic ทดสอบได้โดยไม่ต้องรัน Emulator, ไม่ต้องมี Server, รันบน CI (GitHub Actions) ได้ในไม่กี่วินาที - จะได้ใช้จริงใน Day 5 ช่วง Code Review & Best Practices

### 5.2 Scoped Override สำหรับ Multi-tenant Architecture

EDL-Gen มีหลายเขื่อน/หลายสาขา (tenant) สมมติต้องการให้บาง Subtree ของ Widget ทำงานกับ "สาขาปัจจุบัน" คนละค่ากัน สามารถซ้อน `ProviderScope` แล้ว override เฉพาะจุด:

```dart
// Provider เก็บ tenant ปัจจุบัน - ค่า default โยน error เพื่อบังคับให้ override เสมอ
@riverpod
String tenantCode(Ref ref) => throw UnimplementedError('ต้อง override ตาม scope');

// ซ้อน scope: หน้าจอฝั่งซ้ายดูข้อมูลสำนักงานใหญ่ ฝั่งขวาดูสาขาหลวงพระบาง
Row(children: [
  Expanded(
    child: ProviderScope(
      overrides: [tenantCodeProvider.overrideWithValue('VTE-HQ')],
      child: const BranchDashboard(), // ทุก provider ใต้ต้นไม้นี้เห็น VTE-HQ
    ),
  ),
  Expanded(
    child: ProviderScope(
      overrides: [tenantCodeProvider.overrideWithValue('LPB-01')],
      child: const BranchDashboard(), // Widget เดียวกัน แต่เห็น LPB-01
    ),
  ),
])
```

> ⚠️ **ใช้ Scoping อย่างระมัดระวัง:** การซ้อน Scope มากเกินไปทำให้ตามอ่านยากว่าค่ามาจากชั้นไหน - แนวปฏิบัติคือใช้กับ (1) Test (2) ค่า config ระดับ tenant/environment (3) การ inject ค่าเริ่มต้นให้ Dialog หรือหน้าใหม่ เท่านั้น อย่าใช้แทนการส่ง Parameter ปกติ (ซึ่งควรใช้ Family ตาม Module 3)

---

## 📚 Module 6: Cubit vs BLoC + Hybrid Approach

### เวลา 14:40-15:00 น.

> 💡 **หัวใจของ Module นี้:** เราใช้ Riverpod เต็มมือมา 2 วัน ทำไมจู่ ๆ ต้องรู้จัก Cubit? คำตอบ: Business Logic บางแบบ โดยเฉพาะ **Flow ที่มีลำดับสถานะชัดเจน** เช่น Auth (ยังไม่ล็อกอิน → กำลังตรวจ → ล็อกอินแล้ว → หมดเวลา) เขียนเป็น "เครื่องจักรสถานะ" ด้วย Cubit ได้อ่านง่ายมาก และระบบนิเวศ bloc มี `BlocObserver` ที่ Log ทุก Transition เป็น Audit Trail ซึ่งตอบโจทย์มาตรฐานการตรวจสอบขององค์กรพลังงานโดยตรง

---

### 6.1 Cubit vs BLoC - ต่างกันอย่างไร

ทั้งคู่อยู่ใน Package `flutter_bloc` เดียวกัน ต่างกันที่ "วิธีสั่งให้ State เปลี่ยน":

```
BLoC:  UI ──ส่ง Event──▶ [ Bloc: on<Event> ──map──▶ State ] ──▶ UI
       (LoginButtonPressed)                                (AuthLoading → Authenticated)

Cubit: UI ──เรียก Method──▶ [ Cubit: login() → emit(State) ] ──▶ UI
       (cubit.login(user, pass))                           (AuthLoading → Authenticated)
```

| ประเด็น                     | BLoC                                        | Cubit (ที่เราจะใช้)                       |
| --------------------------- | ------------------------------------------- | ----------------------------------------- |
| วิธีสั่งเปลี่ยน State       | ส่ง Event Object เข้า `add()`               | เรียก Method ตรง ๆ แล้ว `emit()`          |
| ปริมาณโค้ด                  | มาก (Event class ทุกการกระทำ)               | น้อย (แค่ Method + State)                 |
| Traceability                | สูงมาก (Event ถูก Log ได้ทุกตัว)            | สูง (Transition ยัง Log ผ่าน Observer ได้) |
| Transform Event (debounce ฯลฯ) | ทำได้ในตัว (`EventTransformer`)          | ทำเองใน Method (เช่นใช้ Timer)            |
| เส้นโค้งการเรียนรู้         | ชันกว่า                                     | เรียนรู้ได้ในชั่วโมงเดียว                 |
| เหมาะกับ                    | Flow ซับซ้อนมาก มีทีมใหญ่คุมมาตรฐาน Event  | **Business Logic ขนาด scope งานนี้**      |

> ✅ **เหตุผลที่หลักสูตรนี้เลือก Cubit:** (1) โค้ดสั้นกว่า BLoC ราวครึ่งหนึ่งแต่ยังได้ `BlocObserver`/Audit Trail ครบ (2) ทีม EDL-Gen เพิ่งเริ่ม Flutter การลด Concept ที่ต้องจำ (ไม่ต้องมี Event class) ช่วยให้ Maintain ต่อได้จริง (3) ถ้าวันหน้า Flow ซับซ้อนขึ้น Cubit อัปเกรดเป็น Bloc ได้โดย State class เดิมใช้ต่อได้ทั้งหมด

### 6.2 Hybrid Approach - เมื่อไหร่ Riverpod เมื่อไหร่ Cubit

| งาน                                            | เครื่องมือ   | เหตุผล                                                        |
| ---------------------------------------------- | ------------ | ------------------------------------------------------------- |
| ดึงข้อมูลจาก API + Cache (Data Layer)          | **Riverpod** | `AsyncValue`, auto-dispose, Family, persist ครบในตัว          |
| Real-time Stream (WebSocket)                   | **Riverpod** | `StreamProvider` จัดการ lifecycle ของ Stream ให้              |
| Dependency Injection (Repository, ApiClient)   | **Riverpod** | Override ได้ ทดสอบง่าย                                        |
| Auth Flow (Login/Logout/Session Timeout)       | **Cubit**    | เป็นเครื่องจักรสถานะชัดเจน + ต้องการ Audit ทุก Transition     |
| Business Flow ที่ต้อง Audit (อนุมัติ, บันทึกเหตุ) | **Cubit** | `BlocObserver` Log ทุกการเปลี่ยนสถานะเป็นหลักฐานตรวจสอบย้อนหลัง |

```
        Hybrid Architecture ของ EDL-Gen Monitoring App
┌───────────────────────────────────────────────────────────┐
│                        UI (Widgets)                        │
├─────────────────────────────┬─────────────────────────────┤
│   Riverpod (Data Layer)     │   Cubit (Business Logic)    │
│  - reportListProvider       │  - AuthCubit (Login/Session)│
│  - powerStreamProvider      │  - StatusCubit (เหตุขัดข้อง) │
│  - plantDetailProvider(id)  │       + AppBlocObserver     │
│  - cachedDailyReports       │         (Audit Trail)       │
├─────────────────────────────┴─────────────────────────────┤
│        Repository / ApiClient / SecureStorage / SQLite     │
└───────────────────────────────────────────────────────────┘
```

> 📌 **กติกาการอยู่ร่วมกัน:** สองระบบไม่ก้าวก่ายกัน - Cubit เรียกใช้ Repository ผ่าน Constructor Injection (ส่งเข้ามาตอนสร้าง) ส่วน Riverpod ใช้ `ref` ตามปกติ · Widget หนึ่งใช้ทั้งคู่ได้: `ConsumerWidget` (Riverpod) ห่อด้วย `BlocProvider`/`BlocBuilder` (Cubit) ไม่มีข้อขัดแย้งทางเทคนิคใด ๆ

**ติดตั้ง Package ฝั่ง bloc ที่ใช้ใน Module 7-8:**

```bash
flutter pub add flutter_bloc flutter_secure_storage
```

---

## 📚 Module 7: AuthCubit - Login/Logout/Session ครบวงจร

### เวลา 15:00-15:30 น.

> 💡 **หัวใจของ Module นี้:** Auth ไม่ใช่แค่ "Login สำเร็จ/ไม่สำเร็จ" แต่คือวงจรชีวิตทั้งเส้น: เก็บ Token อย่างปลอดภัย → ต่ออายุ Token อัตโนมัติ → ตัด Session เมื่อไม่มีการใช้งาน → Logout แล้วทุกหน้าของแอปต้องรับรู้พร้อมกัน - ทั้งหมดนี้คือเครื่องจักรสถานะที่ Cubit ถนัดที่สุด และเราจะเชื่อมกับ Laravel Sanctum ที่สร้างไว้ตั้งแต่ Day 1

---

### 7.1 ออกแบบ AuthState ด้วย Sealed Class

Dart 3 มี `sealed class` ที่บังคับให้ `switch` ครอบคลุมทุกสถานะ - เหมาะกับ State ของ Cubit มาก:

```dart
// lib/features/auth/cubit/auth_state.dart
import 'package:edlgen_monitoring/features/auth/domain/auth_user.dart';

/// สถานะทั้งหมดของวงจร Auth - sealed ทำให้ switch ต้องจัดการครบทุกกรณี
sealed class AuthState {
  const AuthState();
}

/// ยังไม่รู้สถานะ (เพิ่งเปิดแอป กำลังอ่าน Token จาก Secure Storage)
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// กำลังติดต่อ Server (Login หรือ Refresh Token)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// ล็อกอินสำเร็จ - พกข้อมูลผู้ใช้ไว้ให้ทุกหน้าใช้งาน
class Authenticated extends AuthState {
  const Authenticated(this.user);
  final AuthUser user; // id, name, email, role (เช่น operator, supervisor)
}

/// ไม่ได้ล็อกอิน - พร้อมเหตุผล เพื่อให้หน้า Login แสดงข้อความที่ถูกต้อง
class Unauthenticated extends AuthState {
  const Unauthenticated({this.reason});
  final String? reason; // เช่น 'Session หมดอายุ กรุณาเข้าสู่ระบบใหม่'
}

/// Login ล้มเหลว (รหัสผิด/เครือข่ายพัง) - แยกจาก Unauthenticated เพื่อ UX ที่ชัดเจน
class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
}
```

### 7.2 AuthCubit ฉบับเต็ม: Secure Storage + Auto-refresh + Session Timeout

```dart
// lib/features/auth/cubit/auth_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edlgen_monitoring/features/auth/data/auth_api.dart';
import 'package:edlgen_monitoring/features/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthApi api, FlutterSecureStorage? storage})
      : _api = api,
        _storage = storage ?? const FlutterSecureStorage(),
        super(const AuthInitial());

  final AuthApi _api;                 // เรียก endpoint ของ Laravel Sanctum (Day 1)
  final FlutterSecureStorage _storage; // เก็บ Token ใน Keystore/Keychain (เข้ารหัสโดย OS)

  static const _tokenKey = 'edlgen_access_token';
  static const _sessionTimeout = Duration(minutes: 30); // นโยบายองค์กร: นิ่ง 30 นาที = ตัด
  static const _refreshEvery = Duration(minutes: 20);   // ต่ออายุ Token ก่อนหมดอายุจริง

  Timer? _sessionTimer;  // จับเวลา "ไม่มีการใช้งาน"
  Timer? _refreshTimer;  // ต่ออายุ Token เป็นรอบ

  /// เรียกครั้งเดียวตอนเปิดแอป: มี Token ค้างอยู่ไหม และยังใช้ได้หรือเปล่า
  Future<void> checkSession() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) {
      emit(const Unauthenticated());
      return;
    }
    try {
      // GET /api/v1/me พร้อม Bearer Token - สำเร็จแปลว่า Token ยังไม่ถูกเพิกถอน
      final user = await _api.fetchMe(token);
      _startTimers();
      emit(Authenticated(user));
    } catch (_) {
      await _storage.delete(key: _tokenKey); // Token เสียแล้ว ล้างทิ้ง
      emit(const Unauthenticated(reason: 'Session หมดอายุ กรุณาเข้าสู่ระบบใหม่'));
    }
  }

  /// Login ด้วย email/password ผ่าน POST /api/v1/login (Laravel Sanctum)
  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final result = await _api.login(email: email, password: password);
      // เก็บ Token ใน Secure Storage เท่านั้น - ห้ามใช้ SharedPreferences
      await _storage.write(key: _tokenKey, value: result.token);
      _startTimers();
      emit(Authenticated(result.user));
    } on InvalidCredentialsException {
      emit(const AuthFailure('อีเมลหรือรหัสผ่านไม่ถูกต้อง'));
    } catch (e) {
      emit(AuthFailure('เชื่อมต่อเครือข่ายไม่ได้: $e'));
    }
  }

  /// Logout: เพิกถอน Token ฝั่ง Server + ล้างเครื่อง + แจ้งทั่วทั้งแอป
  Future<void> logout({String? reason}) async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      // POST /api/v1/logout - ลบ Token ใน personal_access_tokens ของ Sanctum
      // ใส่ try/catch เพราะแม้ Server ติดต่อไม่ได้ ก็ยังต้อง Logout ฝั่งเครื่องให้สำเร็จ
      try {
        await _api.logout(token);
      } catch (_) {/* เพิกถอนฝั่ง Server ไม่ได้ ให้ Token หมดอายุเองภายหลัง */}
    }
    await _storage.delete(key: _tokenKey);
    _cancelTimers();
    // ทุก Widget ที่ BlocBuilder/BlocListener ฟัง AuthCubit จะเด้งกลับหน้า Login พร้อมกัน
    emit(Unauthenticated(reason: reason));
  }

  /// UI เรียกทุกครั้งที่ผู้ใช้มี Interaction (แตะจอ/เปลี่ยนหน้า) เพื่อรีเซ็ตนาฬิกา Session
  void touchSession() {
    if (state is! Authenticated) return;
    _sessionTimer?.cancel();
    _sessionTimer = Timer(_sessionTimeout, () {
      logout(reason: 'ไม่มีการใช้งานเกิน 30 นาที ระบบตัด Session อัตโนมัติ');
    });
  }

  /// ต่ออายุ Token เบื้องหลังเป็นรอบ ๆ เพื่อให้ผู้ใช้ไม่โดนเด้งกลางงาน
  Future<void> _refreshToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) return;
    try {
      // POST /api/v1/refresh - Laravel ออก Token ใหม่และเพิกถอนตัวเก่า (Token Rotation)
      final newToken = await _api.refresh(token);
      await _storage.write(key: _tokenKey, value: newToken);
    } catch (_) {
      // ต่ออายุไม่สำเร็จ (เช่น ถูกเพิกถอนจากฝั่ง Admin) = บังคับ Logout
      await logout(reason: 'Session ถูกยกเลิก กรุณาเข้าสู่ระบบใหม่');
    }
  }

  void _startTimers() {
    touchSession(); // เริ่มนับ Session Timeout ทันทีที่ล็อกอิน
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshEvery, (_) => _refreshToken());
  }

  void _cancelTimers() {
    _sessionTimer?.cancel();
    _refreshTimer?.cancel();
  }

  @override
  Future<void> close() {
    _cancelTimers(); // คืนทรัพยากรเสมอเมื่อ Cubit ถูกทำลาย
    return super.close();
  }
}
```

> ⚠️ **ทำไมต้อง `flutter_secure_storage` ไม่ใช่ `shared_preferences`:** SharedPreferences เก็บเป็นไฟล์ XML/plist ธรรมดา เครื่องที่ Root/Jailbreak อ่านได้ตรง ๆ ส่วน `flutter_secure_storage` เก็บผ่าน Android Keystore / iOS Keychain ซึ่งเข้ารหัสด้วยกุญแจระดับฮาร์ดแวร์ - Token เข้าระบบข้อมูลการผลิตไฟฟ้าระดับประเทศต้องอยู่ที่นี่เท่านั้น
> 📌 **ฝั่ง Laravel ที่เกี่ยวข้อง (มีแล้วจาก Day 1):** `POST /api/v1/login` คืน `token` + `user`, `GET /api/v1/me` ตรวจ Token, `POST /api/v1/logout` เรียก `$request->user()->currentAccessToken()->delete();` - วันนี้เพิ่ม `POST /api/v1/refresh` ที่สร้าง Token ใหม่แล้วลบตัวเก่าในคำขอเดียว

### 7.3 ผูก AuthCubit เข้ากับแอปและ GoRouter

```dart
// main.dart (ส่วนสำคัญ) - Riverpod และ Bloc อยู่ร่วมกัน
void main() {
  Bloc.observer = AppBlocObserver(); // Audit Trail (Module 8)
  runApp(
    ProviderScope( // ของ Riverpod (มีตั้งแต่ Day 3)
      child: BlocProvider( // ของ Cubit - ครอบทั้งแอปเพราะ Auth เป็น Global State
        create: (_) => AuthCubit(api: AuthApi())..checkSession(),
        child: const EdlGenApp(),
      ),
    ),
  );
}
```

```dart
// lib/core/router/app_router.dart (ส่วน redirect)
GoRouter buildRouter(AuthCubit auth) => GoRouter(
  refreshListenable: GoRouterRefreshStream(auth.stream), // Auth เปลี่ยน = ประเมิน route ใหม่
  redirect: (context, state) {
    final loggedIn = auth.state is Authenticated;
    final goingToLogin = state.matchedLocation == '/login';
    if (!loggedIn && !goingToLogin) return '/login'; // ยังไม่ล็อกอิน บังคับไปหน้า Login
    if (loggedIn && goingToLogin) return '/dashboard'; // ล็อกอินแล้ว ไม่ต้องเห็นหน้า Login
    return null;
  },
  routes: [/* ...routes จาก Day 2-3... */],
);
```

### 🧪 Lab 7.1 - Login แล้วดู Token ใน Secure Storage

**ขั้นที่ 1** สร้างหน้า Login ด้วย `BlocConsumer<AuthCubit, AuthState>`: `listener` จัดการ `AuthFailure` (แสดง SnackBar) ส่วน `builder` แสดงปุ่มเป็น spinner เมื่อ `AuthLoading`
**ขั้นที่ 2** Login ด้วยบัญชีทดสอบจาก Seeder Day 1 (`operator@edlgen.la / password`)
**ขั้นที่ 3** ปิดแอปแล้วเปิดใหม่ - `checkSession()` ต้องพาเข้า Dashboard โดยไม่ถามรหัสซ้ำ
**ขั้นที่ 4** กด Logout จากหน้า Settings

> ✅ **ผลลัพธ์ที่คาดหวัง:** รหัสผิด → SnackBar "อีเมลหรือรหัสผ่านไม่ถูกต้อง" โดยยังอยู่หน้า Login · รหัสถูก → เด้งเข้า Dashboard · เปิดแอปใหม่เข้าได้เลย (Token อยู่ใน Secure Storage) · Logout แล้วทุกหน้าเด้งกลับ Login และตาราง `personal_access_tokens` ฝั่ง Laravel แถวนั้นหายไป

---

## 📚 Module 8: StatusCubit + BlocObserver (Audit Trail)

### เวลา 15:30-15:50 น.

> 💡 **หัวใจของ Module นี้:** องค์กรพลังงานต้องตอบคำถาม "ใครเปลี่ยนสถานะอะไร เมื่อไหร่" ได้เสมอ จุดแข็งเด็ดขาดของ bloc ecosystem คือ `BlocObserver` - จุดสังเกตการณ์กลางที่เห็น **ทุก State Transition ของทุก Cubit ในแอป** โดยไม่ต้องแก้โค้ด Cubit แม้แต่บรรทัดเดียว เขียนครั้งเดียว ได้ Audit Trail ทั้งระบบ

---

### 8.1 StatusCubit - ติดตามสถานะการแจ้งเหตุขัดข้อง

ตัวอย่าง Business Flow ที่ต้อง Audit: เหตุขัดข้องเครื่องจักรมีวงจรสถานะ `reported → acknowledged → inProgress → resolved`

```dart
// lib/features/incident/cubit/status_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

enum IncidentStatus { reported, acknowledged, inProgress, resolved }

class IncidentStatusState {
  const IncidentStatusState({
    required this.incidentId,
    required this.status,
    this.updatedBy,
  });
  final int incidentId;
  final IncidentStatus status;
  final String? updatedBy; // ผู้เปลี่ยนสถานะ - ปรากฏใน Audit Log

  @override
  String toString() => // ข้อความนี้คือสิ่งที่ BlocObserver จะ Log
      'Incident#$incidentId=$status by ${updatedBy ?? "-"}';
}

class StatusCubit extends Cubit<IncidentStatusState> {
  StatusCubit({required int incidentId, required IncidentApi api})
      : _api = api,
        super(IncidentStatusState(
            incidentId: incidentId, status: IncidentStatus.reported));

  final IncidentApi _api;

  /// เปลี่ยนสถานะโดยบังคับกติกาลำดับ (ห้ามข้ามขั้น เช่น reported → resolved)
  Future<void> advanceTo(IncidentStatus next, {required String byUser}) async {
    const order = IncidentStatus.values;
    if (order.indexOf(next) != order.indexOf(state.status) + 1) {
      throw StateError('ห้ามข้ามขั้น: ${state.status} → $next');
    }
    await _api.updateStatus(state.incidentId, next); // บันทึกฝั่ง Laravel ก่อน
    emit(IncidentStatusState( // สำเร็จแล้วจึง emit - BlocObserver บันทึกให้อัตโนมัติ
        incidentId: state.incidentId, status: next, updatedBy: byUser));
  }
}
```

### 8.2 AppBlocObserver ฉบับเต็ม - Log ทุก Transition เป็น Audit Trail

```dart
// lib/core/observability/app_bloc_observer.dart
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';

/// จุดสังเกตการณ์กลาง: เห็นทุก Cubit/Bloc ทั้งแอปโดยไม่ต้องแก้โค้ดใด ๆ
/// ติดตั้งครั้งเดียวใน main(): Bloc.observer = AppBlocObserver();
class AppBlocObserver extends BlocObserver {
  /// รูปแบบบรรทัด Audit: เวลา | Cubit ไหน | จากสถานะ | ไปสถานะ
  String _stamp() => DateTime.now().toIso8601String();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    dev.log('[AUDIT ${_stamp()}] CREATE  ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // หัวใจของ Audit Trail: ทุกการเปลี่ยน State ผ่านจุดนี้เสมอ
    dev.log('[AUDIT ${_stamp()}] CHANGE  ${bloc.runtimeType}: '
        '${change.currentState}  →  ${change.nextState}');
    // จุดต่อยอด Production: ส่งเข้า Logger กลาง / เขียนไฟล์ / ยิงเข้า
    // ตาราง audit_logs ของ Laravel แบบ batch เพื่อเก็บหลักฐานฝั่ง Server
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dev.log('[AUDIT ${_stamp()}] ERROR   ${bloc.runtimeType}: $error',
        error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    dev.log('[AUDIT ${_stamp()}] CLOSE   ${bloc.runtimeType}');
  }
}
```

ตัวอย่าง Log ที่ได้จริงเมื่อผู้ใช้ Login แล้วเปลี่ยนสถานะเหตุขัดข้อง:

```
[AUDIT 2026-07-16T10:42:01] CREATE  AuthCubit
[AUDIT 2026-07-16T10:42:05] CHANGE  AuthCubit: AuthInitial → AuthLoading
[AUDIT 2026-07-16T10:42:06] CHANGE  AuthCubit: AuthLoading → Authenticated
[AUDIT 2026-07-16T10:45:12] CHANGE  StatusCubit: Incident#42=reported by - →
                                    Incident#42=acknowledged by operator@edlgen.la
```

> ✅ **ประโยชน์เชิงองค์กร:** เมื่อเกิดข้อพิพาท (เช่น "ใครกดยืนยันว่าซ่อมเสร็จ") ทีมมีหลักฐานลำดับเหตุการณ์ครบทั้งฝั่งแอป (BlocObserver) และฝั่ง Server (ตาราง audit_logs) - นี่คือเหตุผลข้อใหญ่ที่สุดที่เราเลือกใช้ Cubit สำหรับ Business Logic แทนที่จะใช้ Riverpod ล้วนทั้งแอป
> ⚠️ **อย่า Log ข้อมูลลับ:** ห้ามให้ `toString()` ของ State พิมพ์รหัสผ่านหรือ Token เด็ดขาด - รีวิว `toString()` ของทุก State class ก่อนขึ้น Production เสมอ

---

## 🛠️ Lab วันที่ 4 - Real-time Dashboard + AuthCubit + Offline Cache

### เวลา 15:50-16:30 น.

> **โจทย์:** ประกอบทั้ง 3 ความสามารถของวันนี้เข้าไปในแอป `edlgen_monitoring` ให้ครบ: (1) การ์ด Real-time บน Dashboard (2) Login Flow ด้วย AuthCubit (3) Offline Cache ในหน้ารายงาน - ปิดท้ายด้วยการทดสอบเปิด Airplane Mode เพื่อดู Fallback ของจริง

### ขั้นที่ 1 - เตรียมฝั่ง Laravel (5 นาที)

```bash
# ในโฟลเดอร์ edlgen_api - เปิด 3 Terminal
php artisan serve                  # หน้าต่าง 1: REST API
php artisan reverb:start --debug   # หน้าต่าง 2: WebSocket (--debug เห็นทุกข้อความ)
php artisan edlgen:simulate        # หน้าต่าง 3: จำลองค่ากำลังผลิตทุก 3 วินาที
```

ตรวจว่า `.env` มี `BROADCAST_CONNECTION=reverb` และ `QUEUE_CONNECTION=sync` แล้ว

### ขั้นที่ 2 - Real-time Dashboard (10 นาที)

1. ตรวจว่า `powerStreamProvider` (Module 2) ชี้ URL ถูกต้องกับอุปกรณ์ที่ใช้:

```dart
// Android Emulator:       ws://10.0.2.2:8080/app/edlgen-key
// iOS Simulator:          ws://127.0.0.1:8080/app/edlgen-key
// มือถือจริง (LAN เดียวกัน): ws://192.168.x.x:8080/app/edlgen-key  ← IP เครื่องผู้สอน
```

2. วาง `LivePowerCard()` เป็น Widget แรกใน `DashboardPage` เหนือการ์ดสถิติจาก Day 3
3. รัน `dart run build_runner build --delete-conflicting-outputs` แล้ว `flutter run`

> ✅ **ผลลัพธ์ที่คาดหวัง:** ตัวเลข MW/Hz/kV บนการ์ดขยับเองทุก 3 วินาที และหน้าต่าง `reverb:start --debug` แสดงข้อความ Broadcast ทุกครั้งที่ตัวเลขเปลี่ยน

### ขั้นที่ 3 - Login Flow ด้วย AuthCubit (15 นาที)

1. เพิ่ม endpoint `POST /api/v1/refresh` ฝั่ง Laravel:

```php
// routes/api.php (ใน group middleware auth:sanctum)
Route::post('/refresh', function (Request $request) {
    $user = $request->user();
    $request->user()->currentAccessToken()->delete(); // เพิกถอนตัวเก่า (Rotation)
    return response()->json([
        'token' => $user->createToken('mobile')->plainTextToken,
    ]);
});
```

2. สร้างไฟล์ `auth_state.dart`, `auth_cubit.dart` ตาม Module 7 และติดตั้ง `BlocProvider` + `Bloc.observer = AppBlocObserver();` ใน `main.dart`
3. สร้าง `LoginPage` ด้วย `BlocConsumer` แล้วต่อ `redirect` ของ GoRouter ตาม 7.3
4. ทดสอบ: Login ผิด → ถูก → ปิดเปิดแอป → Logout ตาม Lab 7.1

> ✅ **ผลลัพธ์ที่คาดหวัง:** Flow ครบทั้ง 4 กรณี และ Console แสดงบรรทัด `[AUDIT ...] CHANGE AuthCubit: ...` ทุกการเปลี่ยนสถานะ - เปิดดู Audit Trail ให้ผู้สอนตรวจ

### ขั้นที่ 4 - Offline Cache + ทดสอบ Airplane Mode (10 นาที)

1. สลับหน้า Report ให้ใช้ `cachedDailyReportsProvider` (Module 4) และเพิ่มป้ายบอกสถานะ:

```dart
// แถบเตือนเมื่อกำลังแสดงข้อมูลจาก Cache (ตรวจอย่างง่ายด้วย connectivity_plus)
if (isOffline)
  Container(
    color: Colors.orange.shade100,
    padding: const EdgeInsets.all(8),
    child: const Row(children: [
      Icon(Icons.cloud_off, size: 18),
      SizedBox(width: 8),
      Text('โหมด Offline - แสดงข้อมูลล่าสุดจาก Cache'),
    ]),
  ),
```

2. เปิดหน้า Report ให้โหลดข้อมูลสำเร็จ 1 ครั้ง (Cache ถูกเขียน)
3. **เปิด Airplane Mode บนอุปกรณ์/Emulator** (Emulator: Extended Controls → Cellular → Airplane mode หรือปุ่มลัดในแถบ Quick Settings)
4. ปิดแอปสนิทแล้วเปิดใหม่ → เข้าหน้า Report

> ✅ **ผลลัพธ์ที่คาดหวัง (หัวใจของ Lab):**
> - หน้า Report **ยังแสดงข้อมูลชุดล่าสุดได้** พร้อมแถบส้ม "โหมด Offline" - ไม่ใช่ Error เต็มจอ
> - การ์ด Real-time เปลี่ยนเป็นสถานะขัดข้อง/รอเชื่อมต่อ (WebSocket ใช้ตอน Offline ไม่ได้ เป็นเรื่องปกติ)
> - ปิด Airplane Mode → ดึงรีเฟรชหน้า Report → ข้อมูลใหม่เข้ามาและแถบส้มหายไป → การ์ด Real-time กลับมาวิ่งเอง (Provider ถูกสร้างใหม่เมื่อกลับเข้าหน้า)

### เกณฑ์ผ่าน Lab วันที่ 4 (Checklist ส่งงาน)

- [ ] การ์ด Real-time ขยับเองโดยไม่ต้องแตะจอ และปิด simulate แล้วค่าค้าง (ไม่ crash)
- [ ] Login ผิดเห็นข้อความไทย, Login ถูกเข้า Dashboard, เปิดแอปใหม่ไม่ถามรหัสซ้ำ, Logout เด้งกลับทุกหน้า
- [ ] Console มีบรรทัด `[AUDIT ...]` ครบทุก Transition ของ AuthCubit
- [ ] เปิด Airplane Mode แล้วหน้า Report ยังแสดงข้อมูลจาก Cache พร้อมแถบแจ้งสถานะ Offline

---

## 📝 สรุปประจำวันที่ 4

วันนี้แอป EDL-Gen Monitoring ยกระดับจาก "แอปดึงข้อมูล" เป็น "แอประดับ Enterprise" ด้วย 3 ความสามารถหลัก:

| หัวข้อ                         | สิ่งที่ได้เรียน                                                            | ใช้ในแอปส่วนไหน                     |
| ------------------------------ | --------------------------------------------------------------------------- | ------------------------------------ |
| NotifierProvider               | State หลาย Field + Method (filter/sort/pagination/refresh) ใน Notifier เดียว | หน้ารายงานการผลิต                   |
| StreamProvider + WebSocket     | Laravel Reverb Broadcast → web_socket_channel → AsyncValue                  | การ์ด Real-time บน Dashboard         |
| Provider Family                | Provider รับ Parameter, หนึ่ง id หนึ่ง Instance                             | หน้า Plant Detail                    |
| Offline Persistence            | riverpod_sqflite + TTL + Outbox Pattern + Conflict Resolution               | หน้ารายงาน (ใช้ได้แม้ไม่มีเน็ต)      |
| Scoping & Override             | Mock ใน Test / Multi-tenant ด้วย ProviderScope ซ้อน                         | Test + โครงสร้างหลายสาขา            |
| Cubit vs BLoC (Hybrid)         | Riverpod = Data Layer, Cubit = Business Logic ที่ต้อง Audit                 | สถาปัตยกรรมรวมของแอป                |
| AuthCubit                      | Secure Storage + Auto-refresh + Session Timeout + Logout ทั่วแอป            | Login Flow เชื่อม Sanctum            |
| BlocObserver                   | Log ทุก Transition จากจุดเดียว = Audit Trail                                | ทั้งแอป (ติดตั้งครั้งเดียว)          |

**หลักคิดที่อยากให้จำ 3 ข้อ:**

1. **State ที่เกี่ยวข้องกันต้องอยู่ด้วยกัน** - รวมเป็น State Class เดียวแล้วบังคับกติกาใน Notifier/Cubit ไม่ใช่กระจายเป็น Provider ย่อยหลายตัว
2. **Offline-First คือการออกแบบ ไม่ใช่ Feature เสริม** - ลำดับคิดคือ Cache ก่อน เครือข่ายทีหลัง และวางแผน Conflict ตั้งแต่วันแรก
3. **เลือกเครื่องมือตามงาน ไม่ใช่ตามกระแส** - Riverpod กับ Cubit อยู่ร่วมกันได้อย่างเป็นระบบ ถ้าแบ่งเขตความรับผิดชอบชัดเจน

---

## ✅ ตรวจสอบความพร้อมก่อนวันพรุ่งนี้ (Day 5: Workshop ครบวงจร)

พรุ่งนี้คือวันประกอบร่าง **EDL-Gen Monitoring App ครบ 5 Feature** (Login, Real-time Dashboard, รายงาน Offline, แจ้งเหตุขัดข้อง, บันทึกค่ามิเตอร์) ทุกชิ้นส่วนจาก Day 1-4 จะถูกใช้พร้อมกัน กรุณาตรวจ Checklist นี้ให้ครบก่อนกลับ:

**ฝั่ง Laravel (`edlgen_api`):**

- [ ] `php artisan serve` รันได้ และ Postman ยิง `POST /api/v1/login` ได้ Token (Day 1)
- [ ] Endpoint `/api/v1/plants`, `/api/v1/reports`, `/api/v1/power-readings` ตอบข้อมูลครบ (Day 1, 3)
- [ ] `php artisan reverb:start` รันได้ และ `edlgen:simulate` ยิง Event ออก (Day 4)
- [ ] Endpoint `POST /api/v1/refresh` และ `POST /api/v1/logout` ทำงานถูกต้อง (Day 4)
- [ ] ฐานข้อมูลมี Seeder ข้อมูลโรงไฟฟ้าอย่างน้อย 3 โรงและค่าอ่านย้อนหลังพอทำกราฟ

**ฝั่ง Flutter (`edlgen_monitoring`):**

- [ ] App Skeleton + GoRouter ครบทุกหน้า: Login, Dashboard, Report, Settings (Day 2)
- [ ] Dashboard แสดงข้อมูลจริงผ่าน Riverpod พร้อม Loading/Error State (Day 3)
- [ ] การ์ด Real-time ขยับได้ และ AuthCubit ทำ Login/Logout/Session ครบ (Day 4)
- [ ] เปิด Airplane Mode แล้วหน้า Report ยังใช้งานได้จาก Cache (Day 4)
- [ ] `dart run build_runner build` ผ่านโดยไม่มี Error และ `flutter analyze` ไม่มีคำเตือนค้าง

**เตรียมเพิ่มสำหรับ Day 5:**

- [ ] ติดตั้ง Package ล่วงหน้า: `flutter pub add fl_chart image_picker geolocator connectivity_plus`
- [ ] มือถือจริง (ถ้ามี) เปิด Developer Mode + USB Debugging และต่อ Wi-Fi วงเดียวกับเครื่องอบรม
- [ ] คิดชื่อทีมและแบ่งหน้าที่คร่าว ๆ สำหรับ Final PoC Presentation ช่วงท้าย Day 5

> 📌 **ใครติดข้อไหน:** แจ้งในกลุ่ม LINE ของห้องอบรมก่อน 20:00 น. คืนนี้ ผู้สอนจะรวบรวมปัญหาและเปิดคลินิกแก้ 15 นาทีแรกของเช้าวันพรุ่งนี้

---

## 📖 เอกสารอ้างอิงและแหล่งเรียนรู้เพิ่มเติม

**Riverpod:**

- เอกสารทางการ Riverpod: https://riverpod.dev (หัวข้อ Providers, Family, Auto-dispose)
- Persist API + riverpod_sqflite: https://pub.dev/packages/riverpod_sqflite
- แนวทาง Testing ด้วย ProviderContainer: https://riverpod.dev/docs/essentials/testing

**Bloc / Cubit:**

- เอกสารทางการ bloc: https://bloclibrary.dev (หัวข้อ Cubit, BlocObserver, Testing)
- Package flutter_bloc: https://pub.dev/packages/flutter_bloc
- bloc_test สำหรับทดสอบ Cubit: https://pub.dev/packages/bloc_test

**Laravel Broadcasting / Real-time:**

- Laravel Broadcasting: https://laravel.com/docs/broadcasting
- Laravel Reverb: https://laravel.com/docs/reverb
- Pusher Channels Protocol (โครงข้อความที่ Reverb ใช้): https://pusher.com/docs/channels/library_auth_reference/pusher-websockets-protocol/

**Flutter Packages ที่ใช้วันนี้:**

- web_socket_channel: https://pub.dev/packages/web_socket_channel
- flutter_secure_storage: https://pub.dev/packages/flutter_secure_storage
- sqflite: https://pub.dev/packages/sqflite
- connectivity_plus (ตรวจสถานะเครือข่าย): https://pub.dev/packages/connectivity_plus

**อ่านเพิ่มเชิงสถาปัตยกรรม:**

- Offline-First Architecture (Flutter Docs): https://docs.flutter.dev/app-architecture/design-patterns/offline-first
- Laravel Sanctum (ทบทวนจาก Day 1): https://laravel.com/docs/sanctum

---

*เอกสารประกอบการอบรมหลักสูตร Basic to Advanced Laravel 13 and Flutter Framework (MOB-15) - วันที่ 4/5*
*สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง | www.itgenius.co.th | จัดอบรมให้ EDL-Generation Public Company*


