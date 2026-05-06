import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  //getscreenwidth
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

//getscreenheight
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

//getstatusbarheight
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

//getkeyboardHeight
  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

//getkeyboardTopPadding
  static double keyboardTopPadding(BuildContext context) {
    return MediaQuery.of(context).viewInsets.top;
  }

//getkeyboardBottomPadding
  static double keyboardBottomPadding(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

//getkeyboardLeftPadding
  static double keyboardLeftPadding(BuildContext context) {
    return MediaQuery.of(context).viewInsets.left;
  }

//getkeyboardRightPadding
  static double keyboardRightPadding(BuildContext context) {
    return MediaQuery.of(context).viewInsets.right;
  }

//getappbarheight
  static double get appBarHeight => kToolbarHeight;
  //getbottomNavheight
  static double get bottomNavHeight => kBottomNavigationBarHeight;

  //SizedBox
  static SizedBox w(double? width) {
    return SizedBox(
      width: width,
    );
  }

  //SizedBox
  static SizedBox h(double? height) {
    return SizedBox(
      height: height,
    );
  }
}
