import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';

final tasksListProvider = FutureProvider<List<Task>>((ref) {
  return ref.watch(taskProvider).getTasks();
});