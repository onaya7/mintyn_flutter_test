import 'package:flutter/material.dart';
import 'package:mintyn/core/components/custom_appbar.dart';
import 'package:mintyn/core/components/custom_ripple.dart';
import 'package:mintyn/core/components/custom_scaffold.dart';
import 'package:mintyn/core/constants/app_color.dart';
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
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: Assets.images.cardBg.image().image, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
