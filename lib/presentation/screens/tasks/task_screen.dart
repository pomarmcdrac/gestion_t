import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/config/config.dart';
import 'package:gestion_t/config/theme/app_theme.dart';
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
  

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dueDateController = TextEditingController();
    final TextEditingController commentsController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController tagsController = TextEditingController();
    bool isCompleted = false;

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
          if (task.isCompleted == 1) {
            isCompleted = true;
          }
          titleController.text = task.title;
          dueDateController.text = task.dueDate;
          commentsController.text = task.comments ?? '';
          descriptionController.text = task.description ?? '';
          tagsController.text = task.tags ?? '';
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
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Título', 
                        hintText: 'Titulo de tu tarea', 
                        controller: titleController
                      ),
                      InputText(
                        type: TextInputType.datetime, 
                        labelText: 'Fecha', 
                        hintText: 'YYYY-MM-DD', 
                        controller: dueDateController
                      ),
                      Switch(
                        value: isCompleted, 
                        onChanged: (value) {
                          setState(() {
                            isCompleted = value;
                          });
                        },
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Comentarios', 
                        hintText: 'Comentarios de tu tarea', 
                        controller: commentsController
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Descripción', 
                        hintText: 'Descripción de tu tarea', 
                        controller: descriptionController
                      ),
                      InputText(
                        type: TextInputType.text, 
                        labelText: 'Tags', 
                        hintText: 'Tags de tu tarea', 
                        controller: tagsController
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty && dueDateController.text.isNotEmpty) {
                            //Añadir item a la lista o actualizar
                            //limpiar campos
                            context.pop('/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor llena los campos de fecha y título'),
                              ),
                            );
                          }
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme().principal,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: AutoSizeText(
                          'Actualizar',
                          style: TextStyle(color: AppTheme().claro),
                          maxLines: 1,
                          minFontSize: 10,
                          maxFontSize: 20,
                        )
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