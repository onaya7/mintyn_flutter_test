import 'package:flutter/material.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/components/custom_smartanimate.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/extensions/datetime_extension.dart';
import 'package:mintyn/core/extensions/int_extension.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:mintyn/features/card/presentation/widget/chart.dart';
import 'package:mintyn/features/card/presentation/widget/credit_card_widget.dart';
import 'package:mintyn/features/home/data/models/transactiondata.dart';
import 'package:mintyn/gen/assets.gen.dart';
import 'package:mintyn/utils/logger.dart';

class CardtransactionView extends StatelessWidget {
  const CardtransactionView({required this.card, super.key});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    final todayData = <TransactionData>[
      TransactionData(
        tranxType: 'shopping',
        title: 'Coffee Shop',
        dateTime: DateTime(2024, 8, 12, 9),
        amount: '-5.50',
        isDebit: true,
      ),
      TransactionData(
        tranxType: 'ewallet',
        title: 'Online Transfer',
        dateTime: DateTime(2024, 8, 12, 10),
        amount: '-200.00',
        isDebit: true,
      ),
      TransactionData(
        tranxType: 'wallet',
        title: 'Refund Received',
        dateTime: DateTime(2024, 8, 12, 11),
        amount: '+35.00',
        isDebit: false,
      ),
    ];
    return CustomScaffold(
      backgroundColor: AppColor.greyT10,
      appBar: CustomAppBar(
        appBarHeight: kToolbarHeight + 20,
        backgroundColor: AppColor.greyT10,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Card Transaction',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColor.white, fontWeight: FontWeight.w700, fontSize: 28),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.more_horiz, color: AppColor.white, size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SmartAnimate(
              preset: SmartAnimatePreset.scale,
              child: Align(
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: SizedBox(
                    height: 178,
                    child: CreditCardWidget(
                      lastFour: card.lastFour,
                      holder: card.holder,
                      validDate: card.validDate,
                      cvv: card.cvv,
                    ),
                  ),
                ),
              ),
            ),
            AppSizes.h(32),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 100)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
                child: SpendChartWidget(
                  title: 'Total Spend',
                  totalAmount: 30.toMoneyString(),
                  labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                  // Normalised (0.0–1.0) from spot Y-values below (max = 6300)
                  dataPoints: const [
                    0.44, // 2800
                    0.40, // 2500
                    0.51, // 3200
                    0.46, // 2900
                    0.58, // 3657
                    0.65, // 4100
                    0.71, // 4500
                    0.67, // 4200
                    0.89, // 5600
                    0.78, // 4900
                    0.75, // 4700
                    0.81, // 5100
                    1.00, // 6300
                    0.94, // 5900
                  ],
                  tooltipValueBuilder: (index, value) {
                    const rawValues = [
                      2800,
                      2500,
                      3200,
                      2900,
                      3657,
                      4100,
                      4500,
                      4200,
                      5600,
                      4900,
                      4700,
                      5100,
                      6300,
                      5900,
                    ];
                    return '\$${rawValues[index].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
                  },
                  onPeriodChanged: (value) {
                    logger.d('Selected period: $value');
                  },
                ),
              ),
            ),

            const Divider(color: AppColor.greyT30, thickness: 1, height: 32),
            SmartAnimate(
              config: const SmartAnimateConfig(delay: Duration(milliseconds: 180)),
              child: Padding(
                padding: const EdgeInsets.only(left: 21, right: 21),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction History',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 22),
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
                    AppSizes.h(16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todayData.length,
                      separatorBuilder: (_, __) => const Divider(color: AppColor.greyT50, thickness: 0.5, height: 1),
                      itemBuilder: (context, index) {
                        final item = todayData[index];
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
