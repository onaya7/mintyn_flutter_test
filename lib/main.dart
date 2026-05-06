import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mintyn/app/app.dart';
import 'package:mintyn/app/view/app_hive_adapters.dart';
import 'package:mintyn/bootstrap.dart';
import 'package:mintyn/core/constants/env.dart';
import 'package:mintyn/core/injections/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load();
  await Hive.initFlutter();
  AppHiveAdapters.registerAdapters();
  await Hive.openBox(Env.mintynDb);
  configureDependencies();
  await bootstrap(
    () => DevicePreview(
      builder: (context) {
        return const App();
      },
    ),
  );
}
