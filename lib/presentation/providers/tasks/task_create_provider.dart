import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';

final newTaskProvider = FutureProvider.family<String, TaskDetails>((ref, taskDetails) {
  return ref.read(createTaskProvider(taskDetails)).createTask(taskDetails);
});