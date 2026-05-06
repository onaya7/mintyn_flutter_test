import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';

class TAppBarTheme {
  TAppBarTheme._();

  // Light AppBar Theme
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.white,
    surfaceTintColor: AppColor.white,
    iconTheme: IconThemeData(color: AppColor.white),
    actionsIconTheme: IconThemeData(color: AppColor.white),
    titleTextStyle: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w600),
  );

  // Dark AppBar Theme
  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.black,
    surfaceTintColor: AppColor.black,
    iconTheme: IconThemeData(color: AppColor.black),
    actionsIconTheme: IconThemeData(color: AppColor.black),
    titleTextStyle: TextStyle(color: AppColor.black, fontSize: 18, fontWeight: FontWeight.w600),
  );
}
