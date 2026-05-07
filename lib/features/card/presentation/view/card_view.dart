import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mintyn/config/navigators/navigators.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/helpers/ui_helpers.dart';
import 'package:mintyn/features/card/data/model/card_data.dart';
import 'package:mintyn/features/card/presentation/widget/card_quick_action.dart';
import 'package:mintyn/features/card/presentation/widget/card_setting_items.dart';
import 'package:mintyn/features/card/presentation/widget/credit_card_widget.dart';
import 'package:mintyn/gen/assets.gen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late int _selectedTabIndex;
  late int _activeCardIndex;
  late bool _isFrozen;
  late bool _changePin;
  late bool _qrPayment;
  late bool _onlineShopping;
  late bool _tapPay;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = 0;
    _activeCardIndex = 0;
    _isFrozen = false;
    _changePin = true;
    _qrPayment = true;
    _onlineShopping = false;
    _tapPay = true;
  }

  static const List<String> _tabs = ['Physical Card', 'Virtual Card'];

  static const List<CardData> _physicalCards = [
    CardData(lastFour: '1234', holder: 'Tayyab Sohail', validDate: '12/02/2024', cvv: '123'),
    CardData(lastFour: '4521', holder: 'Tayyab Sohail', validDate: '12/26/2024', cvv: '456'),
    CardData(lastFour: '8803', holder: 'Tayyab Sohail', validDate: '08/27/2024', cvv: '789'),
  ];

  static const List<CardData> _virtualCards = [
    CardData(lastFour: '3390', holder: 'John Doe', validDate: '05/25', cvv: '321'),
  ];

  List<CardData> get _activeCards => _selectedTabIndex == 0 ? _physicalCards : _virtualCards;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColor.greyT10,
      appBar: CustomAppBar(
        appBarHeight: kToolbarHeight + 20,
        backgroundColor: AppColor.greyT10,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Card',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.white, fontWeight: FontWeight.w700, fontSize: 28),
            ),
            AppSizes.h(4),
            Text(
              '2 Physical Card, 1 Virtual Card',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.greyT70, fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(left: 20, right: 20), child: _buildTabRow()),
            AppSizes.h(24),
            _buildCardCarousel(),
            AppSizes.h(12),
            Center(child: _buildIndicator()),
            AppSizes.h(22),
            _buildQuickActions(),
            const Divider(color: AppColor.greyT30, thickness: 1, height: 32),
            Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 32), child: _buildCardSettings()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabRow() {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isActive = _selectedTabIndex == index;
        return GestureDetector(
          onTap: () => setState(() {
            _selectedTabIndex = index;
            _activeCardIndex = 0;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
            margin: EdgeInsets.only(right: index < _tabs.length - 1 ? 10 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isActive ? AppColor.blueT20 : AppColor.greyT90, width: 1.5),
              color: AppColor.greyT90,
            ),
            child: Text(
              _tabs[index],
              style: TextStyle(
                color: isActive ? AppColor.white : AppColor.greyT100,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCardCarousel() {
    return CarouselSlider.builder(
      itemCount: _activeCards.length,
      options: CarouselOptions(
        height: 178,
        viewportFraction: _activeCards.length > 1 ? 0.73 : 0.85,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, _) => setState(() => _activeCardIndex = index),
      ),
      itemBuilder: (context, index, _) {
        final card = _activeCards[index];
        return CreditCardWidget(lastFour: card.lastFour, holder: card.holder, validDate: card.validDate, cvv: card.cvv);
      },
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _activeCardIndex,
      count: _activeCards.length,
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: AppColor.blueT40,
        dotColor: AppColor.greyT100,
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CardQuickAction(
          iconPath: Assets.icons.freezecard.path,
          label: _isFrozen ? 'Unfreeze' : 'Freeze Card',
          onTap: () => setState(() => _isFrozen = !_isFrozen),
        ),
        CardQuickAction(iconPath: Assets.icons.reveal.path, label: 'Reveal', onTap: () {}),
        CardQuickAction(iconPath: Assets.icons.freezecard.path, label: 'Freeze Card', onTap: () {}),
      ],
    );
  }

  Widget _buildCardSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Settings',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColor.white, fontWeight: FontWeight.w400, fontSize: 28),
        ),
        AppSizes.h(24),
        CardSettingToggle(
          iconPath: Assets.icons.changepin.path,
          label: 'Change Pin',
          value: _changePin,
          onChanged: (v) => setState(() => _changePin = v),
        ),
        AppSizes.h(19),
        CardSettingToggle(
          iconPath: Assets.icons.qrpayment.path,
          label: 'QR Payment',
          value: _qrPayment,
          onChanged: (v) => setState(() => _qrPayment = v),
        ),
        AppSizes.h(19),
        CardSettingToggle(
          iconPath: Assets.icons.onlineshopping.path,
          label: 'Online Shopping',
          value: _onlineShopping,
          onChanged: (v) => setState(() => _onlineShopping = v),
        ),
        AppSizes.h(19),
        CardSettingNavItem(
          iconPath: Assets.icons.cardtrnx.path,
          label: 'Card Transactions',
          onTap: () => UiHelpers.navigateToPage(RoutesName.cardTransactionRoute),
        ),
        AppSizes.h(19),
        CardSettingToggle(
          iconPath: Assets.icons.tappay.path,
          label: 'Tap Pay',
          value: _tapPay,
          onChanged: (v) => setState(() => _tapPay = v),
        ),
      ],
    );
  }
}
