// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// (A) FutureProvider - การ์ดสรุป (read-only, refresh ด้วย ref.invalidate)

@ProviderFor(dashboardSummary)
final dashboardSummaryProvider = DashboardSummaryProvider._();

/// (A) FutureProvider - การ์ดสรุป (read-only, refresh ด้วย ref.invalidate)

final class DashboardSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardSummary>,
          DashboardSummary,
          FutureOr<DashboardSummary>
        >
    with $FutureModifier<DashboardSummary>, $FutureProvider<DashboardSummary> {
  /// (A) FutureProvider - การ์ดสรุป (read-only, refresh ด้วย ref.invalidate)
  DashboardSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardSummaryHash();

  @$internal
  @override
  $FutureProviderElement<DashboardSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardSummary> create(Ref ref) {
    return dashboardSummary(ref);
  }
}

String _$dashboardSummaryHash() => r'9c1d5c6773f78d2f528325b9cb374f54b37f35a8';

/// (B) AsyncNotifier - รายการโรงไฟฟ้า (มี refresh() ของตัวเอง) - Day 3 Lab

@ProviderFor(PlantList)
final plantListProvider = PlantListProvider._();

/// (B) AsyncNotifier - รายการโรงไฟฟ้า (มี refresh() ของตัวเอง) - Day 3 Lab
final class PlantListProvider
    extends $AsyncNotifierProvider<PlantList, List<Plant>> {
  /// (B) AsyncNotifier - รายการโรงไฟฟ้า (มี refresh() ของตัวเอง) - Day 3 Lab
  PlantListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantListHash();

  @$internal
  @override
  PlantList create() => PlantList();
}

String _$plantListHash() => r'c417e0f2dd6fa5551ce200a3b867ec1d519ed053';

/// (B) AsyncNotifier - รายการโรงไฟฟ้า (มี refresh() ของตัวเอง) - Day 3 Lab

abstract class _$PlantList extends $AsyncNotifier<List<Plant>> {
  FutureOr<List<Plant>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Plant>>, List<Plant>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Plant>>, List<Plant>>,
              AsyncValue<List<Plant>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail

@ProviderFor(plantDetail)
final plantDetailProvider = PlantDetailFamily._();

/// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail

final class PlantDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlantDetail>,
          PlantDetail,
          FutureOr<PlantDetail>
        >
    with $FutureModifier<PlantDetail>, $FutureProvider<PlantDetail> {
  /// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail
  PlantDetailProvider._({
    required PlantDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'plantDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$plantDetailHash();

  @override
  String toString() {
    return r'plantDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PlantDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlantDetail> create(Ref ref) {
    final argument = this.argument as int;
    return plantDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$plantDetailHash() => r'42066e052a5dadafffde14aa536899a24a4b80a5';

/// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail

final class PlantDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PlantDetail>, int> {
  PlantDetailFamily._()
    : super(
        retry: null,
        name: r'plantDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail

  PlantDetailProvider call(int plantId) =>
      PlantDetailProvider._(argument: plantId, from: this);

  @override
  String toString() => r'plantDetailProvider';
}
