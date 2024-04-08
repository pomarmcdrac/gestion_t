import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/config/config.dart';
import 'package:gestion_t/config/theme/app_theme.dart';
import 'package:gestion_t/logic/models/models.dart';
import 'package:gestion_t/presentation/providers/providers.dart';
import 'package:gestion_t/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class TaskScreen extends ConsumerStatefulWidget {

  final String? id;

  const TaskScreen({super.key, this.id});

  @override
  ConsumerState<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends ConsumerState<TaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskServiceProvider.notifier).getTasks(widget.id!).then((task) {
        titleController.text = task.title;
        dueDateController.text = task.dueDate;
        commentsController.text = task.comments ?? '';
        descriptionController.text = task.description ?? '';
        tagsController.text = task.tags ?? '';
        setState(() {
          isCompleted = task.isCompleted == 1 ? true : false;
        });
      });
    });
  }

  updatedTask() {
    TaskDetails taskDetails = TaskDetails(
      id: int.parse(widget.id!),
      title: titleController.text,
      dueDate: dueDateController.text,
      isCompleted: isCompleted ? 1 : 0,
      comments: commentsController.text,
      description: descriptionController.text,
      tags: tagsController.text,
    );
    ref.watch(taskServiceProvider.notifier).updateTask(taskDetails).whenComplete(() {
      ref.watch(taskListProvider.notifier).getTasks().whenComplete(() {
        context.pop();
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {

    final taskDetails = ref.watch(taskDetailProvider(widget.id!));
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme().fondo,
      appBar: AppBar(
        title: const AutoSizeText(
          'Actualizar tarea',
          maxLines: 1,
          minFontSize: 10,
          maxFontSize: 20,
        ),
      ),
      body: taskDetails.when(
        data: (task) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme().claro,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      InputTitle(
                        type: TextInputType.text, 
                        labelText: 'Título', 
                        hintText: 'Titulo de tu tarea', 
                        controller: titleController
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputDate(
                            type: TextInputType.datetime, 
                            labelText: 'Fecha', 
                            hintText: 'YYYY-MM-DD', 
                            controller: dueDateController,
                            size: size,
                          ),
                          FormSwitch(
                            initialValue: isCompleted,
                            onChanged: (value) {
                              setState(() {
                                isCompleted = value;
                              });
                            },
                          ),
                        ],
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Comentarios', 
                        hintText: 'Comentarios de tu tarea', 
                        controller: commentsController,
                        size: size,
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Descripción', 
                        hintText: 'Descripción de tu tarea', 
                        controller: descriptionController,
                        size: size,
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Tags', 
                        hintText: 'Tags de tu tarea', 
                        controller: tagsController,
                        size: size,
                      ),
                      const SizedBox(height: 20),
                      SubmitButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty && dueDateController.text.isNotEmpty) {
                            updatedTask();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor llena los campos de fecha y título'),
                              ),
                            );
                          }
                        },
                        buttonText: 'Actualizar',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}