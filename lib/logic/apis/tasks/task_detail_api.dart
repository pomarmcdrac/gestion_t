import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/apis/tasks/config.dart';
import 'package:gestion_t/logic/models/models.dart';


class TaskService extends StateNotifier<List<TaskDetails>> {

  TaskService() : super([]);

  final _dio = Dio();
  String endpoint = Config.endpoint;
  String bearer = Config.bearer;
  String contentType = Config.contentType;

  Future<TaskDetails> getTasks(String id) async {
    final token = await Config.getToken();
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
    final token = await Config.getToken();
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
    final token = await Config.getToken();
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
    final token = await Config.getToken();
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