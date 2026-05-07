import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn/core/components/custom_cachedimage.dart';
import 'package:mintyn/core/components/custom_ripple.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/gen/assets.gen.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.greyT10,
      child: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            // Profile header
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CustomCachedImage.circular(
                        imageUrl: 'https://randomuser.me/api/portraits/men/75.jpg',
                        radius: 32,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Assets.icons.profileediticon.svg(height: 20, width: 20, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  AppSizes.h(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor.grey50,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Tayyab Sohail',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColor.greyT20, thickness: 1, height: 16),
            // Profile Settings
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: 'Profile Settings'),
                  AppSizes.h(17),
                  _DrawerItem(icon: Assets.icons.icon1.path, label: 'E-Statement', onTap: () {}),
                  AppSizes.h(17),
                  _DrawerItem(icon: Assets.icons.icon2.path, label: 'Credit Card', onTap: () {}),
                  AppSizes.h(17),
                  _DrawerItem(icon: Assets.icons.icon3.path, label: 'Settings', onTap: () {}),
                  AppSizes.h(36),

                  // Notification
                  const _SectionHeader(title: 'Notification'),
                  AppSizes.h(17),
                  _DrawerToggleItem(
                    icon: Assets.icons.icon4.path,
                    label: 'App Notification',
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  AppSizes.h(36),

                  // More
                  const _SectionHeader(title: 'More'),
                  AppSizes.h(17),
                  _DrawerItem(icon: Assets.icons.icon5.path, label: 'Language', onTap: () {}),
                  AppSizes.h(17),
                  _DrawerItem(icon: Assets.icons.icon6.path, label: 'Country', onTap: () {}),
                  AppSizes.h(28),

                  // Logout
                  CustomRipple(
                    onTap: () {},
                    color: AppColor.redT20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Logout',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: AppColor.redT30,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          AppSizes.w(10),
                          Assets.icons.logOut.svg(height: 20, width: 20, fit: BoxFit.cover),
                        ],
                      ),
                    ),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.icon, required this.label, required this.onTap});
  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomRipple(
      onTap: onTap,
      color: AppColor.greyT40,
      borderRadius: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 40, width: 40, fit: BoxFit.cover),
            AppSizes.w(14),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColor.white, size: 30),
          ],
        ),
      ),
    );
  }
}

class _DrawerToggleItem extends StatelessWidget {
  const _DrawerToggleItem({required this.icon, required this.label, required this.value, required this.onChanged});
  final String icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColor.greyT40, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 40, width: 40, fit: BoxFit.cover),

          AppSizes.w(14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColor.white,
            activeTrackColor: AppColor.blueT30,
            inactiveTrackColor: AppColor.greyT50,
          ),
        ],
      ),
    );
  }
}
