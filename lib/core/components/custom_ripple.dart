import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';

class CustomRipple extends StatelessWidget {
  const CustomRipple({
    required this.child,
    required this.onTap,
    this.borderRadius = 2,
    this.elevation = 0,
    this.color = AppColor.white,
    super.key,
  });
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
