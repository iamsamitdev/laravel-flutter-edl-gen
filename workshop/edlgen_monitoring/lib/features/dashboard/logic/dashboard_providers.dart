import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/dashboard_repository.dart';
import '../data/models/dashboard_summary.dart';
import '../data/models/plant.dart';

part 'dashboard_providers.g.dart';

/// (A) FutureProvider - การ์ดสรุป (read-only, refresh ด้วย ref.invalidate)
@riverpod
Future<DashboardSummary> dashboardSummary(Ref ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.fetchSummary();
}

/// (B) AsyncNotifier - รายการโรงไฟฟ้า (มี refresh() ของตัวเอง) - Day 3 Lab
@riverpod
class PlantList extends _$PlantList {
  @override
  Future<List<Plant>> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository.fetchPlants();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final repository = ref.read(dashboardRepositoryProvider);
      return repository.fetchPlants();
    });
  }
}

/// Provider แบบมีพารามิเตอร์ (แทน .family ใน Riverpod 3) - หน้า Plant Detail
@riverpod
Future<PlantDetail> plantDetail(Ref ref, int plantId) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.fetchPlantDetail(plantId);
}
