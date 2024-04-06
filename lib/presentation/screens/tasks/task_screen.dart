import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/presentation/providers/providers.dart';

class TaskScreen extends ConsumerStatefulWidget {
  final String? id;

  const TaskScreen({super.key, this.id});

  @override
  ConsumerState<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  Widget build(BuildContext context) {

    final taskDetails = ref.watch(taskDetailProvider(widget.id!));

    print('Este es el id: ${widget.id}');
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Agregar nueva tarea',
          maxLines: 1,
          minFontSize: 10,
          maxFontSize: 20,
        ),
      ),
      body: taskDetails.when(
        data: (task) {
          return Column(
            children: [
              Text(task.title),
              Text(task.dueDate),
              Text(task.comments),
              Text(task.description),
              Text(task.tags),
              Text(task.token),
              Text(task.createdAt),
              Text(task.updatedAt),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}