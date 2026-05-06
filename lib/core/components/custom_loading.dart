import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mintyn/core/constants/app_size.dart';

import '../constants/app_color.dart';
import 'custom_scaffold.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.title, this.subtitile = 'This will only take few seconds'});
  final String? title;
  final String? subtitile;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(color: AppColor.purple, borderRadius: BorderRadius.circular(10)),
              child: const SpinKitThreeBounce(color: AppColor.white, size: 20),
            ),
            AppSizes.h(10),
            Text(
              subtitile.toString(),
              style: const TextStyle(color: AppColor.text400, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
