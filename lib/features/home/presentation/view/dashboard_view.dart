import 'package:flutter/material.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_ripple.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/extensions/int_extension.dart';
import 'package:mintyn/features/home/presentation/widget/balance_card.dart';
import 'package:mintyn/features/home/presentation/widget/quickactionitem.dart';
import 'package:mintyn/gen/assets.gen.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        leading: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: Assets.icons.hamburger.svg(height: 20, width: 20, fit: BoxFit.cover),
        ),
        title: Text.rich(
          TextSpan(
            text: 'Welcome ',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: 'Tayyab Sohail',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomRipple(
              onTap: () {},
              color: AppColor.greyT30,
              borderRadius: 100,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(100)),
                alignment: Alignment.center,
                child: Assets.icons.bellNotification.svg(height: 20, width: 20, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 34, 16, 0),
        children: [
          BalanceCard(balance: 1200.toMoneyString()),
          AppSizes.h(30),
          Container(
            height: 112,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.greyT40,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppColor.greyT20, width: 1.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuickActionItem(iconPath: Assets.icons.billpay.path, label: 'Bill Pay', onTap: () {}),
                const ActionDivider(),
                QuickActionItem(iconPath: Assets.icons.donations.path, label: 'Donations', onTap: () {}),
                const ActionDivider(),
                QuickActionItem(iconPath: Assets.icons.deposit.path, label: 'Deposit', onTap: () {}),
                const ActionDivider(),
                QuickActionItem(iconPath: Assets.icons.more.path, label: 'More', onTap: () {}),
              ],
            ),
          ),
          AppSizes.h(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction History',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              Text(
                'See all',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColor.blueT10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
