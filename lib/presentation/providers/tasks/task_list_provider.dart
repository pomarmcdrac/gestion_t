import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';

final taskListServiceProvider = Provider<TaskListService>((ref) => TaskListService());
final taskListProvider = StateNotifierProvider<TaskNotifier, AsyncValue<List<Task>>>((ref) => TaskNotifier(ref));

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref ref;

  TaskNotifier(this.ref) : super(const AsyncValue.loading()) {
    getTasks();
  }

  Future<void> getTasks() async {
    try {
      state = const AsyncValue.loading();
      final taskListService = ref.read(taskListServiceProvider);
      final task = await taskListService.getTasks();
      state = AsyncValue.data(task);
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }
}