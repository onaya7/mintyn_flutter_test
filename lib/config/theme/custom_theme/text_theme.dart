import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';

class TTextTheme {
  TTextTheme._();

  //Light Text Theme
  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppColor.text900),
    headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.text500),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColor.text400),
    bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.text900),
    bodyMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.text500),
    bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.text500),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.text50),
  );

  // Dark Text Theme
  static TextTheme darkTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppColor.white),
    headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.white),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColor.white),
    bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.white),
    bodyMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.white),
    bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.white),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.white),
  );
}
