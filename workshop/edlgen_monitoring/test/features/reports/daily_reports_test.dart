import 'package:edlgen_monitoring/features/reports/data/models/daily_report.dart';
import 'package:edlgen_monitoring/features/reports/data/report_repository.dart';
import 'package:edlgen_monitoring/features/reports/logic/report_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportRepository extends Mock implements ReportRepository {}

const fakeReports = [
  DailyReport(
    id: 1,
    plantId: 1,
    plantName: 'Nam Ngum 1',
    reportDate: '2026-07-12',
    energyMwh: 2870.5,
    peakMw: 148.2,
    availability: 97.4,
    waterLevelM: 198.3,
  ),
  DailyReport(
    id: 2,
    plantId: 2,
    plantName: 'Nam Ngum 2',
    reportDate: '2026-07-12',
    energyMwh: 11250.0,
    peakMw: 601.0,
    availability: 99.1,
    waterLevelM: 205.7,
  ),
];

void main() {
  late MockReportRepository repository;

  setUp(() {
    repository = MockReportRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        reportRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('โหลดรายงานสำเร็จ ต้องได้ AsyncData และ fromCache = false', () async {
    when(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: any(named: 'plantId'),
        )).thenAnswer(
        (_) async => const ReportResult(reports: fakeReports, fromCache: false));

    final container = makeContainer();
    final result = await container.read(dailyReportsProvider.future);

    expect(result.reports, hasLength(fakeReports.length));
    expect(result.fromCache, isFalse);
  });

  test('เมื่อเปลี่ยน Filter provider ต้องดึงข้อมูลใหม่ด้วยเงื่อนไขใหม่', () async {
    when(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: any(named: 'plantId'),
        )).thenAnswer(
        (_) async => const ReportResult(reports: fakeReports, fromCache: false));

    final container = makeContainer();
    await container.read(dailyReportsProvider.future);

    container.read(reportFilterStateProvider.notifier).setPlant(2);
    await container.read(dailyReportsProvider.future);

    verify(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: 2,
        )).called(1);
  });

  test('เมื่อ network ล้มและมี cache ต้องได้ fromCache = true', () async {
    when(() => repository.getDailyReports(
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          plantId: any(named: 'plantId'),
        )).thenAnswer(
        (_) async => const ReportResult(reports: fakeReports, fromCache: true));

    final container = makeContainer();
    final result = await container.read(dailyReportsProvider.future);

    expect(result.fromCache, isTrue);
  });
}
