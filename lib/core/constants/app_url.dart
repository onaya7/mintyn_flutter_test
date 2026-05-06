import 'package:mintyn/core/constants/env.dart';

class AppUrl {
  AppUrl._();

  //Base URL
  static String baseUrl = Env.apiBaseUrl;

  static String getHomeData() => '$baseUrl/home';

  // Auth Endpoints ------------------------------------------------------------

  // Home Endpoints ------------------------------------------------------------
}
