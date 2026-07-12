// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportFilterState)
final reportFilterStateProvider = ReportFilterStateProvider._();

final class ReportFilterStateProvider
    extends $NotifierProvider<ReportFilterState, ReportFilter> {
  ReportFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportFilterStateHash();

  @$internal
  @override
  ReportFilterState create() => ReportFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportFilter>(value),
    );
  }
}

String _$reportFilterStateHash() => r'3cd3a4fb521346136fc4475a8211cc5981031240';

abstract class _$ReportFilterState extends $Notifier<ReportFilter> {
  ReportFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReportFilter, ReportFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportFilter, ReportFilter>,
              ReportFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// AsyncNotifier หลักของหน้ารายงาน - build ใหม่อัตโนมัติเมื่อ Filter เปลี่ยน

@ProviderFor(DailyReports)
final dailyReportsProvider = DailyReportsProvider._();

/// AsyncNotifier หลักของหน้ารายงาน - build ใหม่อัตโนมัติเมื่อ Filter เปลี่ยน
final class DailyReportsProvider
    extends $AsyncNotifierProvider<DailyReports, ReportResult> {
  /// AsyncNotifier หลักของหน้ารายงาน - build ใหม่อัตโนมัติเมื่อ Filter เปลี่ยน
  DailyReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyReportsHash();

  @$internal
  @override
  DailyReports create() => DailyReports();
}

String _$dailyReportsHash() => r'16d099f6e999176b716c2bd2ebadc868b25de7b6';

/// AsyncNotifier หลักของหน้ารายงาน - build ใหม่อัตโนมัติเมื่อ Filter เปลี่ยน

abstract class _$DailyReports extends $AsyncNotifier<ReportResult> {
  FutureOr<ReportResult> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ReportResult>, ReportResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReportResult>, ReportResult>,
              AsyncValue<ReportResult>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
