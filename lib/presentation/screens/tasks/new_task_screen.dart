import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/config/config.dart';
import 'package:gestion_t/config/theme/app_theme.dart';
import 'package:gestion_t/logic/apis/apis.dart';
import 'package:gestion_t/logic/models/models.dart';
import 'package:gestion_t/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dueDateController = TextEditingController();
    final TextEditingController commentsController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController tagsController = TextEditingController();
    bool isCompleted = false;

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme().fondo,
      appBar: AppBar(
        title: const AutoSizeText(
          'Agregar nueva tarea',
          maxLines: 1,
          minFontSize: 10,
          maxFontSize: 20,
        ),
      ),
      body: Padding(
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
                    type: TextInputType.text, 
                    labelText: 'Fecha', 
                    hintText: 'YYYY-MM-DD', 
                    controller: dueDateController
                  ),
                  Switch(
                    value: false, 
                    onChanged: (value) {
                      isCompleted = value;
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
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isNotEmpty && dueDateController.text.isNotEmpty) {
                          TaskDetails taskCreate = TaskDetails(
                            title: titleController.text, 
                            isCompleted: isCompleted ? 1 : 0, 
                            dueDate: dueDateController.text, 
                            comments: commentsController.text, 
                            description: descriptionController.text, 
                            tags: tagsController.text, 
                            token: 'Omar',
                          );
                          await ref.read(createTaskProvider(taskCreate)).createTask(taskCreate);
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: AutoSizeText(
                        'Agregar',
                        style: TextStyle(color: AppTheme().claro),
                        maxLines: 1,
                        minFontSize: 10,
                        maxFontSize: 20,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}
