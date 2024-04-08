import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/config/config.dart';
import 'package:gestion_t/config/theme/app_theme.dart';
import 'package:gestion_t/logic/models/models.dart';
import 'package:gestion_t/presentation/providers/providers.dart';
import 'package:gestion_t/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasksData = ref.watch(taskListProvider);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme().fondo,
      appBar: AppBar(
        title: const Text('GestionT'),
      ),
      body: tasksData.when(
        data: (tasks) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskContainer(task: task, size: size);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme().principal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          context.push('/new_task');
        },
        child: Icon(
          Icons.post_add_rounded,
          color: AppTheme().claro,
        ),
      )
    );
  }
}

class TaskContainer extends ConsumerWidget {
  final Task task;
  final Size size;

  const TaskContainer({super.key, required this.task, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme().principal
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme().claro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskScreen(id: task.id.toString()),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.7,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextContent(
                    text: task.title,
                    color: AppTheme().principal,
                    maxFontSize: 26,
                    minFontSize: 18,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextContent(
                        text: task.dueDate.toString(), 
                        color: AppTheme().textos, 
                        maxFontSize: 12, 
                        minFontSize: 8, 
                        maxLines: 1
                      ),
                      TextContent(
                        text: task.isCompleted.toString(), 
                        color: AppTheme().textos, 
                        maxFontSize: 14, 
                        minFontSize: 10, 
                        maxLines: 1
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DeleteButton(task: task,)
          ],                    
        ),
      ),
    );
  }
}

class DeleteButton extends ConsumerWidget {
  final Task task;

  const DeleteButton({
    super.key, 
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme().claro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme().principal)
        ),
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () async {
        ref.read(taskServiceProvider.notifier).deleteTask(task.id.toString()).whenComplete(() {
          ref.read(taskListProvider.notifier).getTasks();
        });
      }, 
      child: Icon(
        Icons.delete_outline_rounded, 
        color: AppTheme().textos,
        size: 30,
      )
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.text, 
    required this.color, 
    required this.maxFontSize, 
    required this.minFontSize, 
    required this.maxLines,
  });

  final String text;
  final Color color;
  final double maxFontSize;
  final double minFontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text=='0'||text=='1'
      ? text=='0' ? 'No completada' : 'Completada'
      : text,
      style: TextStyle(
        color: text=='0'||text=='1' 
        ? text=='0' ? AppTheme().principal.withOpacity(0.6) : Colors.green 
        : color,
      ),
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      maxLines: maxLines,
    );
  }
}
