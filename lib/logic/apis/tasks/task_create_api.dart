import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/models/models.dart';


class CreateTaskById {

  final _dio = Dio();
  String endpoint = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  String token = 'Omar';
  String bearer = 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
  String contentType = 'application/x-www-form-urlencoded';

  Future<String> createTask(TaskDetails taskDetails) async {
    try {
      final response = await _dio.post(endpoint,
        queryParameters: {
          'token': token,
          'title': taskDetails.title,
          'is_completed': taskDetails.isCompleted,
          'due_date': taskDetails.dueDate,
          'comments': taskDetails.comments,
          'description': taskDetails.description,
          'tags': taskDetails.tags,
        },
        options: Options(
          headers: {
            'Authorization': bearer,
            'Content-Type': contentType,
          }
        )
      );
      print(response.data[0]['detail']);
      return response.data[0]['detail'];
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }
}

final createTaskProvider = Provider.family<CreateTaskById, TaskDetails>((ref, taskDetails) => CreateTaskById());