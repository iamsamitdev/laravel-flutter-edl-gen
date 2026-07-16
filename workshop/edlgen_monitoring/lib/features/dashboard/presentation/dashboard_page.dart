import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../../core/widgets/skeletons.dart';
import '../../../core/widgets/status_badge.dart';
import '../data/models/plant.dart';
import '../data/models/power_reading.dart';
import 'widgets/live_power_card.dart';
import 'widgets/power_chart.dart';

/// Dashboard: greeting header + การ์ด Real-time (จำลอง) + กราฟ 30 ค่า + รายการโรงผลิต
///
/// ทุกอย่างเป็น StatefulWidget + setState ธรรมดา:
/// - รายการโรงผลิต: โหลดจาก API ใน initState แล้ว setState
/// - ค่าการผลิตสด: "จำลอง" ในแอปเอง - Timer สุ่มค่าใหม่ทุก 3 วินาที
///   (ไม่ได้ดึงจาก server - ใช้สาธิตหน้าจอ Real-time ในห้องอบรม)
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // ── สถานะรายการโรงผลิต ──
  List<Plant>? _plants; // null = กำลังโหลด
  String? _plantsError;

  // ── ค่าการผลิตสดแบบจำลอง (random walk ในเครื่อง) ──
  Timer? _simulateTimer;
  final _random = Random();
  double _powerMw = 985; // ค่าตั้งต้นกำลังผลิตรวม (MW)
  PowerReading? _lastReading; // ค่าล่าสุด (โชว์บนการ์ดใหญ่)
  final List<PowerReading> _history = []; // สะสม 30 จุดสำหรับกราฟเส้น
  static const _maxPoints = 30;

  @override
  void initState() {
    super.initState();
    _loadPlants();
    // สร้างค่าแรกทันที แล้วสุ่มค่าใหม่ทุก 3 วินาที
    _generateReading();
    _simulateTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _generateReading(),
    );
  }

  @override
  void dispose() {
    _simulateTimer?.cancel(); // สำคัญ! ยกเลิก Timer ก่อนหน้าถูกทำลาย
    super.dispose();
  }

  /// สุ่มค่าการผลิตแบบ random walk: ค่าใหม่ = ค่าเดิม ± ไม่เกิน 10 MW
  /// ให้กราฟดูสมจริง (ค่อย ๆ ขยับ ไม่กระโดดมั่ว)
  void _generateReading() {
    _powerMw = (_powerMw + (_random.nextDouble() - 0.5) * 20)
        .clamp(600.0, 1200.0);

    final reading = PowerReading(
      plantId: 0,
      plantName: 'EDL-Gen Total',
      powerMw: _powerMw,
      frequency: 50 + (_random.nextDouble() - 0.5) * 0.16, // 49.92-50.08 Hz
      voltageKv: 115 + (_random.nextDouble() - 0.5) * 4,   // 113-117 kV
      recordedAt: DateTime.now(),
    );

    setState(() {
      _lastReading = reading;
      _history.add(reading);
      if (_history.length > _maxPoints) _history.removeAt(0);
    });
  }

  Future<void> _loadPlants() async {
    setState(() {
      _plants = null;
      _plantsError = null;
    });
    try {
      final plants = await dashboardRepository.fetchPlants();
      if (!mounted) return;
      setState(() => _plants = plants);
    } catch (e) {
      if (!mounted) return;
      setState(() => _plantsError = '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = authController.user?.name ?? 'Engineer';

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadPlants,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientHeader(
              subtitle: context.tr('greet'),
              title: userName,
              onBellTap: () => context.push('/notifications'),
              child: LivePowerCard(reading: _lastReading),
            ),
            // กราฟเส้น 30 ค่าล่าสุด
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('dash_chart'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      PowerChart(
                        history: _history,
                        waitingText: context.tr('dash_waiting'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // หัวข้อรายการโรงผลิต
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.tr('dash_plants'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                  Text(
                    context.tr('dash_viewall'),
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // รายการโรงผลิต - 3 สถานะ: กำลังโหลด / error / มีข้อมูล
            if (_plantsError != null)
              ErrorBanner(
                message: _plantsError!,
                retryLabel: context.tr('retry'),
                onRetry: _loadPlants,
              )
            else if (_plants == null)
              const Column(
                children: [
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                  ListTileSkeleton(),
                ],
              )
            else
              Column(
                children: [
                  for (final plant in _plants!)
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: ListTile(
                        onTap: () => context.push('/dashboard/plant/${plant.id}'),
                        leading: CircleAvatar(
                          backgroundColor: plant.isOnline
                              ? const Color(0xFFDDF5E7)
                              : const Color(0xFFFDE3E4),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedFlash,
                            color: plant.status == 'online'
                                ? const Color(0xFF178A4C)
                                : const Color(0xFFD8232A),
                          ),
                        ),
                        title: Text(plant.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          // Server บน Render ไม่ส่งค่ากำลังผลิตปัจจุบัน (= 0)
                          // จึงโชว์กำลังการผลิต + ชนิด + แขวง แทน
                          plant.currentOutputMw > 0
                              ? '${plant.currentOutputMw.toStringAsFixed(1)} / '
                                  '${plant.capacityMw.toStringAsFixed(0)} MW '
                                  '(${plant.loadFactor.toStringAsFixed(0)}%)'
                              : '${plant.capacityMw.toStringAsFixed(0)} MW · '
                                  '${plant.type} · ${plant.province}',
                          style: AppTheme.numberStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        trailing: StatusBadge(
                          status: PlantStatus.fromString(plant.status),
                          label: context.tr(
                              PlantStatus.fromString(plant.status).labelKey),
                        ),
                      ),
                    ),
                  const SizedBox(height: 90),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
