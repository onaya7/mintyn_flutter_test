import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({required this.child, required this.onRefresh, super.key});
  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      displacement: 30,
      backgroundColor: AppColor.white,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
