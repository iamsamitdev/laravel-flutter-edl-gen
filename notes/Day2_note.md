# Basic to Advanced Laravel 13 & Flutter - วันที่ 2: Flutter Foundation + Widget System

**หลักสูตรอบรมเชิงปฏิบัติการ: Basic to Advanced Laravel 13 and Flutter Framework (30 ชั่วโมง)**
**Course ID: MOB-15 | Category: Mobile / Full-Stack**
**จัดอบรมให้: EDL-Generation Public Company (EDL-Gen) ผู้ผลิตไฟฟ้ารายใหญ่ของ สปป.ลาว**
**วันที่ 2: Flutter Foundation + Widget System**
วันที่: วันอังคารที่ 14 กรกฎาคม 2569 | เวลา 09:30-16:30 น. | Onsite Workshop ณ สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง
ผู้สอน: อ.สามิตร โกยม

---

## 🎯 วัตถุประสงค์การเรียนรู้ประจำวัน

เมื่อจบการอบรมวันที่ 2 ผู้เรียนจะสามารถ:

1. อธิบายกลไก Flutter Rendering Pipeline ผ่านความสัมพันธ์ของ **Widget Tree, Element Tree และ RenderObject Tree** และบอกได้ว่าทำไม Flutter จึง rebuild ได้เร็ว
2. เลือกใช้ **StatelessWidget** กับ **StatefulWidget** ได้ถูกสถานการณ์ และเข้าใจวงจรชีวิต (Lifecycle) ของ StatefulWidget
3. ชี้ให้เห็น "ปัญหา" ของการจัดการ State ด้วย `setState` เพียงอย่างเดียว ทั้ง State กระจัดกระจาย, Prop-drilling และ Rebuild ที่ไม่จำเป็น (เพื่อเป็นสะพานไปสู่ Riverpod ใน Day 3)
4. ใช้งาน **BuildContext** อย่างถูกต้อง เข้าใจความแตกต่างของ context แต่ละระดับ และหลีกเลี่ยงบั๊กยอดฮิต เช่น `Scaffold.of()` หา Scaffold ไม่เจอ
5. จัด Layout ด้วย Column, Row, Stack, Expanded, Flexible, ListView.builder, GridView.builder และทำ **Responsive Layout** รองรับทั้งโทรศัพท์และ Tablet ด้วย LayoutBuilder / MediaQuery
6. สร้าง **Custom Widget** ที่ Reusable ตามหลัก Composition และ DRY เช่น `StatCard`, `StatusBadge`, `AlertTile` สำหรับ Dashboard โรงไฟฟ้า
7. ตั้งค่า **GoRouter** ครบทั้ง Named Routes, Route Guard (Auth Check), Deep Link และ Bottom Navigation ด้วย StatefulShellRoute
8. ประกอบทุกอย่างเป็น **Flutter App Skeleton** ของโปรเจกต์ `edlgen_monitoring` ที่มีหน้า Login, Dashboard, รายงาน และตั้งค่า พร้อม Navigation ครบถ้วน (Lab ท้ายวัน)

> **หมายเหตุสำคัญของหลักสูตรนี้:** ตลอด 5 วันเราพัฒนาโปรเจกต์เดียวต่อเนื่องคือ **EDL-Gen Monitoring App** ระบบติดตามการผลิตไฟฟ้า (ใช้ข้อมูลจำลองทั้งหมด ไม่เกี่ยวกับข้อมูลการผลิตจริง) ฝั่ง Backend คือ Laravel `edlgen_api` ที่สร้างไว้แล้วใน Day 1 ส่วนวันนี้เราจะเริ่มสร้างฝั่ง Mobile คือ Flutter `edlgen_monitoring` ตั้งแต่โครงแรก

---

## 🧭 กำหนดการวันที่ 2 (โดยสังเขป)

| เวลา        | หัวข้อ                                                                     |
| ----------- | -------------------------------------------------------------------------- |
| 09:30-09:45 | ทบทวน Day 1 + ตรวจความพร้อมเครื่องมือ (flutter doctor, Emulator, Laravel API) |
| 09:45-10:30 | **Module 1** Flutter Rendering Pipeline: สามต้นไม้แห่ง Flutter              |
| 10:30-11:15 | **Module 2** StatelessWidget vs StatefulWidget + setState (เรียนรู้ "ปัญหา") |
| 11:15-12:00 | **Module 3** Widget Tree & BuildContext (ใช้ context ให้ถูก ชีวิตจะง่าย)     |
| 12:00-13:00 | พักกลางวัน                                                                  |
| 13:00-13:50 | **Module 4** Layout Widgets + Responsive Layout สำหรับ Dashboard            |
| 13:50-14:35 | **Module 5** Custom Widgets + Composition Pattern (StatCard/StatusBadge/AlertTile) |
| 14:35-15:20 | **Module 6** Navigation + GoRouter (Named Routes, Guard, Deep Link, Shell)  |
| 15:20-16:30 | **🛠️ Lab วันที่ 2** สร้าง App Skeleton `edlgen_monitoring` ครบ 4 หน้า        |

---

## ✅ ทบทวน Day 1 + ตรวจความพร้อมเครื่องมือ

### เวลา 09:30-09:45 น.

**สิ่งที่เราทำไปแล้วใน Day 1 (สรุปสั้น ๆ):**

- สร้างโปรเจกต์ Laravel 13 ชื่อ `edlgen_api` พร้อมโครงสร้าง Repository Pattern และ API versioning (`/api/v1/`)
- ทำ Authentication ด้วย Laravel Sanctum (Login/Logout + Token สำหรับ Mobile Client)
- สร้าง API Resources แปลง Eloquent Model เป็น JSON ที่สะอาด
- แตะพื้นฐาน Riverpod `AsyncValue` (loading / data / error) ซึ่งจะกลับมาใช้เต็มรูปแบบใน Day 3

**ตรวจความพร้อมก่อนเริ่มวันนี้** - เปิด Terminal แล้วรันทีละคำสั่ง:

```bash
# 1) ตรวจ Flutter SDK และเครื่องมือแวดล้อม (ต้องเขียวทุกช่องที่จำเป็น)
flutter --version
flutter doctor

# 2) ตรวจว่ามี Emulator หรือเครื่องจริงพร้อมใช้งาน
flutter devices
flutter emulators
```

```bash
# 3) ตรวจว่า Laravel API จาก Day 1 ยังรันได้ (เปิดอีก Terminal หนึ่ง)
cd edlgen_api
php artisan serve
# แล้วทดสอบด้วย curl หรือ Postman:
# GET http://127.0.0.1:8000/api/v1/health  →  {"status":"ok"}
```

> ✅ **เกณฑ์ผ่าน:** `flutter doctor` ไม่มีกากบาทแดงในส่วน Flutter/Android toolchain, มี device อย่างน้อย 1 ตัวใน `flutter devices` และ Laravel ตอบ `{"status":"ok"}` - ถ้าติดข้อใดให้แจ้งวิทยากรทันที เพราะ Lab ท้ายวันต้องใช้ทุกอย่าง
> 📌 วันนี้เราจะยังไม่เชื่อม Flutter เข้ากับ Laravel API จริง (เป็นเนื้อหา Day 3) แต่ต้องมั่นใจว่า API พร้อม เพื่อไม่ให้เสียเวลาแก้สิ่งแวดล้อมพรุ่งนี้

---

## 📚 Module 1: Flutter Rendering Pipeline - สามต้นไม้แห่ง Flutter

### เวลา 09:45-10:30 น.

> 💡 **หัวใจของ Module นี้:** Widget ที่เราเขียนเป็นเพียง "พิมพ์เขียว" (Configuration) ที่สร้างใหม่ได้ถูกมาก ของจริงที่วาดจอคือ RenderObject ซึ่ง Flutter พยายามรักษาไว้ให้นานที่สุด ความเข้าใจนี้คือคำตอบว่าทำไม Flutter rebuild บ่อย ๆ ได้โดยไม่ช้า และทำไม `const` กับการแยก Widget เล็ก ๆ จึงช่วยเรื่อง Performance จริง

---

### 1.1 Widget ไม่ใช่ "จอภาพ" แต่เป็น "พิมพ์เขียว"

ประโยคที่ได้ยินบ่อยที่สุดใน Flutter คือ *"Everything is a Widget"* แต่ประโยคที่สำคัญกว่าคือ **"Widget เป็น Immutable Configuration"** - ทุกครั้งที่เรียก `build()` Flutter จะสร้าง Widget object ชุดใหม่ทั้งหมด ซึ่งฟังดูสิ้นเปลือง แต่จริง ๆ แล้ว Widget เป็นแค่ object เบา ๆ ที่เก็บค่า configuration เท่านั้น ไม่ได้วาดอะไรบนจอเอง

Flutter แยกงานออกเป็น 3 ต้นไม้ที่ทำงานคู่ขนานกัน:

```
        Widget Tree                Element Tree               RenderObject Tree
     (พิมพ์เขียว/Config)          (ตัวกลาง/ตัวจัดการ)           (ตัววาดจอจริง)
   สร้างใหม่ทุกครั้งที่ build     อายุยืน อยู่ข้ามการ rebuild      อายุยืน แพงที่สุด

   ┌───────────────┐          ┌───────────────┐          ┌────────────────┐
   │   MyApp       │ ───────▶ │  Element      │ ───────▶ │                │
   ├───────────────┤          ├───────────────┤          │                │
   │   Scaffold    │ ───────▶ │  Element      │ ───────▶ │ RenderBox      │
   ├───────────────┤          ├───────────────┤          ├────────────────┤
   │   Column      │ ───────▶ │  Element      │ ───────▶ │ RenderFlex     │
   ├───────────────┤          ├───────────────┤          ├────────────────┤
   │   Text('42')  │ ───────▶ │  Element      │ ───────▶ │ RenderParagraph│
   └───────────────┘          └───────────────┘          └────────────────┘
      ถูกโยนทิ้ง/สร้างใหม่       เทียบของเก่า-ใหม่แล้ว          ถูก "อัปเดตค่า"
      ได้เรื่อย ๆ (ราคาถูก)      ตัดสินใจว่า reuse ได้ไหม        ไม่ใช่สร้างใหม่ (ราคาแพง)
```

| ต้นไม้            | หน้าที่                                        | อายุ                          | ต้นทุน   |
| ----------------- | ---------------------------------------------- | ----------------------------- | -------- |
| Widget Tree       | เก็บ configuration (สี ขนาด ข้อความ callback)  | สั้นมาก สร้างใหม่ทุก build     | ถูกมาก   |
| Element Tree      | ตัวกลาง จับคู่ Widget กับ RenderObject, ถือ State | ยืนยาว อยู่ข้าม rebuild        | ปานกลาง  |
| RenderObject Tree | คำนวณ Layout, วาด (Paint), รับ Hit Test        | ยืนยาว ถูก reuse ให้มากที่สุด  | แพงที่สุด |

### 1.2 เกิดอะไรขึ้นเมื่อเรียก setState

เมื่อ State เปลี่ยนและ `build()` ถูกเรียกใหม่ Flutter ไม่ได้ "วาดจอใหม่ทั้งหน้า" แต่ทำงานเป็นขั้นตอนดังนี้:

```
setState() ถูกเรียก
      │
      ▼
Element ถูก mark เป็น "dirty"
      │
      ▼
เฟรมถัดไป: เรียก build() → ได้ Widget Tree ชุดใหม่
      │
      ▼
Element เทียบ Widget เก่า vs ใหม่ ทีละตำแหน่ง
      │
      ├── runtimeType เดิม + key เดิม  →  reuse Element/RenderObject เดิม
      │                                    แค่อัปเดตค่า config (เร็วมาก) ✅
      │
      └── ชนิดเปลี่ยน / key เปลี่ยน     →  ถอด Element เก่าออก สร้างใหม่ (แพงกว่า)
```

นี่คือเหตุผลที่ Flutter rebuild เร็ว: **สิ่งที่สร้างใหม่คือพิมพ์เขียวราคาถูก ส่วนของแพง (Element/RenderObject) ถูก reuse เกือบทั้งหมด**

### 1.3 บทเรียนเชิงปฏิบัติจากสามต้นไม้

ความเข้าใจนี้แปลงเป็นแนวปฏิบัติได้ทันที 3 ข้อ:

```dart
// ข้อ 1: ใช้ const ทุกครั้งที่ทำได้
// const widget จะถูก canonicalize - Flutter รู้ว่า "ตัวเดิมเป๊ะ" และข้ามการเทียบทั้งกิ่ง
const Text('EDL-Gen Monitoring');        // ✅ ดี: ไม่ถูกสร้างซ้ำตอน rebuild
Text('EDL-Gen Monitoring');              // ⚠️ สร้าง object ใหม่ทุก build โดยไม่จำเป็น

// ข้อ 2: แยก Widget ใหญ่เป็น Widget ย่อย (class ไม่ใช่เมธอด helper)
// เพราะขอบเขตการ rebuild คือ "Element ของ class" - แยก class = จำกัดวง rebuild
class PowerHeader extends StatelessWidget { ... }   // ✅ rebuild เฉพาะส่วนนี้ได้

// ข้อ 3: ใช้ Key เมื่อรายการมีการสลับ/ลบ/แทรกลำดับ
ListView(
  children: [
    for (final plant in plants)
      PlantTile(key: ValueKey(plant.id), plant: plant), // ✅ Element จับคู่ถูกตัว
  ],
);
```

> ⚠️ **ข้อควรระวัง:** การเขียน helper เป็นเมธอด `Widget _buildHeader()` ไม่ได้สร้าง Element ใหม่แยกต่างหาก มันเป็นแค่โค้ดในไฟล์เดียวกันที่ rebuild พร้อมกันทั้งก้อน ถ้าต้องการจำกัดวง rebuild ต้องแยกเป็น **class** เสมอ (หลักนี้จะสำคัญมากขึ้นเมื่อใช้ Riverpod ใน Day 3)
> 📌 **เชื่อมโยงกับ EDL-Gen:** Dashboard โรงไฟฟ้าของเรามีตัวเลขที่ขยับบ่อย (กำลังผลิต MW, ความถี่ Hz) การออกแบบให้ตัวเลขเหล่านั้นอยู่ใน Widget เล็ก ๆ ของตัวเอง จะทำให้ Real-time update ใน Day 4 ไม่ลาก Widget ทั้งหน้าไป rebuild ด้วย

---

### 🧪 Lab 1.1 - พิสูจน์การ rebuild ด้วย debugPrint

> **เป้าหมาย:** เห็นกับตาว่า Widget ไหน rebuild บ้างเมื่อกดปุ่ม และ `const` ช่วยลดการสร้าง object อย่างไร

สร้างโปรเจกต์ทดลองชั่วคราว (หรือใช้ DartPad ก็ได้) แล้ววางโค้ดนี้:

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RebuildDemo()));

class RebuildDemo extends StatefulWidget {
  const RebuildDemo({super.key});

  @override
  State<RebuildDemo> createState() => _RebuildDemoState();
}

class _RebuildDemoState extends State<RebuildDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('🔁 RebuildDemo build ครั้งที่ $_count');
    return Scaffold(
      appBar: AppBar(title: const Text('Rebuild Demo')),
      body: Column(
        children: [
          Text('กดไปแล้ว $_count ครั้ง'),   // เปลี่ยนตาม state → ต้อง rebuild
          const StaticBanner(),             // const → ไม่ถูกสร้างใหม่
          NonConstBanner(),                 // ไม่ const → ถูกสร้างใหม่ทุกครั้ง
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StaticBanner extends StatelessWidget {
  const StaticBanner({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('   🟢 StaticBanner build');
    return const Text('ป้ายคงที่ (const)');
  }
}

class NonConstBanner extends StatelessWidget {
  NonConstBanner({super.key}); // จงใจไม่มี const constructor call

  @override
  Widget build(BuildContext context) {
    debugPrint('   🔴 NonConstBanner build');
    return const Text('ป้ายไม่ const');
  }
}
```

> ✅ **ผลลัพธ์ที่คาดหวัง:** กดปุ่ม + หลาย ๆ ครั้งแล้วดู Console จะเห็น `RebuildDemo build` และ `🔴 NonConstBanner build` ทุกครั้งที่กด แต่ `🟢 StaticBanner build` ขึ้นเพียงครั้งแรกครั้งเดียว เพราะ const widget ตัวเดิมถูก reuse ทั้งกิ่ง - นี่คือ Element Tree ทำงานให้เราเห็นชัด ๆ

---

## 📚 Module 2: StatelessWidget vs StatefulWidget + setState

### เวลา 10:30-11:15 น.

> 💡 **หัวใจของ Module นี้:** เราจะตั้งใจสร้าง UI ด้วย `setState` แบบตรงไปตรงมาที่สุด จนกระทั่งชนกำแพง 3 เรื่อง: State กระจัดกระจาย, Prop-drilling และ Rebuild เกินจำเป็น - Module นี้คือ "การเรียนรู้ปัญหา" โดยเจตนา เพื่อให้ Day 3 ตอบได้ว่า Riverpod มาแก้อะไร

---

### 2.1 StatelessWidget - Widget ที่ไม่มีความจำ

`StatelessWidget` เหมาะกับ UI ที่ผลลัพธ์ขึ้นกับ input (constructor parameters) ล้วน ๆ ไม่มีอะไรเปลี่ยนแปลงภายในตัวเอง:

```dart
// widget แสดงชื่อโรงไฟฟ้า - รับค่าเข้ามาแล้วแสดงผลอย่างเดียว
class PlantNameLabel extends StatelessWidget {
  const PlantNameLabel({super.key, required this.name});

  final String name; // final เสมอ เพราะ Widget เป็น Immutable

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
```

### 2.2 StatefulWidget + setState - Widget ที่มีความจำ

เมื่อ UI ต้อง "จำ" อะไรบางอย่างที่เปลี่ยนได้ (ค่าที่ผู้ใช้กด, ข้อมูลที่โหลดมา) เราใช้ `StatefulWidget` โดยตัว Widget เองยังคง Immutable แต่จับคู่กับ **State object** ที่มีอายุยืน (อาศัยอยู่ใน Element Tree ตามที่เรียนใน Module 1):

```dart
// สวิตช์จำลองการสั่งเดินเครื่อง/หยุดเครื่องกำเนิดไฟฟ้า
class GeneratorSwitch extends StatefulWidget {
  const GeneratorSwitch({super.key});

  @override
  State<GeneratorSwitch> createState() => _GeneratorSwitchState();
}

class _GeneratorSwitchState extends State<GeneratorSwitch> {
  bool _isRunning = false; // state ที่เปลี่ยนได้ อยู่ในคลาส State

  void _toggle() {
    // setState แจ้ง Flutter ว่า state เปลี่ยน → mark dirty → build ใหม่เฟรมหน้า
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(_isRunning ? 'เครื่องกำลังเดิน (Online)' : 'เครื่องหยุด (Offline)'),
      value: _isRunning,
      onChanged: (_) => _toggle(),
    );
  }
}
```

**วงจรชีวิตของ StatefulWidget ที่ต้องรู้:**

```
createState() → initState() → build() ──┬──▶ setState() → build() (วนได้หลายรอบ)
                    │                   │
       (ทำครั้งเดียว: เปิด controller,   ├──▶ didUpdateWidget() (parent ส่ง config ใหม่)
        subscribe, โหลดค่าเริ่มต้น)      │
                                        └──▶ dispose()
                                             (คืนทรัพยากร: ปิด controller, ยกเลิก timer)
```

| ประเด็น               | StatelessWidget           | StatefulWidget                       |
| --------------------- | ------------------------- | ------------------------------------ |
| มี state ภายใน        | ไม่มี                     | มี (ในคลาส `State<T>`)               |
| ค่าใน class           | `final` ทั้งหมด           | Widget เป็น final, State เปลี่ยนได้   |
| rebuild เมื่อ         | parent build ใหม่เท่านั้น  | parent build ใหม่ หรือ `setState()`  |
| lifecycle hooks       | ไม่มี                     | `initState`, `dispose` ฯลฯ           |
| เหมาะกับ              | Label, Card, Icon, Layout | Form, Animation, Toggle, หน้าที่โหลดข้อมูลเอง |

> ✅ **กฎการเลือกแบบง่าย:** เริ่มจาก `StatelessWidget` เสมอ แล้วเปลี่ยนเป็น `StatefulWidget` เฉพาะเมื่อ "widget นี้ต้องจำอะไรด้วยตัวเอง" - ยิ่ง Stateless มากเท่าไหร่ แอปยิ่งเดาพฤติกรรมง่ายและทดสอบง่าย

### 2.3 สร้าง Mini Dashboard ด้วย setState แล้วดู "ปัญหา"

ลองสร้างหน้า Dashboard จำลองที่มีสถานะโรงไฟฟ้า 1 ค่า แต่มี Widget หลายชั้นต้องใช้ค่านี้ร่วมกัน:

```dart
// dashboard_setstate_demo.dart - จงใจเขียนแบบ "ยังไม่มี state management"
import 'package:flutter/material.dart';

class DashboardSetStateDemo extends StatefulWidget {
  const DashboardSetStateDemo({super.key});

  @override
  State<DashboardSetStateDemo> createState() => _DashboardSetStateDemoState();
}

class _DashboardSetStateDemoState extends State<DashboardSetStateDemo> {
  // ❗ ปัญหา 1: State ทั้งหมดกองอยู่บนสุด เพราะลูก ๆ หลายตัวต้องใช้
  double _powerMw = 152.4;      // กำลังผลิตปัจจุบัน
  bool _plantOnline = true;     // สถานะโรงไฟฟ้า
  int _alertCount = 2;          // จำนวนแจ้งเตือนค้าง

  void _simulateNewReading() {
    setState(() {
      _powerMw = 140 + (DateTime.now().second % 30); // ค่าจำลอง
    });
  }

  @override
  Widget build(BuildContext context) {
    // ❗ ปัญหา 3: setState บนคลาสนี้ ทำให้ "ทุกส่วน" ของหน้า rebuild
    // ทั้งที่ค่าที่เปลี่ยนจริงมีแค่ _powerMw
    debugPrint('🔁 rebuild ทั้งหน้า Dashboard');
    return Scaffold(
      appBar: AppBar(title: const Text('EDL-Gen Dashboard (setState)')),
      body: Column(
        children: [
          // ❗ ปัญหา 2: Prop-drilling - ต้องส่งค่าผ่าน constructor เป็นทอด ๆ
          HeaderSection(online: _plantOnline, alertCount: _alertCount),
          PowerSection(powerMw: _powerMw),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _simulateNewReading,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

// ชั้นที่ 1: รับค่ามา "เพื่อส่งต่อ" ให้ลูกอีกที ทั้งที่ตัวเองไม่ได้ใช้ alertCount
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.online, required this.alertCount});

  final bool online;
  final int alertCount; // ❗ แค่ทางผ่าน (prop-drilling)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.bolt, color: online ? Colors.green : Colors.red),
        Text(online ? 'ระบบออนไลน์' : 'ระบบออฟไลน์'),
        const Spacer(),
        AlertBell(alertCount: alertCount), // ส่งต่ออีกชั้น
      ],
    );
  }
}

class AlertBell extends StatelessWidget {
  const AlertBell({super.key, required this.alertCount});

  final int alertCount;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text('$alertCount'),
      child: const Icon(Icons.notifications),
    );
  }
}

class PowerSection extends StatelessWidget {
  const PowerSection({super.key, required this.powerMw});

  final double powerMw;

  @override
  Widget build(BuildContext context) {
    debugPrint('   ⚡ PowerSection rebuild');
    return Text(
      '${powerMw.toStringAsFixed(1)} MW',
      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}
```

### 2.4 สรุป "ปัญหา" ที่เราเพิ่งสร้างขึ้นเอง

| ปัญหา                        | อาการในโค้ดข้างบน                                                      | ผลเมื่อแอปโตขึ้น                              |
| ---------------------------- | ----------------------------------------------------------------------- | --------------------------------------------- |
| **State กระจัดกระจาย/กองรวม** | ทุกค่าถูกลากขึ้นไปไว้ที่ State บนสุดเพื่อให้ลูกเข้าถึงได้                | หน้าหลักกลายเป็น God Object แก้ยาก ทดสอบยาก   |
| **Prop-drilling**            | `alertCount` วิ่งผ่าน `HeaderSection` ที่ไม่ได้ใช้ เพื่อไปถึง `AlertBell` | เพิ่มค่าใหม่ 1 ตัว ต้องไล่แก้ constructor หลายชั้น |
| **Rebuild ไม่จำเป็น**        | กดปุ่ม refresh เปลี่ยนแค่ `_powerMw` แต่ Header/AlertBell rebuild ด้วย    | Dashboard ที่อัปเดตถี่ ๆ จะเปลืองงาน render โดยเปล่า |
| **แชร์ state ข้ามหน้าไม่ได้** | ถ้าหน้า "รายงาน" อยากรู้ `_plantOnline` ต้องส่งผ่าน constructor ของ route | Logic ธุรกิจผูกติด UI ทดสอบแยกไม่ได้           |

> 📌 **ประเด็นส่งท้าย Module:** `setState` ไม่ใช่ผู้ร้าย มันยอดเยี่ยมสำหรับ **state เฉพาะที่ของ widget เดียว** (เช่น เปิด/ปิดรหัสผ่านในช่อง TextField) แต่เมื่อ state ต้อง **แชร์ข้าม widget หรือข้ามหน้า** เราต้องการเครื่องมือที่ดีกว่า - นั่นคือเหตุผลที่ Day 3 ทั้งวันเป็นเรื่อง Riverpod 3.0
> 🧪 **ผลลัพธ์ที่คาดหวังจากการรันตัวอย่าง 2.3:** กด refresh แล้ว Console ขึ้นทั้ง `🔁 rebuild ทั้งหน้า` และ `⚡ PowerSection rebuild` ทุกครั้ง แม้ Header ไม่มีอะไรเปลี่ยน ให้ผู้เรียนจดพฤติกรรมนี้ไว้เทียบกับเวอร์ชัน Riverpod ในวันพรุ่งนี้

---

## 📚 Module 3: Widget Tree & BuildContext

### เวลา 11:15-12:00 น.

> 💡 **หัวใจของ Module นี้:** `BuildContext` ไม่ใช่ของลึกลับ มันคือ "ตำแหน่งของ widget ตัวนี้ใน Element Tree" การเรียก `Theme.of(context)`, `Navigator.of(context)`, `Scaffold.of(context)` ล้วนเป็นการ **เดินขึ้นข้างบน** จากตำแหน่งนั้นเพื่อหาบรรพบุรุษที่ใกล้ที่สุด - บั๊ก context เกือบทั้งหมดเกิดจากการ "ยืนผิดจุดแล้วมองไม่เห็นสิ่งที่ต้องการ"

---

### 3.1 BuildContext คืออะไรกันแน่

ทุกครั้งที่ `build(BuildContext context)` ถูกเรียก ค่า `context` ที่ได้รับก็คือ **Element ของ widget ตัวนั้นเอง** (Element implements BuildContext) ดังนั้น:

- context ของแต่ละ widget **ไม่เหมือนกัน** เพราะอยู่คนละตำแหน่งในต้นไม้
- `X.of(context)` = เดินขึ้นจากตำแหน่งนี้ ไปหา `X` ตัวที่ **ใกล้ที่สุดด้านบน**
- ถ้าด้านบนของตำแหน่งนั้น "ไม่มี X" จะได้ error หรือ null แม้ว่า X จะอยู่ในหน้าเดียวกัน (แต่อยู่ "ข้าง ๆ" หรือ "ข้างล่าง")

```
                    MaterialApp          ← Theme, Navigator อาศัยอยู่แถวนี้
                        │
                    ScaffoldA
                        │
             ┌──────────┴──────────┐
         AppBar                  Body
                                   │
                              MyButton (context นี้มองขึ้นไปเห็น: Body → ScaffoldA
                                        → MaterialApp ✅ เจอ Navigator/Theme/Scaffold)

  แต่ถ้าเขียนแบบนี้:
                    MyPage.build(context)   ← context นี้อยู่ "เหนือ" Scaffold!
                        │
                    Scaffold                ← เพิ่งถูกสร้างใน build เดียวกัน
                        │
                      Body

  Scaffold.of(context) จาก context ของ MyPage → เดินขึ้นไม่เจอ Scaffold ❌
  (เพราะ Scaffold อยู่ "ใต้" ตำแหน่งที่ยืน ไม่ใช่ "เหนือ")
```

### 3.2 บั๊กยอดฮิตอันดับ 1: Scaffold.of() / ScaffoldMessenger ใน build เดียวกัน

```dart
// ❌ แบบผิด: ใช้ context ที่อยู่เหนือ Scaffold
class BrokenPage extends StatelessWidget {
  const BrokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Error: Scaffold.of() called with a context that does not
            // contain a Scaffold. เพราะ context ตัวนี้เป็นของ BrokenPage
            // ซึ่งอยู่ "เหนือ" Scaffold ที่เพิ่งสร้าง
            Scaffold.of(context).openDrawer();
          },
          child: const Text('เปิดเมนู'),
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
```

วิธีแก้มี 3 ทางมาตรฐาน:

```dart
// ✅ ทางที่ 1: คั่นด้วย Builder เพื่อสร้าง context ใหม่ที่อยู่ "ใต้" Scaffold
Scaffold(
  drawer: const Drawer(),
  body: Center(
    child: Builder(
      builder: (innerContext) => ElevatedButton(
        onPressed: () => Scaffold.of(innerContext).openDrawer(),
        child: const Text('เปิดเมนู'),
      ),
    ),
  ),
);

// ✅ ทางที่ 2: แยกปุ่มเป็น widget class ของตัวเอง (แนะนำที่สุด อ่านง่าย + จำกัด rebuild)
class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    // context ตรงนี้เป็นของ OpenDrawerButton ซึ่งอยู่ใต้ Scaffold แล้ว
    return ElevatedButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      child: const Text('เปิดเมนู'),
    );
  }
}

// ✅ ทางที่ 3: สำหรับ SnackBar ใช้ ScaffoldMessenger ซึ่งอยู่ระดับ MaterialApp
// จึงเรียกได้แม้ context จะอยู่เหนือ Scaffold ของหน้า
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('บันทึกค่ามิเตอร์สำเร็จ')),
);
```

### 3.3 บั๊กยอดฮิตอันดับ 2: ใช้ context หลัง await (context ข้าม async gap)

```dart
// ❌ เสี่ยง: ระหว่าง await ผู้ใช้อาจกด back ทำให้ widget ถูก dispose ไปแล้ว
Future<void> _submitReport(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2)); // จำลองยิง API
  Navigator.of(context).pop(); // ⚠️ Lint เตือน: use_build_context_synchronously
}

// ✅ แบบปลอดภัย: เช็ก mounted ก่อนใช้ context หลัง await (ใน State)
Future<void> _submitReportSafe() async {
  await Future.delayed(const Duration(seconds: 2));
  if (!mounted) return;            // widget ถูกถอดไปแล้ว → เลิกทำ
  Navigator.of(context).pop();     // ปลอดภัยแล้ว
}
```

### 3.4 Navigator context ใน Dialog / BottomSheet

อีกจุดที่พลาดบ่อยคือ context ภายใน `showDialog` ซึ่งเป็น **คนละ route** กับหน้าที่เปิดมัน:

```dart
// ปุ่มยืนยันการสั่งหยุดเครื่องกำเนิดไฟฟ้า
showDialog<void>(
  context: context,
  builder: (dialogContext) {           // ⬅ context ของ dialog เอง
    return AlertDialog(
      title: const Text('ยืนยันการหยุดเครื่อง?'),
      actions: [
        TextButton(
          // ✅ pop ด้วย dialogContext เพื่อปิด "dialog" ไม่ใช่ปิดหน้าหลัก
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('ยกเลิก'),
        ),
      ],
    );
  },
);
```

> ⚠️ **กฎทองของ context 4 ข้อ:**
> 1. `X.of(context)` มองขึ้นข้างบนเสมอ ไม่มองข้างล่างหรือข้าง ๆ
> 2. อยากได้ context ที่อยู่ลึกกว่า ให้คั่นด้วย `Builder` หรือแยกเป็น widget class ใหม่
> 3. หลัง `await` ต้องเช็ก `mounted` (หรือ `context.mounted` ใน Dart 3) ก่อนใช้ context เสมอ
> 4. ใน dialog/bottom sheet ให้ pop ด้วย context ของมันเอง จะได้ไม่ปิดผิด route

> ✅ **สรุปเชื่อม Module 1-3:** Widget Tree คือพิมพ์เขียว, Element Tree คือตัวจริงที่ถือ State และ **context ก็คือ Element** เมื่อเข้าใจสามต้นไม้ บั๊ก context ทุกตัวจะอธิบายได้ด้วยประโยคเดียวว่า "ยืนอยู่ตรงไหนของต้นไม้ตอนที่เรียก of()"

---

## 📚 Module 4: Layout Widgets + Responsive Layout สำหรับ Dashboard

### เวลา 13:00-13:50 น.

> 💡 **หัวใจของ Module นี้:** Layout ใน Flutter คือการเจรจาต่อรองระหว่าง parent กับ child ภายใต้กติกาเดียว: **"Constraints ไหลลง, Size ไหลขึ้น, Parent เป็นคนกำหนดตำแหน่ง"** เข้าใจประโยคนี้ประโยคเดียว ปัญหา overflow แถบเหลือง-ดำจะไม่ใช่เรื่องลึกลับอีกต่อไป

---

### 4.1 Column / Row - แกนหลักของทุกหน้าจอ

```dart
// โครงหน้า Dashboard เบื้องต้น: เรียงลงตามแนวตั้งด้วย Column
Column(
  crossAxisAlignment: CrossAxisAlignment.start, // ชิดซ้ายตามแกนขวาง
  children: [
    const Text('ภาพรวมการผลิตวันนี้'),
    const SizedBox(height: 12),                 // เว้นระยะแนวตั้ง
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // กระจายซ้าย-ขวา
      children: const [
        Text('อัปเดตล่าสุด 10:24 น.'),
        Icon(Icons.refresh),
      ],
    ),
  ],
);
```

| Property             | Column (แกนหลัก = แนวตั้ง)     | Row (แกนหลัก = แนวนอน)        |
| -------------------- | ------------------------------ | ----------------------------- |
| `mainAxisAlignment`  | จัดเรียงบน-ล่าง                | จัดเรียงซ้าย-ขวา              |
| `crossAxisAlignment` | จัดเรียงซ้าย-ขวา               | จัดเรียงบน-ล่าง               |
| `mainAxisSize`       | สูงเต็ม (`max`) หรือพอดี (`min`) | กว้างเต็ม (`max`) หรือพอดี (`min`) |
| overflow ที่พบบ่อย   | เนื้อหาสูงเกินจอ (ต้องใช้ scroll) | ข้อความ/ลูกกว้างเกิน (ต้องใช้ Expanded) |

### 4.2 Expanded vs Flexible - แบ่งพื้นที่ในแกนหลัก

```dart
Row(
  children: [
    // Expanded = บังคับลูกกินพื้นที่ที่เหลือ "เต็มโควตา" (flex)
    Expanded(
      flex: 2, // ได้ 2 ส่วน
      child: Container(height: 60, color: Colors.blue),
    ),
    Expanded(
      flex: 1, // ได้ 1 ส่วน
      child: Container(height: 60, color: Colors.orange),
    ),
    // Flexible = ให้โควตาเหมือนกัน แต่ลูก "เล็กกว่าโควตาได้" (fit: loose)
    Flexible(
      child: Container(height: 60, width: 40, color: Colors.green),
    ),
  ],
);
```

| ประเด็น            | `Expanded`                          | `Flexible` (fit: loose)                 |
| ------------------ | ----------------------------------- | --------------------------------------- |
| ขนาดลูก            | ถูกบังคับให้เต็มพื้นที่ที่จัดสรร     | ใหญ่สุดไม่เกินโควตา แต่เล็กกว่าได้       |
| ใช้บ่อยกับ         | แบ่งคอลัมน์ Dashboard, ดัน widget    | ข้อความยาวที่อยากให้หดได้ไม่ overflow    |
| ความสัมพันธ์       | `Expanded` = `Flexible(fit: FlexFit.tight)` | ค่า default คือ `FlexFit.loose`  |

> ⚠️ **แก้ overflow แนวนอนที่เจอบ่อยที่สุด:** `Text` ยาว ๆ ใน `Row` ให้ครอบด้วย `Expanded` แล้วใส่ `overflow: TextOverflow.ellipsis` - จบปัญหาแถบเหลืองดำ 90% ของมือใหม่

### 4.3 Stack - วาง widget ซ้อนกัน

เหมาะกับ badge สถานะบนรูปโรงไฟฟ้า หรือปุ่มลอยบนแผนที่:

```dart
Stack(
  children: [
    // ชั้นล่างสุด: ภาพโรงไฟฟ้า (ใช้สีแทนภาพจริงในตัวอย่าง)
    Container(height: 160, color: Colors.blueGrey.shade200),
    // ชั้นบน: ป้ายสถานะมุมขวาบน
    Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('ONLINE', style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
);
```

### 4.4 ListView.builder / GridView.builder - รายการยาวแบบประหยัดหน่วยความจำ

จุดสำคัญของ `.builder` คือ **Lazy Rendering**: Flutter สร้างเฉพาะรายการที่มองเห็นบนจอ (บวก buffer เล็กน้อย) เหมาะกับรายการโรงไฟฟ้า/รายงานที่อาจมีหลายร้อยแถว

```dart
// รายการโรงไฟฟ้า (ข้อมูลจำลอง)
final plants = List.generate(200, (i) => 'โรงไฟฟ้า Nam Theun หน่วยที่ ${i + 1}');

ListView.builder(
  itemCount: plants.length,           // จำนวนทั้งหมด
  itemBuilder: (context, index) {     // ถูกเรียกเฉพาะ index ที่กำลังจะแสดง
    return ListTile(
      leading: const Icon(Icons.factory),
      title: Text(plants[index]),
      trailing: const Icon(Icons.chevron_right),
    );
  },
);
```

```dart
// ตาราง Stat Card แบบ Grid สำหรับ Dashboard
GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,        // 2 คอลัมน์ (เดี๋ยวทำให้ responsive ใน 4.5)
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 1.4,    // อัตราส่วนกว้าง:สูงของการ์ด
  ),
  itemCount: 6,
  itemBuilder: (context, index) => Card(child: Center(child: Text('Card $index'))),
);
```

> ⚠️ **ห้ามทำ:** `ListView(children: [ทั้ง 200 แถว])` แบบไม่ใช้ builder กับข้อมูลจำนวนมาก เพราะจะสร้าง widget ทุกแถวทันทีตั้งแต่เฟรมแรก และห้ามวาง `ListView` เปล่า ๆ ใน `Column` ตรง ๆ (ความสูง unbounded) ให้ครอบด้วย `Expanded` เสมอ

### 4.5 Responsive Layout: MediaQuery vs LayoutBuilder

ผู้ใช้ของ EDL-Gen มีทั้งวิศวกรถือโทรศัพท์หน้างาน และหัวหน้ากะที่ดู Dashboard บน Tablet ในห้องควบคุม เราจึงต้องออกแบบให้ปรับตามความกว้างจอ:

| เครื่องมือ      | บอกอะไร                                   | เหมาะกับ                                 |
| --------------- | ------------------------------------------ | ---------------------------------------- |
| `MediaQuery`    | ขนาด "ทั้งจอ", padding ระบบ, orientation   | ตัดสินใจระดับทั้งหน้า/ทั้งแอป            |
| `LayoutBuilder` | constraints "ของพื้นที่ที่ widget นี้ได้รับ" | widget ที่ต้องปรับตัวตามพื้นที่ของตัวเอง |

```dart
// responsive_stat_grid.dart - Grid ที่เปลี่ยนจำนวนคอลัมน์ตามความกว้างพื้นที่จริง
class ResponsiveStatGrid extends StatelessWidget {
  const ResponsiveStatGrid({super.key, required this.cards});

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ตัดสินจาก "ความกว้างที่ widget นี้ได้จริง" ไม่ใช่ความกว้างจอ
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 900
            ? 4        // Tablet แนวนอน / Desktop
            : width >= 600
                ? 3    // Tablet แนวตั้ง
                : 2;   // โทรศัพท์

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) => cards[index],
        );
      },
    );
  }
}
```

```
โทรศัพท์ (< 600px)        Tablet ตั้ง (600-899px)      Tablet นอน (>= 900px)
┌──────┐ ┌──────┐        ┌────┐ ┌────┐ ┌────┐        ┌───┐ ┌───┐ ┌───┐ ┌───┐
│ MW   │ │ Hz   │        │ MW │ │ Hz │ │ kV │        │MW │ │Hz │ │kV │ │Alert│
└──────┘ └──────┘        └────┘ └────┘ └────┘        └───┘ └───┘ └───┘ └───┘
┌──────┐ ┌──────┐        ┌────┐ ┌────┐ ┌────┐
│ kV   │ │Alert │        │ ...│ │ ...│ │ ...│
└──────┘ └──────┘        └────┘ └────┘ └────┘
   2 คอลัมน์                  3 คอลัมน์                     4 คอลัมน์
```

---

### 🧪 Lab 4.1 - ทดสอบ Responsive Grid

> **เป้าหมาย:** เห็น Grid ปรับจำนวนคอลัมน์เองเมื่อหมุนจอ/ปรับขนาดหน้าต่าง

1. นำ `ResponsiveStatGrid` ไปตั้งเป็น `body` ของหน้า ใส่ `cards` เป็น `Card` จำลอง 8 ใบ
2. รันบน Emulator แล้วกดหมุนจอ (Ctrl+Left/Right บน Android Emulator) หรือรันแบบ `flutter run -d windows` / `-d chrome` แล้วลากปรับความกว้างหน้าต่าง

> ✅ **ผลลัพธ์ที่คาดหวัง:** จอแคบเห็น 2 คอลัมน์ พอขยายกว้างขึ้นเกิน 600px เปลี่ยนเป็น 3 และเกิน 900px เป็น 4 คอลัมน์โดยอัตโนมัติ ไม่มี overflow ใด ๆ

---

## 📚 Module 5: Custom Widgets + Composition Pattern

### เวลา 13:50-14:35 น.

> 💡 **หัวใจของ Module นี้:** Flutter ไม่สนับสนุนการสืบทอด (extends widget ของคนอื่น) แต่สนับสนุน **Composition**: ประกอบ widget เล็ก ๆ ที่ทำหน้าที่เดียว เป็น widget ที่ใหญ่ขึ้นเรื่อย ๆ - เราจะสร้าง widget ประจำโปรเจกต์ 3 ตัว (`StatCard`, `StatusBadge`, `AlertTile`) ที่จะถูกใช้ซ้ำตลอดทั้ง 3 วันที่เหลือ

---

### 5.1 หลักคิด: Composition over Inheritance + DRY

สัญญาณว่าถึงเวลาแยก Custom Widget:

1. **โค้ด UI ซ้ำกันเกิน 2 ที่** (DRY: Don't Repeat Yourself) เช่น การ์ดสถิติหน้า Dashboard กับหน้ารายงานหน้าตาเหมือนกัน
2. เมธอด `build` ยาวเกินหนึ่งหน้าจอ อ่านแล้วหลงว่า bracket ไหนคู่กับอะไร
3. ส่วนของ UI นั้นมี "ความหมายทางธุรกิจ" ของตัวเอง เช่น "ป้ายสถานะโรงไฟฟ้า" ควรมีชื่อเรียกในโค้ด ไม่ใช่ Container ปนกัน 15 บรรทัด

```
Composition ของหน้า Dashboard:

DashboardPage
├── ResponsiveStatGrid
│   ├── StatCard (กำลังผลิตรวม)
│   ├── StatCard (ความถี่ระบบ)
│   ├── StatCard (แรงดัน)
│   └── StatCard (โรงไฟฟ้าออนไลน์)
├── SectionHeader ("การแจ้งเตือนล่าสุด")
└── ListView.builder
    └── AlertTile ─── ภายในใช้ ─── StatusBadge
```

### 5.2 StatusBadge - ป้ายสถานะโรงไฟฟ้า

เริ่มจากตัวเล็กสุดก่อน: enum สถานะ + ป้ายสี ใช้ซ้ำได้ทุกหน้า

```dart
// lib/core/widgets/status_badge.dart
import 'package:flutter/material.dart';

/// สถานะการทำงานของโรงไฟฟ้า/เครื่องกำเนิดไฟฟ้า
enum PlantStatus {
  online('Online', 'เดินเครื่องปกติ'),
  offline('Offline', 'หยุดเดินเครื่อง'),
  maintenance('Maintenance', 'ซ่อมบำรุง');

  const PlantStatus(this.label, this.description);

  final String label;        // ข้อความบนป้าย
  final String description;  // คำอธิบายภาษาไทย (ใช้ใน tooltip/รายละเอียด)

  /// สีประจำสถานะ - รวม logic สีไว้ที่เดียว (DRY)
  Color get color => switch (this) {
        PlantStatus.online => const Color(0xFF16A34A),      // เขียว
        PlantStatus.offline => const Color(0xFFDC2626),     // แดง
        PlantStatus.maintenance => const Color(0xFFF59E0B), // ส้มเหลือง
      };
}

/// ป้ายสถานะทรงแคปซูล: จุดสี + ข้อความ ใช้ได้ทั้งใน Card, ListTile, AppBar
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.compact = false});

  final PlantStatus status;
  final bool compact; // โหมดย่อ: แสดงเฉพาะจุดสี (ใช้ในพื้นที่แคบ)

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: status.color, shape: BoxShape.circle),
    );

    if (compact) return Tooltip(message: status.description, child: dot);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.12),           // พื้นจางของสีสถานะ
        borderRadius: BorderRadius.circular(999),        // ทรงแคปซูล
        border: Border.all(color: status.color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // กว้างเท่าเนื้อหา ไม่กินเต็มแถว
        children: [
          dot,
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: status.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5.3 StatCard - การ์ดตัวเลขสถิติบน Dashboard

```dart
// lib/core/widgets/stat_card.dart
import 'package:flutter/material.dart';

/// การ์ดแสดงค่าสถิติ 1 ค่า เช่น กำลังผลิตรวม (MW), ความถี่ระบบ (Hz)
/// ออกแบบให้ generic: หน้า Dashboard และหน้ารายงานใช้ตัวเดียวกันได้
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    this.color,
    this.trend,      // ค่า % เปลี่ยนแปลง เช่น +2.4 หรือ -1.1 (null = ไม่แสดง)
    this.onTap,      // แตะการ์ดเพื่อดูรายละเอียด (null = แตะไม่ได้)
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color? color;
  final double? trend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = color ?? theme.colorScheme.primary;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แถวบน: ไอคอนในวงกลมสีจาง + ชื่อค่า
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 20, color: accent),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis, // กัน overflow บนจอแคบ
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // แถวล่าง: ตัวเลขใหญ่ + หน่วย + แนวโน้ม
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(unit, style: theme.textTheme.bodySmall),
                  ),
                  const Spacer(),
                  if (trend != null) _TrendChip(trend: trend!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ชิปแสดงแนวโน้มขึ้น/ลง - เป็น private widget ประกอบภายใน (Composition)
class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.trend});

  final double trend;

  @override
  Widget build(BuildContext context) {
    final up = trend >= 0;
    final color = up ? const Color(0xFF16A34A) : const Color(0xFFDC2626);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(up ? Icons.trending_up : Icons.trending_down, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          '${up ? '+' : ''}${trend.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
```

### 5.4 AlertTile - รายการแจ้งเตือนเหตุขัดข้อง

```dart
// lib/core/widgets/alert_tile.dart
import 'package:flutter/material.dart';
import 'status_badge.dart';

/// ระดับความรุนแรงของเหตุขัดข้อง
enum AlertSeverity {
  critical('วิกฤต', Color(0xFFDC2626), Icons.error),
  warning('เตือน', Color(0xFFF59E0B), Icons.warning_amber),
  info('แจ้งทราบ', Color(0xFF2563EB), Icons.info_outline);

  const AlertSeverity(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}

/// แถวแจ้งเตือนเหตุขัดข้อง 1 รายการ ใช้ทั้งหน้า Dashboard (ล่าสุด 5 รายการ)
/// และหน้ารายงาน (รายการเต็ม) - เขียนครั้งเดียวใช้สองที่ (DRY)
class AlertTile extends StatelessWidget {
  const AlertTile({
    super.key,
    required this.title,
    required this.plantName,
    required this.time,
    required this.severity,
    this.plantStatus,
    this.onTap,
  });

  final String title;          // เช่น 'แรงดันน้ำมันหล่อลื่นต่ำ Unit 2'
  final String plantName;      // เช่น 'โรงไฟฟ้า Nam Theun 2'
  final String time;           // เวลาแจ้งเตือน (ฟอร์แมตแล้ว)
  final AlertSeverity severity;
  final PlantStatus? plantStatus; // สถานะโรงไฟฟ้าขณะแจ้ง (แสดงเป็น badge)
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // ไอคอนความรุนแรงในกรอบสีจาง
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: severity.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(severity.icon, color: severity.color),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              plantName,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          if (plantStatus != null) ...[
            const SizedBox(width: 8),
            StatusBadge(status: plantStatus!, compact: true), // ⬅ Composition!
          ],
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            severity.label,
            style: TextStyle(
              fontSize: 11,
              color: severity.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5.5 นำไปใช้ - เห็นพลังของ Composition

```dart
// ใช้งานจริงบนหน้า Dashboard: อ่านออกทันทีว่าแต่ละบรรทัดคืออะไร
ResponsiveStatGrid(
  cards: const [
    StatCard(title: 'กำลังผลิตรวม', value: '1,271', unit: 'MW',
        icon: Icons.bolt, trend: 2.4),
    StatCard(title: 'ความถี่ระบบ', value: '50.02', unit: 'Hz',
        icon: Icons.speed, trend: -0.1),
    StatCard(title: 'แรงดันสายส่ง', value: '230', unit: 'kV',
        icon: Icons.electrical_services),
    StatCard(title: 'โรงไฟฟ้าออนไลน์', value: '9/10', unit: 'แห่ง',
        icon: Icons.factory, trend: 0.0),
  ],
);

AlertTile(
  title: 'อุณหภูมิ Bearing สูงผิดปกติ Unit 3',
  plantName: 'โรงไฟฟ้า Theun-Hinboun',
  time: '10:42',
  severity: AlertSeverity.critical,
  plantStatus: PlantStatus.maintenance,
  onTap: () {/* ไปหน้ารายละเอียด (ต่อใน Module 6) */},
);
```

> ✅ **สังเกต:** `AlertTile` ใช้ `StatusBadge` ข้างใน และ `StatCard` ใช้ `_TrendChip` ข้างใน - นี่คือ Composition Pattern: widget ใหญ่เกิดจาก widget เล็กที่ทดสอบแยกได้ แก้ที่เดียวมีผลทุกหน้า
> 📌 ทั้ง 3 widget รับข้อมูลผ่าน constructor ล้วน ๆ (Stateless ทั้งหมด) จึงพร้อมเสียบเข้ากับ Riverpod ใน Day 3 โดยไม่ต้องแก้อะไรเลย - แค่เปลี่ยน "แหล่งที่มา" ของค่าที่ส่งเข้า

---

## 📚 Module 6: Navigation + GoRouter

### เวลา 14:35-15:20 น.

> 💡 **หัวใจของ Module นี้:** Navigator 1.0 (`push`/`pop`) เหมาะกับแอปเล็ก แต่แอปองค์กรต้องการ URL-based routing ที่รองรับ Deep Link, Route Guard และ Bottom Navigation ที่รักษา state ของแต่ละแท็บ - **GoRouter** คือ package มาตรฐานที่ทีม Flutter ดูแลเอง และเราจะใช้เป็นแกน Navigation ของ `edlgen_monitoring` ตลอดหลักสูตร

---

### 6.1 ติดตั้งและตั้งค่าพื้นฐาน

```bash
flutter pub add go_router
```

```dart
// lib/core/router/app_router.dart - ประกาศ route ทั้งแอปไว้ที่เดียว
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',       // หน้าแรกเมื่อเปิดแอป
  debugLogDiagnostics: true,       // log การนำทางลง console (ปิดตอน production)
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',               // Named Route: อ้างชื่อแทน path ยาว ๆ
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
      routes: [
        // Nested route: /dashboard/plant/:id (รายละเอียดโรงไฟฟ้า)
        GoRoute(
          path: 'plant/:id',       // :id คือ path parameter
          name: 'plant-detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!; // ดึงค่าจาก URL
            return PlantDetailPage(plantId: id);
          },
        ),
      ],
    ),
  ],
);
```

```dart
// main.dart - เปลี่ยนจาก MaterialApp เป็น MaterialApp.router
return MaterialApp.router(
  title: 'EDL-Gen Monitoring',
  routerConfig: appRouter,   // ⬅ ส่ง GoRouter เข้าแอป
);
```

### 6.2 คำสั่งนำทางที่ใช้บ่อย

| คำสั่ง                                        | พฤติกรรม                                              | ใช้เมื่อ                          |
| --------------------------------------------- | ------------------------------------------------------ | --------------------------------- |
| `context.go('/dashboard')`                    | **แทนที่** stack ทั้งหมดด้วยปลายทาง                    | Login สำเร็จ, สลับแท็บหลัก        |
| `context.push('/dashboard/plant/3')`          | **ซ้อน** หน้าใหม่บน stack (กด back กลับมาได้)          | เปิดหน้ารายละเอียดจากรายการ       |
| `context.pop()`                               | ถอยกลับหนึ่งหน้า                                       | ปุ่มยกเลิก/เสร็จสิ้น              |
| `context.goNamed('plant-detail', pathParameters: {'id': '3'})` | ไปตาม **ชื่อ** route (ไม่ต้องจำ path) | โปรเจกต์ใหญ่ path เปลี่ยนบ่อย     |

> ⚠️ **go vs push จำง่าย ๆ:** `go` = "ย้ายบ้าน" (URL เปลี่ยน stack ถูกจัดใหม่), `push` = "แวะเข้าไปอีกห้อง" (ถอยกลับได้) - ถ้าหลัง Login ใช้ `push('/dashboard')` ผู้ใช้จะกด back กลับไปหน้า Login ได้ ซึ่งเป็นบั๊ก UX ที่พบบ่อยมาก ให้ใช้ `go` เสมอในจุดนั้น

### 6.3 Route Guard (Auth Check) ด้วย redirect

GoRouter ให้เราเขียน logic ตรวจสิทธิ์ที่ประตูทางเข้าเพียงจุดเดียว ครอบคลุมทุก route รวมถึง Deep Link:

```dart
// จำลองสถานะ auth ง่าย ๆ ก่อน (Day 4 จะเปลี่ยนเป็น AuthCubit + Token จริง)
class FakeAuthService {
  static bool isLoggedIn = false;
}

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  redirect: (context, state) {
    final loggedIn = FakeAuthService.isLoggedIn;
    final goingToLogin = state.matchedLocation == '/login';

    // ยังไม่ล็อกอิน + จะไปหน้าอื่นที่ไม่ใช่ login → เด้งไป login
    if (!loggedIn && !goingToLogin) return '/login';

    // ล็อกอินแล้ว + จะไปหน้า login → เด้งเข้า dashboard เลย
    if (loggedIn && goingToLogin) return '/dashboard';

    return null; // null = ปล่อยผ่านตามปกติ
  },
  routes: [ /* ...เหมือนเดิม... */ ],
);
```

```
ผู้ใช้พยายามเปิด /reports (จาก Deep Link ก็ได้)
        │
        ▼
   redirect ถูกเรียกก่อนเสมอ
        │
        ├── ยังไม่ล็อกอิน ──▶ เด้งไป /login (จำปลายทางไว้ต่อยอดได้ด้วย query)
        │
        └── ล็อกอินแล้ว   ──▶ เข้า /reports ตามปกติ
```

### 6.4 Deep Link

เพราะ GoRouter เป็น URL-based ทุกหน้าจึงมี "ที่อยู่" ของตัวเอง เมื่อระบบแจ้งเตือน (Push Notification ใน Day 5) ส่งลิงก์ `edlgen://app/dashboard/plant/7` มา แอปจะเปิดตรงไปหน้ารายละเอียดโรงไฟฟ้าหมายเลข 7 ได้ทันที โดย Route Guard ยังทำงานปกติ (ถ้ายังไม่ล็อกอินก็เด้งไป Login ก่อน)

การตั้งค่าฝั่ง Android เพิ่ม intent-filter ใน `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- ภายใน <activity> หลัก -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- รองรับ scheme เฉพาะแอป: edlgen://app/... -->
    <data android:scheme="edlgen" android:host="app" />
</intent-filter>
```

ทดสอบ Deep Link บน Emulator ด้วย adb:

```bash
adb shell am start -a android.intent.action.VIEW -d "edlgen://app/dashboard/plant/7"
```

### 6.5 Bottom Navigation ด้วย StatefulShellRoute

โจทย์คลาสสิก: มี Bottom Navigation 3 แท็บ (Dashboard / รายงาน / ตั้งค่า) โดย **แต่ละแท็บต้องจำ state และตำแหน่ง scroll ของตัวเอง** เมื่อสลับไปมา - GoRouter แก้ด้วย `StatefulShellRoute.indexedStack`:

```dart
// โครง route แบบมี Shell (แถบล่าง) - เวอร์ชันเต็มอยู่ใน Lab ท้ายวัน
StatefulShellRoute.indexedStack(
  // builder สร้าง "เปลือก" ที่มี BottomNavigationBar ห่อทุกแท็บ
  builder: (context, state, navigationShell) {
    return AppShell(navigationShell: navigationShell);
  },
  branches: [
    // แต่ละ branch = 1 แท็บ มี Navigator stack ของตัวเอง
    StatefulShellBranch(routes: [
      GoRoute(path: '/dashboard', name: 'dashboard',
          builder: (context, state) => const DashboardPage()),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(path: '/reports', name: 'reports',
          builder: (context, state) => const ReportsPage()),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(path: '/settings', name: 'settings',
          builder: (context, state) => const SettingsPage()),
    ]),
  ],
);
```

```dart
// lib/core/router/app_shell.dart - เปลือกแอปที่ถือ BottomNavigationBar
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // เนื้อหาของแท็บปัจจุบัน (IndexedStack ภายใน)
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // แตะแท็บเดิมซ้ำ = กลับหน้าแรกของแท็บนั้น (พฤติกรรมมาตรฐานมือถือ)
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.description_outlined),
              selectedIcon: Icon(Icons.description), label: 'รายงาน'),
          NavigationDestination(icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings), label: 'ตั้งค่า'),
        ],
      ),
    );
  }
}
```

> ✅ **จุดแข็งของ StatefulShellRoute:** แต่ละ branch มี Navigator ของตัวเอง สลับแท็บแล้ว **scroll position และหน้าที่ push ค้างไว้ไม่หาย** ต่างจากการเปลี่ยน `body` เองด้วย setState ที่ state จะถูกรื้อทุกครั้ง
> 📌 หน้า Login อยู่ **นอก** Shell (ไม่มีแถบล่าง) ส่วน 3 แท็บอยู่ใน Shell - เดี๋ยวประกอบจริงทั้งไฟล์ใน Lab

---

## 🛠️ Lab วันที่ 2 - สร้าง Flutter App Skeleton: `edlgen_monitoring`

### เวลา 15:20-16:30 น.

> **โจทย์:** สร้างโครงแอป EDL-Gen Monitoring ที่มี 4 หน้า (Login, Dashboard, รายงาน, ตั้งค่า) ใช้ GoRouter พร้อม Route Guard และ Bottom Navigation, จัดโครงสร้างแบบ Feature-first และใช้ Custom Widget จาก Module 5 ครบทั้ง 3 ตัว - ทุกหน้าเป็น Mockup ด้วยข้อมูลจำลอง (Day 3 จะต่อ API จริง)

### ขั้นที่ 1 - สร้างโปรเจกต์และติดตั้ง package

```bash
# กำหนด --org ตั้งแต่ต้น เพื่อได้ applicationId ที่เหมาะสม
flutter create --org com.itgenius edlgen_monitoring
cd edlgen_monitoring

# ติดตั้ง package ที่ใช้วันนี้ (Riverpod จะเพิ่มพรุ่งนี้)
flutter pub add go_router google_fonts

# ทดสอบว่ารันได้ก่อนแก้อะไร
flutter run
```

### ขั้นที่ 2 - วางโครงสร้างโฟลเดอร์แบบ Feature-first

```
lib/
├── main.dart                              ← จุดเริ่ม + MaterialApp.router + Theme
├── core/
│   ├── router/
│   │   ├── app_router.dart                ← GoRouter + redirect (Auth Guard)
│   │   └── app_shell.dart                 ← Scaffold + NavigationBar (Shell)
│   ├── services/
│   │   └── fake_auth_service.dart         ← สถานะล็อกอินจำลอง (แทนที่ใน Day 4)
│   └── widgets/                           ← Custom Widget ใช้ร่วมทุก feature
│       ├── stat_card.dart
│       ├── status_badge.dart
│       └── alert_tile.dart
└── features/
    ├── auth/
    │   └── presentation/
    │       └── login_page.dart
    ├── dashboard/
    │   └── presentation/
    │       ├── dashboard_page.dart
    │       └── widgets/
    │           └── responsive_stat_grid.dart
    ├── reports/
    │   └── presentation/
    │       └── reports_page.dart
    └── settings/
        └── presentation/
            └── settings_page.dart
```

สร้างโฟลเดอร์ทั้งหมดในคำสั่งเดียว (PowerShell):

```powershell
mkdir lib/core/router, lib/core/services, lib/core/widgets,
      lib/features/auth/presentation,
      lib/features/dashboard/presentation/widgets,
      lib/features/reports/presentation,
      lib/features/settings/presentation
```

> 📌 โครงนี้คือโครงเดียวกับที่จะใช้ถึง Day 5: พรุ่งนี้แต่ละ feature จะได้โฟลเดอร์ `data/` (Repository + API) และ `providers/` (Riverpod) เพิ่มเข้ามา โดยไม่ต้องรื้อของวันนี้เลย

### ขั้นที่ 3 - คัดลอก Custom Widget ทั้ง 3 ตัว

นำโค้ดเต็มจาก Module 5 มาวางลงไฟล์ตามตำแหน่ง:

- `lib/core/widgets/status_badge.dart` (หัวข้อ 5.2 - รวม enum `PlantStatus`)
- `lib/core/widgets/stat_card.dart` (หัวข้อ 5.3)
- `lib/core/widgets/alert_tile.dart` (หัวข้อ 5.4 - รวม enum `AlertSeverity`)

และนำ `ResponsiveStatGrid` จากหัวข้อ 4.5 ไปวางที่ `lib/features/dashboard/presentation/widgets/responsive_stat_grid.dart`

### ขั้นที่ 4 - บริการ Auth จำลอง

```dart
// lib/core/services/fake_auth_service.dart
/// สถานะล็อกอินจำลองสำหรับ Day 2 - เก็บในหน่วยความจำเฉย ๆ
/// Day 4 จะแทนที่ด้วย AuthCubit + flutter_secure_storage + Sanctum Token จริง
class FakeAuthService {
  FakeAuthService._(); // ปิด constructor - ใช้แบบ static ล้วน

  static bool isLoggedIn = false;

  static bool login(String username, String password) {
    // เกณฑ์จำลอง: รหัสผ่านอย่างน้อย 4 ตัวอักษร
    final ok = username.isNotEmpty && password.length >= 4;
    isLoggedIn = ok;
    return ok;
  }

  static void logout() => isLoggedIn = false;
}
```

### ขั้นที่ 5 - หน้า Login

```dart
// lib/features/auth/presentation/login_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/fake_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true; // ตัวอย่าง state เฉพาะที่ ที่ setState เหมาะสมที่สุด

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final ok = FakeAuthService.login(_userCtrl.text, _passCtrl.text);
    if (ok) {
      // ใช้ go (ไม่ใช่ push) - ผู้ใช้กด back แล้วต้องไม่กลับมาหน้า Login
      context.go('/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(  // กัน overflow ตอนคีย์บอร์ดเด้งขึ้น
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420), // สวยบน tablet
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt, size: 72, color: Color(0xFF1855A3)),
                  const SizedBox(height: 8),
                  Text('EDL-Gen Monitoring',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const Text('ระบบติดตามการผลิตไฟฟ้า (ข้อมูลจำลอง)'),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _userCtrl,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'กรุณากรอกชื่อผู้ใช้' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off),
                        // state เฉพาะที่ของหน้าเดียว → setState เหมาะสมแล้ว
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) => (v == null || v.length < 4)
                        ? 'รหัสผ่านอย่างน้อย 4 ตัวอักษร'
                        : null,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('เข้าสู่ระบบ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### ขั้นที่ 6 - หน้า Dashboard (Mockup)

```dart
// lib/features/dashboard/presentation/dashboard_page.dart
import 'package:flutter/material.dart';
import '../../../core/widgets/alert_tile.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/status_badge.dart';
import 'widgets/responsive_stat_grid.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: StatusBadge(status: PlantStatus.online)),
          ),
        ],
      ),
      body: ListView(
        children: [
          // ส่วนที่ 1: การ์ดสถิติแบบ responsive (ข้อมูลจำลอง)
          SizedBox(
            height: 280,
            child: ResponsiveStatGrid(
              cards: const [
                StatCard(title: 'กำลังผลิตรวม', value: '1,271', unit: 'MW',
                    icon: Icons.bolt, trend: 2.4),
                StatCard(title: 'ความถี่ระบบ', value: '50.02', unit: 'Hz',
                    icon: Icons.speed, trend: -0.1),
                StatCard(title: 'แรงดันสายส่ง', value: '230', unit: 'kV',
                    icon: Icons.electrical_services),
                StatCard(title: 'โรงไฟฟ้าออนไลน์', value: '9/10', unit: 'แห่ง',
                    icon: Icons.factory, trend: 0.0),
              ],
            ),
          ),
          // ส่วนที่ 2: หัวข้อแจ้งเตือนล่าสุด
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('การแจ้งเตือนล่าสุด',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          // ส่วนที่ 3: รายการแจ้งเตือนจำลอง 3 รายการ
          AlertTile(
            title: 'อุณหภูมิ Bearing สูงผิดปกติ Unit 3',
            plantName: 'โรงไฟฟ้า Theun-Hinboun',
            time: '10:42',
            severity: AlertSeverity.critical,
            plantStatus: PlantStatus.maintenance,
            onTap: () {},
          ),
          AlertTile(
            title: 'แรงดันน้ำมันหล่อลื่นต่ำกว่าเกณฑ์ Unit 2',
            plantName: 'โรงไฟฟ้า Nam Theun 2',
            time: '09:58',
            severity: AlertSeverity.warning,
            plantStatus: PlantStatus.online,
            onTap: () {},
          ),
          AlertTile(
            title: 'กำหนดซ่อมบำรุงประจำเดือน Unit 1',
            plantName: 'โรงไฟฟ้า Houay Ho',
            time: '08:30',
            severity: AlertSeverity.info,
            plantStatus: PlantStatus.online,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
```

### ขั้นที่ 7 - หน้ารายงาน และหน้าตั้งค่า (Mockup)

```dart
// lib/features/reports/presentation/reports_page.dart
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // รายงานจำลอง 30 วันย้อนหลัง - Day 3 จะดึงจาก Laravel API จริง
    final today = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('รายงานการผลิต')),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          final date = today.subtract(Duration(days: index));
          final mwh = 28000 + (index * 137) % 4500; // ตัวเลขจำลอง
          return ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text('รายงานประจำวันที่ '
                '${date.day}/${date.month}/${date.year + 543}'),
            subtitle: Text('พลังงานรวม $mwh MWh'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}
```

```dart
// lib/features/settings/presentation/settings_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/fake_auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่า')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('ผู้ใช้งาน'),
            subtitle: Text('engineer01 (ข้อมูลจำลอง)'),
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('ภาษา'),
            subtitle: Text('ไทย / ລາວ / English'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('ออกจากระบบ', style: TextStyle(color: Colors.red)),
            onTap: () {
              FakeAuthService.logout();
              // go ไป login - Route Guard จะกันไม่ให้ย้อนกลับเข้ามาอีก
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
```

### ขั้นที่ 8 - ประกอบ Router ฉบับเต็ม (Guard + Shell)

```dart
// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/fake_auth_service.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/reports/presentation/reports_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import 'app_shell.dart';

// key แยกของ root navigator กับ shell navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  debugLogDiagnostics: true,

  // 🔐 Route Guard: ทำงานกับทุกการนำทาง รวมถึง Deep Link
  redirect: (context, state) {
    final loggedIn = FakeAuthService.isLoggedIn;
    final goingToLogin = state.matchedLocation == '/login';

    if (!loggedIn && !goingToLogin) return '/login';
    if (loggedIn && goingToLogin) return '/dashboard';
    return null;
  },

  routes: [
    // หน้า Login อยู่นอก Shell (ไม่มีแถบนำทางล่าง)
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    // 3 แท็บหลักอยู่ใน StatefulShellRoute
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
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ]),
      ],
    ),
  ],
);
```

จากนั้นสร้าง `lib/core/router/app_shell.dart` โดยใช้โค้ด `AppShell` ฉบับเต็มจากหัวข้อ 6.5 ได้เลย (ไม่ต้องแก้อะไร)

### ขั้นที่ 9 - main.dart และ Theme

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const EdlGenApp());
}

class EdlGenApp extends StatelessWidget {
  const EdlGenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EDL-Gen Monitoring',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1855A3), // น้ำเงินองค์กร
        // ฟอนต์รองรับไทย/ลาว - Noto Sans Thai ครอบคลุมอักขระที่ใช้ในหลักสูตร
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
      ),
      routerConfig: appRouter,
    );
  }
}
```

### ขั้นที่ 10 - รันและทดสอบครบวงจร

```bash
flutter run
```

ไล่ทดสอบตาม checklist:

| # | การทดสอบ                                                   | ผลที่ต้องได้                                        |
| - | ----------------------------------------------------------- | ---------------------------------------------------- |
| 1 | เปิดแอปครั้งแรก (ยังไม่ล็อกอิน)                              | Guard เด้งจาก `/dashboard` ไปหน้า Login อัตโนมัติ    |
| 2 | กรอกรหัสผ่านสั้นกว่า 4 ตัว แล้วกดเข้าสู่ระบบ                 | Validator ขึ้นข้อความเตือนใต้ช่อง                    |
| 3 | ล็อกอินสำเร็จ                                                | เข้า Dashboard เห็น StatCard 4 ใบ + AlertTile 3 แถว  |
| 4 | กดปุ่ม back ของเครื่องหลังล็อกอิน                            | แอปไม่ย้อนกลับไปหน้า Login (เพราะใช้ `go`)           |
| 5 | สลับแท็บ รายงาน → เลื่อน list ลงล่าง → ไปแท็บอื่น → กลับมา   | ตำแหน่ง scroll เดิมยังอยู่ (พลัง IndexedStack)       |
| 6 | หมุนจอ / ปรับความกว้างหน้าต่าง                               | StatCard Grid ปรับ 2/3/4 คอลัมน์ตามความกว้าง         |
| 7 | แท็บตั้งค่า → ออกจากระบบ → พิมพ์ URL หรือ deep link เข้า /reports | ถูกเด้งกลับหน้า Login (Guard ทำงาน)             |

> ✅ **ผลลัพธ์ที่คาดหวังของ Lab:** แอป `edlgen_monitoring` รันได้จริงครบ 4 หน้า, Navigation ลื่นไหล, Guard ทำงานถูกต้อง และมี Custom Widget ครบ 3 ตัว (`StatCard`, `StatusBadge`, `AlertTile`) ทำงานบนหน้า Dashboard - โครงนี้คือฐานที่ Day 3 จะ "เสียบข้อมูลจริง" จาก Laravel API เข้ามาแทน Mockup
> 💾 อย่าลืม commit: `git init && git add . && git commit -m "Day 2: app skeleton with navigation and custom widgets"`

---

## 📝 สรุปประจำวันที่ 2

| หัวข้อ                  | ประเด็นที่ต้องจำ                                                                                    |
| ----------------------- | ---------------------------------------------------------------------------------------------------- |
| สามต้นไม้               | Widget = พิมพ์เขียวราคาถูก, Element = ตัวกลางถือ State, RenderObject = ตัววาดที่ถูก reuse - จึง rebuild เร็ว |
| const & แยก class       | `const` ข้ามการ rebuild ทั้งกิ่ง, แยก widget เป็น class (ไม่ใช่เมธอด) เพื่อจำกัดวง rebuild            |
| Stateless vs Stateful   | เริ่มจาก Stateless เสมอ ใช้ Stateful เฉพาะ state เฉพาะที่ เช่น toggle รหัสผ่าน, Form controller       |
| ปัญหาของ setState ล้วน ๆ | State กองที่ยอด, Prop-drilling หลายชั้น, rebuild ทั้งหน้า, แชร์ข้ามหน้าไม่ได้ → คำตอบคือ Riverpod (Day 3) |
| BuildContext            | context = ตำแหน่งใน Element Tree, `of()` มองขึ้นเท่านั้น, หลัง `await` ต้องเช็ก `mounted`             |
| Layout                  | Constraints ลง Size ขึ้น, Expanded/Flexible แบ่งพื้นที่, `.builder` สำหรับรายการยาว, LayoutBuilder ทำ responsive |
| Custom Widget           | Composition + DRY: `StatusBadge` ประกอบใน `AlertTile`, ทุกตัวเป็น Stateless รับค่าผ่าน constructor     |
| GoRouter                | `go` แทนที่ stack / `push` ซ้อน, `redirect` คือ Guard จุดเดียวคุมทุกทาง, StatefulShellRoute รักษา state ต่อแท็บ |

**สิ่งที่ได้ติดมือกลับไปวันนี้:**

1. โปรเจกต์ `edlgen_monitoring` ที่รันได้จริง ครบ 4 หน้า พร้อมโครง Feature-first
2. Custom Widget 3 ตัวที่จะใช้ต่อทุกวันจนจบหลักสูตร
3. ความเข้าใจ "ปัญหาของ setState" ซึ่งเป็นบันไดขั้นแรกสู่ State Management จริงจัง

---

## ✅ ตรวจสอบความพร้อมก่อนวันพรุ่งนี้ (Day 3: Riverpod 3.0 พื้นฐาน)

พรุ่งนี้เราจะเรียน **Riverpod 3.0: Provider Types & Consumer Patterns** และเชื่อม `edlgen_monitoring` เข้ากับ `edlgen_api` จริง ให้ตรวจสอบก่อนกลับ (หรือคืนนี้):

- [ ] โปรเจกต์ `edlgen_monitoring` จาก Lab วันนี้รันผ่าน `flutter run` โดยไม่มี error และ commit เข้า git แล้ว
- [ ] Checklist ทั้ง 7 ข้อของ Lab ผ่านครบ (โดยเฉพาะข้อ 4 และข้อ 7 เรื่อง Guard)
- [ ] Laravel `edlgen_api` (Day 1) ยังรันได้ด้วย `php artisan serve` และ endpoint `/api/v1/health` ตอบปกติ
- [ ] ทดลองยิง Login API ของ Day 1 ด้วย Postman/Bruno อีกครั้ง และจดค่า Token ที่ได้ไว้
- [ ] ติดตั้ง package ล่วงหน้าเพื่อประหยัดเวลา (ทำในโฟลเดอร์ `edlgen_monitoring`):

```bash
flutter pub add flutter_riverpod riverpod_annotation dio
flutter pub add dev:build_runner dev:riverpod_generator dev:custom_lint dev:riverpod_lint
```

- [ ] ทดสอบว่า `dart run build_runner build --delete-conflicting-outputs` รันจบโดยไม่มี error (ยังไม่ต้องมีไฟล์ `@riverpod` ก็รันได้ จะขึ้นว่าไม่มีอะไรให้ build ซึ่งถือว่าผ่าน)
- [ ] ทบทวนหัวข้อ 2.3-2.4 (ปัญหาของ setState) เพราะพรุ่งนี้เช้าเราจะ refactor ตัวอย่างนั้นด้วย Riverpod เป็นเรื่องแรก

> 📌 **เครื่องใครรัน Emulator ช้า:** แนะนำเปิด Emulator ทิ้งไว้ก่อนเริ่มเรียน 09:30 น. หรือใช้เครื่องจริงเสียบสาย USB (เปิด Developer Options + USB Debugging) จะ hot reload เร็วกว่ามาก

---

## 📖 เอกสารอ้างอิงและแหล่งเรียนรู้เพิ่มเติม

**เอกสารทางการ:**

- Flutter Architectural Overview (สามต้นไม้): docs.flutter.dev/resources/architectural-overview
- Widget Catalog และ Layout: docs.flutter.dev/ui/widgets และ docs.flutter.dev/ui/layout
- Understanding Constraints (บทความบังคับอ่านเรื่อง layout): docs.flutter.dev/ui/layout/constraints
- StatefulWidget Lifecycle และ State class: api.flutter.dev/flutter/widgets/State-class.html
- BuildContext: api.flutter.dev/flutter/widgets/BuildContext-class.html
- Adaptive & Responsive Design: docs.flutter.dev/ui/adaptive-responsive

**Package ที่ใช้วันนี้:**

- go_router (เอกสาร + ตัวอย่าง StatefulShellRoute): pub.dev/packages/go_router
- google_fonts: pub.dev/packages/google_fonts
- Deep Linking บน Android/iOS: docs.flutter.dev/ui/navigation/deep-linking

**เตรียมตัวสำหรับ Day 3:**

- Riverpod เอกสารทางการ: riverpod.dev
- flutter_riverpod: pub.dev/packages/flutter_riverpod
- dio (HTTP client ที่จะใช้เรียก Laravel API): pub.dev/packages/dio

**เครื่องมือช่วยเรียนรู้:**

- DartPad ทดลองโค้ดในเบราว์เซอร์: dartpad.dev
- Flutter DevTools (ดู Widget Tree จริงของแอป): docs.flutter.dev/tools/devtools

---

*เอกสารประกอบการอบรม Basic to Advanced Laravel 13 and Flutter Framework (MOB-15) - วันที่ 2/5*
*สถาบันไอทีจีเนียส เอ็นจิเนียริ่ง | www.itgenius.co.th | จัดอบรมให้ EDL-Generation Public Company*
