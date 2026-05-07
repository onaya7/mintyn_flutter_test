import 'package:flutter/material.dart';
import 'package:mintyn/core/components/state_widgets.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/extensions/datetime_extension.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';
import 'package:mintyn/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({required this.items, super.key});

  final List<TransactionHistoryModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const AppEmptyState(
        title: 'No transactions',
        subtitle: 'Your transaction history will appear here.',
        icon: Icons.receipt_long_outlined,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(color: AppColor.greyT50, thickness: 0.5, height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              _buildTranxIcon(item.tranxType ?? 'wallet'),
              AppSizes.w(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    AppSizes.h(4),
                    Text.rich(
                      TextSpan(
                        text: item.dateTime?.toTimeString() ?? '',
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
                            text: item.dateTime?.toDateString() ?? '',
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
                item.amount ?? '',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: (item.isDebit ?? true) ? AppColor.redT10 : AppColor.blueT20,
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

class TransactionListShimmer extends StatelessWidget {
  const TransactionListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.greyT20,
      highlightColor: AppColor.greyT40,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(color: AppColor.greyT50, thickness: 0.5, height: 1),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              AppSizes.w(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    AppSizes.h(8),
                    Container(
                      height: 11,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
