import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/models/models.dart';


class TaskService extends StateNotifier<List<TaskDetails>> {

  TaskService() : super([]);

  final _dio = Dio();
  String endpoint = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  String token = 'Omar';
  String bearer = 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
  String contentType = 'application/x-www-form-urlencoded';

  Future<TaskDetails> getTasks(String id) async {
    try {
      final response = await _dio.get('$endpoint/$id',
        queryParameters: {'token': token},
        options: Options(
          headers: {
            'Authorization': bearer,
          }
        )
      );
      TaskDetails taskDetail = TaskDetails.fromJson(response.data[0]);
      return taskDetail;
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(TaskDetails taskDetails) async {
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
      return response.data;
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> updateTask(TaskDetails taskDetails) async {
    try {
      final response = await _dio.put('$endpoint/${taskDetails.id}',
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
      return response.data;
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await _dio.delete('$endpoint/$id',
        data: {'token': token},
        options: Options(
          headers: {
            'Authorization': bearer,
          }
        )
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }
}