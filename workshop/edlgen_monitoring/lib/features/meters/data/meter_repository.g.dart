// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(meterRepository)
final meterRepositoryProvider = MeterRepositoryProvider._();

final class MeterRepositoryProvider
    extends
        $FunctionalProvider<MeterRepository, MeterRepository, MeterRepository>
    with $Provider<MeterRepository> {
  MeterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meterRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meterRepositoryHash();

  @$internal
  @override
  $ProviderElement<MeterRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MeterRepository create(Ref ref) {
    return meterRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MeterRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MeterRepository>(value),
    );
  }
}

String _$meterRepositoryHash() => r'1610109e32a348773ead02fa8ecfad945f3521bb';
