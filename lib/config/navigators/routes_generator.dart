import 'package:flutter/material.dart';
import 'package:mintyn/config/navigators/routes_manager.dart';
import 'package:mintyn/config/navigators/undefined_route.dart';
import 'package:mintyn/features/auth/presentation/view/splash_view.dart';
import 'package:mintyn/features/home/presentation/view/dashboard_view.dart';
import 'package:page_transition/page_transition.dart';

class RoutesGenerator {
  RoutesGenerator._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Splash--------------------------------------------------------------------
      case RoutesManager.splashRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: const SplashView(),
        );
        
      //Dashboard------------------------------------------------------------------
      case RoutesManager.dashboardRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: const DashboardView(),
        );

      //Default
      default:
        return MaterialPageRoute(builder: (context) => const UndefinedRoute());
    }
  }
}
