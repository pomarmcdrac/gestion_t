import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_t/logic/models/models.dart';


class GetTaskManager {

  final _dio = Dio();
  String endpoint = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  String token = 'Omar';
  String bearer = 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';

  Future<List<Task>> getTasks() async {
    try {
      final response = await _dio.get(endpoint,
        queryParameters: {'token': token},
        options: Options(
          headers: {
            'Authorization': bearer,
          }
        )
      );
      final List results = jsonDecode(response.data);
      print(results);
      return results.map((task) => Task.fromJson(task)).toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to load tasks');
    }
  }
}

final taskProvider = Provider<GetTaskManager>((ref) => GetTaskManager());