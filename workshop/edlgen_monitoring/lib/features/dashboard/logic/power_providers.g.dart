// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(powerSocketService)
final powerSocketServiceProvider = PowerSocketServiceProvider._();

final class PowerSocketServiceProvider
    extends
        $FunctionalProvider<
          PowerSocketService,
          PowerSocketService,
          PowerSocketService
        >
    with $Provider<PowerSocketService> {
  PowerSocketServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'powerSocketServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$powerSocketServiceHash();

  @$internal
  @override
  $ProviderElement<PowerSocketService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PowerSocketService create(Ref ref) {
    return powerSocketService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PowerSocketService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PowerSocketService>(value),
    );
  }
}

String _$powerSocketServiceHash() =>
    r'9f7aea4164ff4db58beeb8668a09d70f38b29f4e';

/// StreamProvider: ค่าการผลิตสดจาก WebSocket - push ทุก 3 วินาที (ไม่มี polling)
/// Riverpod retry อัตโนมัติแบบ exponential backoff เมื่อ stream error

@ProviderFor(latestPowerReading)
final latestPowerReadingProvider = LatestPowerReadingProvider._();

/// StreamProvider: ค่าการผลิตสดจาก WebSocket - push ทุก 3 วินาที (ไม่มี polling)
/// Riverpod retry อัตโนมัติแบบ exponential backoff เมื่อ stream error

final class LatestPowerReadingProvider
    extends
        $FunctionalProvider<
          AsyncValue<PowerReading>,
          PowerReading,
          Stream<PowerReading>
        >
    with $FutureModifier<PowerReading>, $StreamProvider<PowerReading> {
  /// StreamProvider: ค่าการผลิตสดจาก WebSocket - push ทุก 3 วินาที (ไม่มี polling)
  /// Riverpod retry อัตโนมัติแบบ exponential backoff เมื่อ stream error
  LatestPowerReadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestPowerReadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestPowerReadingHash();

  @$internal
  @override
  $StreamProviderElement<PowerReading> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PowerReading> create(Ref ref) {
    return latestPowerReading(ref);
  }
}

String _$latestPowerReadingHash() =>
    r'dd260b2c1821074527d8d86b32a74f4333809a63';

/// สะสมค่าล่าสุด 30 จุดสำหรับกราฟเส้น (Day 5 Feature 2)

@ProviderFor(PowerHistory)
final powerHistoryProvider = PowerHistoryProvider._();

/// สะสมค่าล่าสุด 30 จุดสำหรับกราฟเส้น (Day 5 Feature 2)
final class PowerHistoryProvider
    extends $NotifierProvider<PowerHistory, List<PowerReading>> {
  /// สะสมค่าล่าสุด 30 จุดสำหรับกราฟเส้น (Day 5 Feature 2)
  PowerHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'powerHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$powerHistoryHash();

  @$internal
  @override
  PowerHistory create() => PowerHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PowerReading> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PowerReading>>(value),
    );
  }
}

String _$powerHistoryHash() => r'a88694385879281c44c634fc4a4a48256d366282';

/// สะสมค่าล่าสุด 30 จุดสำหรับกราฟเส้น (Day 5 Feature 2)

abstract class _$PowerHistory extends $Notifier<List<PowerReading>> {
  List<PowerReading> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<PowerReading>, List<PowerReading>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PowerReading>, List<PowerReading>>,
              List<PowerReading>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
