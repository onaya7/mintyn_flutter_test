import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/extensions/datetime_extension.dart';
import 'package:mintyn/gen/assets.gen.dart';

// final List<String> types = ['wallet', 'shopping', 'ewallet', 'bankingFee', 'savings'];

class TransactionListView extends StatelessWidget {
  const TransactionListView({required this.type, super.key});

  final String type;

  static final List<_TransactionData> _weeklyData = [
    _TransactionData(
      tranxType: 'wallet',
      title: 'Netflix Subscription',
      dateTime: DateTime(2024, 8, 12, 14, 45),
      amount: '-14.99',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'savings',
      title: 'Salary Credit',
      dateTime: DateTime(2024, 8, 12, 14, 45),
      amount: '+3,200.00',
      isDebit: false,
    ),
    _TransactionData(
      tranxType: 'shopping',
      title: 'Grocery Store',
      dateTime: DateTime(2024, 8, 12, 14, 45),
      amount: '-87.40',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'ewallet',
      title: 'Uber Ride',
      dateTime: DateTime(2024, 8, 12, 14, 45),
      amount: '-12.50',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'savings',
      title: 'Freelance Payment',
      dateTime: DateTime(2024, 8, 12, 14, 45),
      amount: '+450.00',
      isDebit: false,
    ),
  ];

  static final List<_TransactionData> _monthlyData = [
    _TransactionData(
      tranxType: 'bankingFee',
      title: 'Rent Payment',
      dateTime: DateTime(2024, 8, 1, 9),
      amount: '-1,200.00',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'bankingFee',
      title: 'Electricity Bill',
      dateTime: DateTime(2024, 8, 5, 10),
      amount: '-65.00',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'savings',
      title: 'Monthly Salary',
      dateTime: DateTime(2024, 8, 10, 12),
      amount: '+3,200.00',
      isDebit: false,
    ),
    _TransactionData(
      tranxType: 'bankingFee',
      title: 'Internet Bill',
      dateTime: DateTime(2024, 8, 15, 11),
      amount: '-40.00',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'wallet',
      title: 'Gym Membership',
      dateTime: DateTime(2024, 8, 20, 8),
      amount: '-30.00',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'savings',
      title: 'Consulting Fee',
      dateTime: DateTime(2024, 8, 25, 14),
      amount: '+800.00',
      isDebit: false,
    ),
  ];

  static final List<_TransactionData> _todayData = [
    _TransactionData(
      tranxType: 'shopping',
      title: 'Coffee Shop',
      dateTime: DateTime(2024, 8, 12, 9),
      amount: '-5.50',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'ewallet',
      title: 'Online Transfer',
      dateTime: DateTime(2024, 8, 12, 10),
      amount: '-200.00',
      isDebit: true,
    ),
    _TransactionData(
      tranxType: 'wallet',
      title: 'Refund Received',
      dateTime: DateTime(2024, 8, 12, 11),
      amount: '+35.00',
      isDebit: false,
    ),
  ];

  List<_TransactionData> get _items {
    switch (type) {
      case 'Monthly':
        return _monthlyData;
      case 'Today':
        return _todayData;
      default:
        return _weeklyData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(color: AppColor.greyT50, thickness: 0.5, height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              _buildTranxIcon(item.tranxType),
              AppSizes.w(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    AppSizes.h(4),
                    Text.rich(
                      TextSpan(
                        text: item.dateTime.toTimeString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor.greyT70,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: ' • ',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.greyT80,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: item.dateTime.toDateString(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.greyT70,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item.amount,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: item.isDebit ? AppColor.redT10 : AppColor.blueT20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTranxIcon(String tranxType) {
    final SvgGenImage icon;
    switch (tranxType) {
      case 'shopping':
        icon = Assets.icons.shopping;
      case 'ewallet':
        icon = Assets.icons.ewallet;
      case 'bankingFee':
        icon = Assets.icons.bankingfee;
      case 'savings':
        icon = Assets.icons.savings;
      case 'wallet':
      default:
        icon = Assets.icons.wallet;
    }
    return icon.svg(height: 52, width: 52, fit: BoxFit.cover);
  }
}

class _TransactionData {
  const _TransactionData({
    required this.tranxType,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.isDebit,
  });

  final String tranxType;
  final String title;
  final DateTime dateTime;
  final String amount;
  final bool isDebit;
}
