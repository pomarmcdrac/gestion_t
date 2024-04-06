import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';

final taskDetailProvider = FutureProvider.family<TaskDetails, String>((ref, id) {
  return ref.read(taskByIdProvider(id)).getTaskId(id);
});