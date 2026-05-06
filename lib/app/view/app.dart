import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mintyn/app/view/app_bloc_provider.dart';
import 'package:mintyn/config/navigators/routes_generator.dart';
import 'package:mintyn/config/navigators/routes_manager.dart';
import 'package:mintyn/config/theme/theme.dart';
import 'package:mintyn/core/constants/keys.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        title: 'Mintyn',
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        navigatorKey: Keys.navigatorKey,
        onGenerateRoute: RoutesGenerator.onGenerateRoute,
        initialRoute: RoutesManager.splashRoute,
      ),
    );
  }
}
