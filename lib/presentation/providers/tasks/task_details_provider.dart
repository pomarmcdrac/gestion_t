
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';

final taskServiceProvider = StateNotifierProvider<TaskService, List<TaskDetails>>((ref,) => TaskService());
final taskDetailProvider = FutureProvider.family<TaskDetails, String>((ref, id) async {
  final taskService = ref.read(taskServiceProvider.notifier);
  return await taskService.getTasks(id);
});