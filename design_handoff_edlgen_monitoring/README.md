# Handoff: EDL-Gen Monitoring App

## Overview
แพ็กเกจนี้คือ **แบบดีไซน์ (design reference)** ของแอป **EDL-Gen Monitoring** — แอปมอนิเตอร์การผลิตไฟฟ้าสำหรับ EDL-Generation Public Company (สปป.ลาว) รองรับทั้ง Android และ iOS เป็นแอป 3 ภาษา (ลาว-ไทย-อังกฤษ) ค่าเริ่มต้นเป็นภาษาลาว

ครอบคลุม 5 Feature หลักตามสเปกใน `Day5_note.md`:
1. Login & Auth Flow (Cubit + Laravel Sanctum)
2. Real-time Power Dashboard (StreamProvider + WebSocket/Reverb)
3. รายงานการผลิตรายวัน + Offline Cache (AsyncNotifier + sqflite)
4. แจ้งเหตุขัดข้องเครื่องจักร (Riverpod Mutations + รูป + GPS)
5. บันทึกค่ามิเตอร์ (Cubit + Optimistic Update)

## About the Design Files
ไฟล์ในแพ็กเกจนี้เป็น **แบบอ้างอิงที่สร้างด้วย HTML** (prototype ที่แสดงหน้าตาและพฤติกรรมที่ตั้งใจไว้) — **ไม่ใช่โค้ด production ที่จะ copy ไปใช้ตรง ๆ** งานคือ **สร้างดีไซน์เหล่านี้ขึ้นใหม่ใน Flutter** โดยใช้ pattern/ไลบรารีตามที่วางไว้ในโปรเจกต์จริง (Riverpod 3.0 + flutter_bloc, GoRouter, Dio, fl_chart, sqflite, flutter_secure_storage) — โครงสร้างและตรรกะฝั่ง backend/state อยู่ในไฟล์ `Day5_note.md` ที่แนบมา

> เปิด `EDL-Gen Prototype.html` ในเบราว์เซอร์เพื่อคลิกดูทุกหน้าแบบโต้ตอบได้ (สลับภาษา / iOS-Android / Light-Dark)

## Fidelity
**High-fidelity (hifi)** — สี ตัวอักษร ระยะห่าง และ interaction เป็นค่าจริงที่ตั้งใจใช้ ให้สร้าง UI ให้ตรงตามนี้ด้วยไลบรารีของโปรเจกต์ ค่าโทเคนทั้งหมดอยู่ในหัวข้อ Design Tokens ด้านล่าง และในไฟล์ `EDL-Gen Design System.html`

## ฟอนต์ (สำคัญ — 3 ภาษา)
| ภาษา | ฟอนต์ | หมายเหตุ |
|------|-------|----------|
| ลาว (default) | **Phetsarath OT** | ฟอนต์ราชการ สปป.ลาว — ฝังไฟล์ `.ttf` ใน `assets/fonts/` (mockup ใช้ Noto Sans Lao เป็น web fallback) |
| ไทย | **Anuphan** | `google_fonts: GoogleFonts.anuphan()` |
| อังกฤษ + ตัวเลข/หน่วย | **Inter** | ตัวเลข MW/Hz/kV/kWh และวันที่ ใช้ Inter เสมอทุกภาษา |

Flutter: ใช้ `easy_localization` + ไฟล์ `lo.json` / `th.json` / `en.json` แล้วสลับ `fontFamily` ตาม locale ผ่าน `ThemeData` (คีย์แปลภาษาทั้งหมดอยู่ในอ็อบเจกต์ `T` ในไฟล์ `edl-screens.jsx`)

## Icons
**Hugeicons Stroke Rounded** (แพ็กเกจฟรี) — `flutter pub add hugeicons` แล้วเรียก `HugeIcon(icon: HugeIcons.strokeRounded<Name>, ...)` ตารางการแมป icon → Flutter constant อยู่ในหัวข้อ 03 ของ `EDL-Gen Design System.html` · stroke 1.5 · viewBox 24×24

## Screens / Views
รวม 16 หน้า (แต่ละหน้าออกแบบทั้ง iOS + Android)

1. **Splash** — โลโก้กลางจอบนพื้นไล่เฉดน้ำเงิน + spinner · แตะเพื่อไป Login
2. **Login** — โลโก้ + segmented สลับภาษา (ລาว/ไทย/EN) + ช่องอีเมล/รหัสผ่าน (มีปุ่มตา) + ลิงก์ลืมรหัสผ่าน + ปุ่มเข้าสู่ระบบ
3. **Forgot password** — ไอคอนกุญแจ + ช่องอีเมล + ปุ่มส่งลิงก์รีเซ็ต + หมายเหตุหมดอายุ 15 นาที
4. **Dashboard** — greeting header + การ์ด real-time (MW รวม + Hz/kV/น้ำ, ป้าย LIVE) + กราฟเส้น 30 ค่าล่าสุด + รายการโรงผลิต (คลิกดูรายละเอียด) + bottom nav
5. **Dashboard (Dark)** — เวอร์ชันโหมดมืดของหน้า 4
6. **Reports** — banner Offline (เหลือง) + filter bar (ช่วงวันที่ + โรงผลิต) + การ์ดรายงานรายวัน (คลิกได้)
7. **Date range picker** — ปฏิทินเดือน + ช่วงด่วน (7/30 วัน, เดือนนี้) + From/To + ปุ่ม Apply
8. **Incident form** — plant dropdown + หัวข้อ + รายละเอียด (textarea) + severity picker 4 ระดับ + กล่องถ่ายรูป + แถบ GPS + ปุ่มส่ง
9. **Camera** — วิวไฟน์เดอร์เต็มจอ + กรอบมุม + ป้ายพิกัด + ปุ่มชัตเตอร์/คลังรูป/สลับกล้อง
10. **GPS map** — แผนที่เต็มจอ + หมุด + วงความแม่นยำ + bottom sheet พิกัด + ปุ่มใช้ตำแหน่งนี้
11. **Incident detail** — badge สถานะ + รูป + ตารางข้อมูล + คำอธิบาย + timeline (Reported→Acknowledged→In progress→Resolved)
12. **Meter reading** — ช่องรหัสมิเตอร์ + ค่า kWh + ปุ่มบันทึก (ทอง) + รายการบันทึกวันนี้ (pending/confirmed, คลิกได้)
13. **Meter detail** — ค่าที่อ่านใหญ่ + สถานะ + ค่าก่อนหน้า/ผลต่าง/ผู้บันทึก/เวลา
14. **Notifications** — จัดกลุ่ม วันนี้/เมื่อวาน + รายการแจ้งเตือน (critical คลิกไป incident detail)
15. **Plant detail** — การ์ด output + ค่าสด + พลังงานวันนี้/ความพร้อมจ่าย + กราฟ
16. **Profile & Settings** — การ์ดโปรไฟล์ + เมนูภาษา (คลิกวนภาษา) + toggle dark mode/แจ้งเตือน + ปุ่มออกจากระบบ

รายละเอียด layout/ระยะ/สี ของทุก component ดูได้จาก `edl-screens.jsx` (แต่ละหน้าคือฟังก์ชัน `scr_<name>`) และ `EDL-Gen Design System.html`

## Interactions & Behavior
- **Navigation**: GoRouter + Route Guard (redirect เมื่อไม่มี Token/Token หมดอายุ → Login) ดูโค้ดตัวอย่างใน `Day5_note.md` (Feature 1)
- **Splash → Login → Dashboard**; bottom nav 5 แท็บ (Dashboard/Reports/Incident(กลาง)/Meter/Profile)
- **Real-time**: WebSocket (Reverb, Pusher protocol) push ค่าใหม่ทุก 3 วิ → StreamProvider → กราฟเลื่อน (ไม่มี polling)
- **Offline**: ดึง API ก่อนเสมอ + เขียน cache sqflite; เมื่อ network ล้ม fallback อ่าน cache แล้วโชว์ banner เหลือง
- **Incident submit**: Riverpod Mutation — ปุ่ม 4 สถานะ idle→pending(หมุน กันกดซ้ำ)→success(เขียว)/error(แดง กดซ้ำได้)
- **Meter save**: Optimistic Update — เพิ่มรายการทันที (ไอคอนนาฬิกา pending) แล้วเปลี่ยนเป็นติ๊กเขียวเมื่อ server ตอบ 201; ถ้าล้ม rollback + SnackBar
- **Form validation**: meter code ต้องตรง `^MTR-\d{4}$`; validate ทั้ง client (UX) และ server (บังคับ)
- **Severity**: low/medium/high/critical (สีเขียว/เหลือง/ส้ม/แดง)

## State Management
- **Cubit (flutter_bloc)**: AuthCubit (session), MeterEntryCubit (form + optimistic)
- **Riverpod 3.0**: latestPowerReading (StreamProvider), PowerHistory (สะสม 30 จุด), DailyReports (AsyncNotifier + ReportFilterState), submitIncidentMutation (Mutation)
- โค้ดเต็มของทุก provider/cubit + Laravel endpoints อยู่ใน `Day5_note.md`

## Design Tokens
**Brand (จากโลโก้ EDL-GEN O&M):**
- Primary `#1A5CB0` · Primary Light `#2E7BD6` · Primary Dark `#0E3B78`
- Gold accent `#F4B700` · Signal Red (critical) `#D8232A`

**Surface & Neutral:** Background `#F0F4FA` · Card `#FFFFFF` · Border `#D6E0EF` · Text Dark `#152641` · Text Medium `#44557A` · Text Subtle `#7C8CA8`

**Semantic:** Success `#178A4C`/bg`#DDF5E7` · Warning `#D99C00`/bg`#FFF4CC` · Critical `#D8232A`/bg`#FDE3E4` · Info `#0E4E8F`/bg`#E1EEFB`

**Dark Mode:** bg `#0B1626` · card `#132238` · card2 `#182B45` · border `#24395B` · text `#E8F0FB` · subtle `#8299BE` · primary `#5A9BE8`

**Radius:** chip 10 · input 12 · button/card 14 · card 16 · badge/pill 20 · sheet/hero 28
**Elevation:** card `0 2px 8px rgba(26,92,176,.06)` · button `0 4px 20px rgba(26,92,176,.26)`
**Spacing:** 4 / 6 / 8 / 12 / 14 / 16 / 24
**Gradients:** primary `135deg #2E7BD6→#1A5CB0` · hero `170deg #2E7BD6·#1A5CB0·#0E3B78` · gold `120deg #F4B700→#D99C00`
**Type scale:** Display 32/700 · Title L 21/700 · Title 18/700 · Section 14/700 · Card 13/700 · Body 13/400 · Label 12/600 · Caption 11/400 · Micro 10/700

## Assets
- `assets/edl-gen-logo.jfif` — โลโก้ EDL-GEN O&M (วงกลม) ใช้ใน Splash/Login/Profile/toolbar
- Icons: Hugeicons Stroke Rounded (แพ็กเกจฟรี — ไม่ต้องแนบไฟล์)
- ฟอนต์ Phetsarath OT: ผู้พัฒนาต้องหาไฟล์ `.ttf` ทางการมาฝัง (mockup ใช้ Noto Sans Lao แทน)

## Files
- `EDL-Gen Design System.html` — คู่มือดีไซน์ (สี/ฟอนต์/ไอคอน/ปุ่ม/ฟอร์ม/การ์ด/โทเคน) — เปิดในเบราว์เซอร์
- `EDL-Gen App.html` — board รวมทุกหน้า iOS+Android เรียงกัน — เปิดในเบราว์เซอร์
- `EDL-Gen Prototype.html` — prototype คลิกได้ (สลับภาษา/แพลตฟอร์ม/ธีม) — เปิดในเบราว์เซอร์ได้เลย (self-contained)
- `source/edl-screens.jsx` — source ของทุกหน้า (ฟังก์ชัน `scr_<name>`), คีย์แปลภาษา (`T`), ชุดไอคอน (`IP`), โทเคน (`C`) — อ่านค่า layout/สี ที่แม่นยำจากไฟล์นี้
- `source/Day5_note.md` — **สเปกฝั่ง Laravel + Flutter ครบทั้ง 5 Feature** (โค้ดตัวอย่าง endpoints, cubit, provider, mutation, test)

> ไฟล์ `.html` เหล่านี้เป็น self-contained bundle เปิดดูได้เลย · ไฟล์ source (`source/*.jsx`, `source/Day5_note.md`) ใช้อ่านเป็น reference ประกอบการพัฒนา · `source/ios-frame.jsx` + `source/android-frame.jsx` คือ device frame ที่ใช้ครอบหน้าจอ (ไม่ต้องนำไปใช้จริงใน Flutter)
