import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_ripple.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/components/custom_smartanimate.dart';
import 'package:mintyn/core/components/state_widgets.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/constants/keys.dart';
import 'package:mintyn/core/extensions/int_extension.dart';
import 'package:mintyn/features/home/presentation/cubit/balance_cubit.dart';
import 'package:mintyn/features/home/presentation/cubit/history_cubit.dart';
import 'package:mintyn/features/home/presentation/widget/balance_card.dart';
import 'package:mintyn/features/home/presentation/widget/dashboard_drawer.dart';
import 'package:mintyn/features/home/presentation/widget/quickactionitem.dart';
import 'package:mintyn/features/home/presentation/widget/transaction_filter_tab.dart';
import 'package:mintyn/features/home/presentation/widget/transaction_list_view.dart';
import 'package:mintyn/gen/assets.gen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  static const List<String> _tabs = ['Weekly', 'Monthly', 'Today'];

  static const List<String> _periodMap = ['weekly', 'monthly', 'today'];
  int _selectedTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = Keys.scaffoldKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<BalanceCubit>().loadBalance();
        context.read<HistoryCubit>().loadHistory();
      }
    });
  }

  void _onTabChanged(int index) {
    setState(() => _selectedTabIndex = index);
    context.read<HistoryCubit>().loadHistory(period: _periodMap[index]);
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      context.read<BalanceCubit>().loadBalance(),
      context.read<HistoryCubit>().loadHistory(period: _periodMap[_selectedTabIndex]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scaffoldKey: _scaffoldKey,
      drawer: const DashboardDrawer(),
      appBar: CustomAppBar(
        leading: CustomRipple(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          color: Colors.transparent,
          borderRadius: 100,
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            child: Assets.icons.hamburger.svg(height: 20, width: 20, fit: BoxFit.cover),
          ),
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
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColor.blueT10,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 34, 16, 0),
          children: [
            SmartAnimate(
              child: BlocBuilder<BalanceCubit, BalanceState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const BalanceCardShimmer(),
                    loading: () => const BalanceCardShimmer(),
                    loaded: (balance) => BalanceCard(balance: balance.balance.toMoneyString()),
                    error: (msg) =>
                        AppErrorState(message: msg, onRetry: () => context.read<BalanceCubit>().loadBalance()),
                  );
                },
              ),
            ),
            AppSizes.h(30),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 80)),
              child: Container(
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
            ),
            AppSizes.h(30),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 160)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: AppColor.blueT10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSizes.h(11),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 210)),
              child: TransactionFilterTab(tabs: _tabs, selectedIndex: _selectedTabIndex, onTabChanged: _onTabChanged),
            ),
            AppSizes.h(10),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 260)),
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const TransactionListShimmer(),
                    loading: () => const TransactionListShimmer(),
                    loaded: (transactions) => TransactionListView(items: transactions),
                    error: (msg) => AppErrorState(
                      message: msg,
                      onRetry: () => context.read<HistoryCubit>().loadHistory(period: _periodMap[_selectedTabIndex]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
