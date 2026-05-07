import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn/core/constants/app_size.dart';

class CardQuickAction extends StatelessWidget {
  const CardQuickAction({required this.iconPath, required this.label, this.onTap, super.key});

  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(iconPath, height: 46, width: 46, fit: BoxFit.cover),
        ),
        AppSizes.h(6),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
