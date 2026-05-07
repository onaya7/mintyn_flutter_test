import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/extensions/datetime_extension.dart';
import 'package:mintyn/features/card/data/model/card_data.dart';
import 'package:mintyn/features/card/presentation/widget/credit_card_widget.dart';
import 'package:mintyn/features/card/presentation/widget/flchart.dart';
import 'package:mintyn/features/home/data/models/transactiondata.dart';
import 'package:mintyn/gen/assets.gen.dart';
import 'package:mintyn/utils/logger.dart';

class CardtransactionView extends StatelessWidget {
  const CardtransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    const card = CardData(lastFour: '3390', holder: 'John Doe', validDate: '05/25', cvv: '321');
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
            Align(
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
            AppSizes.h(32),
            Padding(
              padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
              child: FlSpendChartWidget(
                title: 'Total Spend',
                totalAmount: r'$30',
                labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                spots: const [
                  FlSpot(0, 2800),
                  FlSpot(0.4, 2500),
                  FlSpot(0.8, 3200),
                  FlSpot(1.2, 2900),
                  FlSpot(1.6, 3657),
                  FlSpot(2, 4100),
                  FlSpot(2.4, 4500),
                  FlSpot(2.8, 4200),
                  FlSpot(3.2, 5600),
                  FlSpot(3.6, 4900),
                  FlSpot(4, 4700),
                  FlSpot(4.4, 5100),
                  FlSpot(4.8, 6300),
                  FlSpot(5, 5900),
                ],
                onPeriodChanged: (value) {
                  logger.d('Selected period: $value');
                },
              ),
            ),
            const Divider(color: AppColor.greyT30, thickness: 1, height: 32),
            Padding(
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
