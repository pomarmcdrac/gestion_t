import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/apis.dart';

final taskDeleteProvider = FutureProvider.autoDispose.family<void, String>((ref, id) async {
  final deleteTaskById = ref.watch(deleteByIdProvider(id));
  await deleteTaskById.deleteTaskId(id);
});