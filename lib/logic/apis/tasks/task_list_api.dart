import 'package:dio/dio.dart';
import 'package:gestion_t/logic/apis/tasks/config.dart';
import 'package:gestion_t/logic/models/models.dart';


class TaskListService {

  final _dio = Dio();
  String endpoint = Config.endpoint;
  String bearer = Config.bearer;

  Future<List<Task>> getTasks() async {
    final token = await Config.getToken();
    try {
      final response = await _dio.get(endpoint,
        queryParameters: {'token': token},
        options: Options(
          headers: {
            'Authorization': bearer,
          }
        )
      );
      List<Task> tasksList = (response.data as List).map((task) => Task.fromJson(task)).toList();
      return tasksList;
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }
}