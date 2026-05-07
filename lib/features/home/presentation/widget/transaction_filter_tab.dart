import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';

class TransactionFilterTab extends StatelessWidget {
  const TransactionFilterTab({required this.tabs, required this.selectedIndex, required this.onTabChanged, super.key});

  final List<String> tabs;
  final int selectedIndex;
  final void Function(int index) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < tabs.length; i++) ...[
          if (i > 0) AppSizes.w(14),
          GestureDetector(
            onTap: () => onTabChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              decoration: BoxDecoration(
                color: i == selectedIndex ? AppColor.primary : AppColor.greyT40,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                tabs[i],
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColor.white, fontSize: 11),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
