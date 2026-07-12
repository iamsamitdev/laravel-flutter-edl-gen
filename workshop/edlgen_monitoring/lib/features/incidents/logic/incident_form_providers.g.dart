// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_form_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// path รูปถ่ายเครื่องจักร (null = ยังไม่ถ่าย → ปุ่มส่งกดไม่ได้)

@ProviderFor(IncidentPhoto)
final incidentPhotoProvider = IncidentPhotoProvider._();

/// path รูปถ่ายเครื่องจักร (null = ยังไม่ถ่าย → ปุ่มส่งกดไม่ได้)
final class IncidentPhotoProvider
    extends $NotifierProvider<IncidentPhoto, String?> {
  /// path รูปถ่ายเครื่องจักร (null = ยังไม่ถ่าย → ปุ่มส่งกดไม่ได้)
  IncidentPhotoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentPhotoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incidentPhotoHash();

  @$internal
  @override
  IncidentPhoto create() => IncidentPhoto();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$incidentPhotoHash() => r'c4aae6218da46a6fa6477d5a15a77c300571b2ba';

/// path รูปถ่ายเครื่องจักร (null = ยังไม่ถ่าย → ปุ่มส่งกดไม่ได้)

abstract class _$IncidentPhoto extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// พิกัด GPS ปัจจุบัน - throw เมื่อ Location Service ปิดหรือไม่ได้รับสิทธิ์

@ProviderFor(currentPosition)
final currentPositionProvider = CurrentPositionProvider._();

/// พิกัด GPS ปัจจุบัน - throw เมื่อ Location Service ปิดหรือไม่ได้รับสิทธิ์

final class CurrentPositionProvider
    extends
        $FunctionalProvider<AsyncValue<Position>, Position, FutureOr<Position>>
    with $FutureModifier<Position>, $FutureProvider<Position> {
  /// พิกัด GPS ปัจจุบัน - throw เมื่อ Location Service ปิดหรือไม่ได้รับสิทธิ์
  CurrentPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPositionHash();

  @$internal
  @override
  $FutureProviderElement<Position> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Position> create(Ref ref) {
    return currentPosition(ref);
  }
}

String _$currentPositionHash() => r'61883db1231b40296be92cb25c58930fa8d450a0';

/// โรงไฟฟ้าที่เลือกในฟอร์ม + ระดับความรุนแรง (state ของฟอร์ม)

@ProviderFor(IncidentFormPlant)
final incidentFormPlantProvider = IncidentFormPlantProvider._();

/// โรงไฟฟ้าที่เลือกในฟอร์ม + ระดับความรุนแรง (state ของฟอร์ม)
final class IncidentFormPlantProvider
    extends $NotifierProvider<IncidentFormPlant, int?> {
  /// โรงไฟฟ้าที่เลือกในฟอร์ม + ระดับความรุนแรง (state ของฟอร์ม)
  IncidentFormPlantProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentFormPlantProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incidentFormPlantHash();

  @$internal
  @override
  IncidentFormPlant create() => IncidentFormPlant();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$incidentFormPlantHash() => r'0861adf5d9454fa090443a8afa710e4191deb283';

/// โรงไฟฟ้าที่เลือกในฟอร์ม + ระดับความรุนแรง (state ของฟอร์ม)

abstract class _$IncidentFormPlant extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IncidentFormSeverity)
final incidentFormSeverityProvider = IncidentFormSeverityProvider._();

final class IncidentFormSeverityProvider
    extends $NotifierProvider<IncidentFormSeverity, String> {
  IncidentFormSeverityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentFormSeverityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incidentFormSeverityHash();

  @$internal
  @override
  IncidentFormSeverity create() => IncidentFormSeverity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$incidentFormSeverityHash() =>
    r'd7c4b5e8f55fc8c4ad1f9b53b3286daa23756aac';

abstract class _$IncidentFormSeverity extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
