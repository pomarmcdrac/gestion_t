import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DeleteTaskById {

  final _dio = Dio();
  String endpoint = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  String token = 'Omar';
  String bearer = 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';

  Future<String> deleteTaskId(String id) async {
    try {
      final response = await _dio.delete('$endpoint/$id',
        queryParameters: {'token': token},
        options: Options(
          headers: {
            'Authorization': bearer,
          }
        )
      );
      print(response.data);
      return response.data[0]['detail'];
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }
}

final deleteByIdProvider = Provider.family<DeleteTaskById, String>((ref, id) => DeleteTaskById());