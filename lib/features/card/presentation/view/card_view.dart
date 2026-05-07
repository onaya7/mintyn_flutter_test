import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mintyn/config/navigators/navigators.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/components/custom_smartanimate.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/helpers/ui_helpers.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:mintyn/features/card/presentation/cubit/card_cubit.dart';
import 'package:mintyn/features/card/presentation/widget/card_quick_action.dart';
import 'package:mintyn/features/card/presentation/widget/card_setting_items.dart';
import 'package:mintyn/features/card/presentation/widget/credit_card_widget.dart';
import 'package:mintyn/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  int _selectedTabIndex = 0;
  int _activeCardIndex = 0;
  bool _isFrozen = false;
  bool _changePin = true;
  bool _qrPayment = true;
  bool _onlineShopping = false;
  bool _tapPay = true;

  static const List<String> _tabs = ['Physical Card', 'Virtual Card'];

  @override
  void initState() {
    super.initState();
    context.read<CardCubit>().loadCounts();
    context.read<CardCubit>().loadCards();
  }

  void _onTabChanged(int index) {
    if (_selectedTabIndex == index) return;
    setState(() {
      _selectedTabIndex = index;
      _activeCardIndex = 0;
    });
    context.read<CardCubit>().loadCards(type: index == 0 ? 'physical' : 'virtual');
  }

  void _syncSettingsFromCard(CardModel card) {
    _changePin = card.settings.changePinEnabled;
    _qrPayment = card.settings.qrPaymentEnabled;
    _onlineShopping = card.settings.onlineShoppingEnabled;
  }

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
            BlocBuilder<CardCubit, CardState>(
              builder: (context, _) {
                final counts = context.read<CardCubit>().cardCounts;
                if (counts.isEmpty) return const SizedBox.shrink();
                final p = counts['physical'] ?? 0;
                final v = counts['virtual'] ?? 0;
                return Text(
                  '$p Physical ${p == 1 ? 'Card' : 'Cards'}, $v Virtual ${v == 1 ? 'Card' : 'Cards'}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColor.greyT70, fontWeight: FontWeight.w400, fontSize: 12),
                );
              },
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
      body: BlocListener<CardCubit, CardState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (cards) => setState(() {
              _activeCardIndex = 0;
              if (cards.isNotEmpty) _syncSettingsFromCard(cards.first);
            }),
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartAnimate(
                preset: SmartAnimatePreset.fadeSlideDown,
                child: Padding(padding: const EdgeInsets.only(left: 20, right: 20), child: _buildTabRow()),
              ),
              AppSizes.h(24),
              SmartAnimate(
                preset: SmartAnimatePreset.scale,
                config: const SmartAnimateConfig(delay: Duration(milliseconds: 80)),
                child: BlocBuilder<CardCubit, CardState>(
                  builder: (context, state) => state.when(
                    initial: () => const _CardCarouselShimmer(),
                    loading: () => const _CardCarouselShimmer(),
                    loaded: _buildCardCarousel,
                    error: (_) => const _CardCarouselShimmer(),
                  ),
                ),
              ),
              AppSizes.h(12),
              SmartAnimate(
                preset: SmartAnimatePreset.fadeIn,
                config: const SmartAnimateConfig(delay: Duration(milliseconds: 150)),
                child: BlocBuilder<CardCubit, CardState>(
                  builder: (context, state) => state.maybeWhen(
                    loaded: (cards) => Center(child: _buildIndicator(cards)),
                    orElse: () => const SizedBox(height: 20),
                  ),
                ),
              ),
              AppSizes.h(22),
              SmartAnimate(
                config: const SmartAnimateConfig(delay: Duration(milliseconds: 200)),
                child: _buildQuickActions(),
              ),
              const Divider(color: AppColor.greyT30, thickness: 1, height: 32),
              SmartAnimate(
                config: const SmartAnimateConfig(delay: Duration(milliseconds: 260)),
                child: Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 32), child: _buildCardSettings()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabRow() {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isActive = _selectedTabIndex == index;
        return GestureDetector(
          onTap: () => _onTabChanged(index),
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

  Widget _buildCardCarousel(List<CardModel> cards) {
    if (cards.isEmpty) return const _CardCarouselShimmer();
    return CarouselSlider.builder(
      itemCount: cards.length,
      options: CarouselOptions(
        height: 178,
        viewportFraction: cards.length > 1 ? 0.73 : 0.85,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, _) => setState(() {
          _activeCardIndex = index;
          _syncSettingsFromCard(cards[index]);
        }),
      ),
      itemBuilder: (context, index, _) {
        final card = cards[index];
        return CreditCardWidget(lastFour: card.lastFour, holder: card.holder, validDate: card.validDate, cvv: card.cvv);
      },
    );
  }

  Widget _buildIndicator(List<CardModel> cards) {
    if (cards.isEmpty) return const SizedBox.shrink();
    return AnimatedSmoothIndicator(
      activeIndex: _activeCardIndex,
      count: cards.length,
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
        BlocBuilder<CardCubit, CardState>(
          builder: (context, state) => CardSettingNavItem(
            iconPath: Assets.icons.cardtrnx.path,
            label: 'Card Transactions',
            onTap: () {
              final cards = state.whenOrNull(loaded: (cards) => cards);
              if (cards == null || cards.isEmpty) return;
              UiHelpers.navigateToPage(
                RoutesName.cardTransactionRoute,
                arguments: cards[_activeCardIndex.clamp(0, cards.length - 1)],
              );
            },
          ),
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

class _CardCarouselShimmer extends StatelessWidget {
  const _CardCarouselShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.greyT20,
      highlightColor: AppColor.greyT40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 178,
            width: double.infinity,
            color: AppColor.greyT20,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 24,
                    width: 36,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 32,
                  width: 60,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                ),
                const Spacer(),
                Container(
                  height: 14,
                  width: 180,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      height: 28,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 28,
                      width: 55,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 28,
                      width: 45,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
