import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';

class CardSettingToggle extends StatelessWidget {
  const CardSettingToggle({
    required this.iconPath,
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String iconPath;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(color: AppColor.greyT20, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SvgPicture.asset(iconPath, height: 28, width: 28, fit: BoxFit.cover),
          AppSizes.w(12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColor.white, fontWeight: FontWeight.w400, fontSize: 22),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColor.white,
            activeTrackColor: AppColor.blueT30,
            inactiveTrackColor: AppColor.greyT50,
            inactiveThumbColor: AppColor.white,
          ),
        ],
      ),
    );
  }
}

class CardSettingNavItem extends StatelessWidget {
  const CardSettingNavItem({required this.iconPath, required this.label, this.onTap, super.key});

  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(color: AppColor.greyT20, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, height: 28, width: 28, fit: BoxFit.cover),
            AppSizes.w(12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColor.white, fontWeight: FontWeight.w400, fontSize: 22),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColor.white, size: 30),
          ],
        ),
      ),
    );
  }
}
