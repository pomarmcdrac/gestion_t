import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/models/models.dart';

final tasksProvider = FutureProvider<List<Task>>((ref) {
  return ref.watch(tasksProvider).getTasks();
});