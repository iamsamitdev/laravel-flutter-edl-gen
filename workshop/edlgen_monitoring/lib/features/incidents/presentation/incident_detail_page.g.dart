// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_detail_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(incidentDetail)
final incidentDetailProvider = IncidentDetailFamily._();

final class IncidentDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Incident>, Incident, FutureOr<Incident>>
    with $FutureModifier<Incident>, $FutureProvider<Incident> {
  IncidentDetailProvider._({
    required IncidentDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'incidentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$incidentDetailHash();

  @override
  String toString() {
    return r'incidentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Incident> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Incident> create(Ref ref) {
    final argument = this.argument as int;
    return incidentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IncidentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$incidentDetailHash() => r'c8ab23df69ef121d00ff86d2eb5c2776cd770396';

final class IncidentDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Incident>, int> {
  IncidentDetailFamily._()
    : super(
        retry: null,
        name: r'incidentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IncidentDetailProvider call(int incidentId) =>
      IncidentDetailProvider._(argument: incidentId, from: this);

  @override
  String toString() => r'incidentDetailProvider';
}
