import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Config {
  static const String endpoint = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  static const String bearer = 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
  static const String contentType = 'application/x-www-form-urlencoded';

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    if (token == null) {
      token = const Uuid().v4();
      await prefs.setString('token', token);
    }
    return token;
  }
}