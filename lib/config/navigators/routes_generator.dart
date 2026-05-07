import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mintyn/config/navigators/routes_name.dart';
import 'package:mintyn/config/navigators/undefined_route.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:mintyn/features/card/presentation/view/card_view.dart';
import 'package:mintyn/features/card/presentation/view/cardtransaction_view.dart';
import 'package:mintyn/features/home/presentation/view/dashboard_view.dart';
import 'package:mintyn/features/splash/presentation/view/splash_view.dart';
import 'package:page_transition/page_transition.dart';

class RoutesGenerator {
  RoutesGenerator._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Splash--------------------------------------------------------------------
      case RoutesName.splashRoute:
        return PageTransition(
          isIos: Platform.isIOS,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: const SplashView(),
        );

      //Dashboard------------------------------------------------------------------
      case RoutesName.dashboardRoute:
        return PageTransition(
          isIos: Platform.isIOS,

          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: const DashboardView(),
        );

      //Card-----------------------------------------------------------------------
      case RoutesName.cardRoute:
        return PageTransition(
          isIos: Platform.isIOS,

          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: const CardView(),
        );

      case RoutesName.cardTransactionRoute:
        final card = settings.arguments! as CardModel;
        return PageTransition(
          isIos: Platform.isIOS,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          child: CardtransactionView(card: card),
        );

      //Default
      default:
        return MaterialPageRoute(builder: (context) => const UndefinedRoute());
    }
  }
}
