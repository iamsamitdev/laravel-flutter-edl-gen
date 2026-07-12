import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/report_repository.dart';

part 'report_providers.g.dart';

/// เงื่อนไข Filter ของหน้ารายงาน
class ReportFilter {
  const ReportFilter({this.dateFrom, this.dateTo, this.plantId});

  final String? dateFrom; // 'YYYY-MM-DD'
  final String? dateTo;
  final int? plantId;

  ReportFilter copyWith({
    String? dateFrom,
    String? dateTo,
    int? Function()? plantId,
  }) =>
      ReportFilter(
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        plantId: plantId != null ? plantId() : this.plantId,
      );
}

@riverpod
class ReportFilterState extends _$ReportFilterState {
  @override
  ReportFilter build() => const ReportFilter();

  void setDateRange(String from, String to) =>
      state = state.copyWith(dateFrom: from, dateTo: to);

  void setPlant(int? plantId) => state = state.copyWith(plantId: () => plantId);

  void clear() => state = const ReportFilter();
}

/// AsyncNotifier หลักของหน้ารายงาน - build ใหม่อัตโนมัติเมื่อ Filter เปลี่ยน
@riverpod
class DailyReports extends _$DailyReports {
  @override
  Future<ReportResult> build() async {
    final filter = ref.watch(reportFilterStateProvider);
    final repository = ref.watch(reportRepositoryProvider);

    return repository.getDailyReports(
      dateFrom: filter.dateFrom,
      dateTo: filter.dateTo,
      plantId: filter.plantId,
    );
  }

  Future<void> refresh() async {
    final filter = ref.read(reportFilterStateProvider);
    final repository = ref.read(reportRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.getDailyReports(
          dateFrom: filter.dateFrom,
          dateTo: filter.dateTo,
          plantId: filter.plantId,
        ));
  }
}
