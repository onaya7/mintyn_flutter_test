import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';

class TScrollBarTheme {
  TScrollBarTheme._();

  //Light Scrollbar Theme
  static ScrollbarThemeData lightScrollBarTheme = ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(true),
    trackColor: WidgetStateProperty.all(AppColor.text50),
    thumbColor: WidgetStateProperty.all(AppColor.text500),
    thickness: WidgetStateProperty.all(4),
    radius: const Radius.circular(15),
  );

  //Dark Scrollbar Theme
  static ScrollbarThemeData darkScrollBarTheme = ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(true),
    trackColor: WidgetStateProperty.all(AppColor.text50),
    thumbColor: WidgetStateProperty.all(AppColor.text500),
    thickness: WidgetStateProperty.all(4),
    radius: const Radius.circular(15),
  );
}
