import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mintyn/config/navigators/routes_manager.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/helpers/ui_helpers.dart';
import 'package:mintyn/gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      UiHelpers.navigateToPageAndRemoveUntil(RoutesManager.dashboardRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        color: AppColor.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: AppSizes.screenWidth(context),
                color: AppColor.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Assets.images.appLogo
                        .image(width: 300, height: 300)
                        .animate()
                        .scale(delay: 100.ms, duration: 500.ms)
                        .then(delay: 500.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
