import 'package:flutter_riverpod/experimental/mutation.dart';

import '../data/models/incident.dart';

/// Riverpod 3.0 Mutations API (experimental) - Day 1 Module 6 + Day 5 Feature 4
/// Lifecycle: MutationIdle → MutationPending → MutationSuccess / MutationError
/// ปุ่มส่งอ่าน state นี้เพื่อแสดง 4 สถานะ + กันกดซ้ำระหว่าง pending
final submitIncidentMutation = Mutation<Incident>();
