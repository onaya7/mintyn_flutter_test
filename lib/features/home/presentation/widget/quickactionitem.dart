import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn/core/components/custom_ripple.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';

class QuickActionItem extends StatelessWidget {
  const QuickActionItem({required this.iconPath, required this.label, this.onTap, super.key});

  final String iconPath;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRipple(
          onTap: onTap,
          color: AppColor.greyT30,
          borderRadius: 100,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(100)),
            child: SvgPicture.asset(iconPath, height: 40, width: 40, fit: BoxFit.cover),
          ),
        ),
        AppSizes.h(6),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class ActionDivider extends StatelessWidget {
  const ActionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 51, child: VerticalDivider(color: AppColor.greyT50, thickness: 1, width: 1));
  }
}
