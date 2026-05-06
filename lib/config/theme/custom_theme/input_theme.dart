import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';

class TInputDecorationTheme {
  TInputDecorationTheme._();

  static InputDecorationTheme inputDecorationThemeLight = const InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    labelStyle: TextStyle(color: AppColor.text400, fontSize: 20, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  );

  static InputDecorationTheme inputDecorationThemeDark = const InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    labelStyle: TextStyle(color: AppColor.white, fontSize: 20, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  );
}
