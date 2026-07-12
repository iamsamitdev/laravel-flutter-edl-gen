import 'package:equatable/equatable.dart';

import '../data/models/meter_reading.dart';

enum MeterEntryStatus { initial, submitting, success, failure }

class MeterEntryState extends Equatable {
  const MeterEntryState({
    this.status = MeterEntryStatus.initial,
    this.todayReadings = const [],
    this.errorMessage,
  });

  final MeterEntryStatus status;
  final List<MeterReading> todayReadings;
  final String? errorMessage;

  MeterEntryState copyWith({
    MeterEntryStatus? status,
    List<MeterReading>? todayReadings,
    String? errorMessage,
  }) {
    return MeterEntryState(
      status: status ?? this.status,
      todayReadings: todayReadings ?? this.todayReadings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, todayReadings, errorMessage];
}
