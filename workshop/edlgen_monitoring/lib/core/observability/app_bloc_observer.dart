import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

/// Audit Trail: log ทุก transition ของ Cubit/Bloc (Day 4 Module 7)
/// เปิด Debug Console จะเห็นบรรทัด [AUDIT ...] ทุกครั้งที่ state เปลี่ยน
class AppBlocObserver extends BlocObserver {
  String _stamp() => DateTime.now().toIso8601String();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    dev.log('[AUDIT ${_stamp()}] CREATE  ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    dev.log('[AUDIT ${_stamp()}] CHANGE  ${bloc.runtimeType}: '
        '${change.currentState}  →  ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dev.log('[AUDIT ${_stamp()}] ERROR   ${bloc.runtimeType}: $error',
        error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    dev.log('[AUDIT ${_stamp()}] CLOSE   ${bloc.runtimeType}');
  }
}
