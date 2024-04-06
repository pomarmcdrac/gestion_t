import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/presentation/providers/providers.dart';
import 'package:gestion_t/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasksData = ref.watch(tasksListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GestionT'),
      ),
      body: tasksData.when(
        data: (tasks) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(

                title: Text(task.title),
                subtitle: Text(task.dueDate.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskScreen(id: task.id.toString()),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_task');
        },
        child: const Icon(Icons.add),
      )
    );
  }
}