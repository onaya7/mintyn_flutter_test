import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();
  static String appName = dotenv.env['APP_NAME']!;
  static String apiBaseUrl = dotenv.env['BASE_URL']!;
  static String mintynDb = dotenv.env['MINTYN_DB']!;
}
