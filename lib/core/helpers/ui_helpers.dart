import 'dart:io';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/core/constants/enums.dart';
import 'package:mintyn/core/constants/keys.dart';
import 'package:mintyn/utils/logger.dart';
import 'package:uuid/uuid.dart';

class UiHelpers {
  //UI helper functions---------------------------------------------------------
  static void showToast(BuildContext context, String status, String message) {
    final contexts = Keys.navigatorKey.currentContext!;
    final statusToIcon = {
      'success': const Icon(Icons.check_circle_outline, color: AppColor.white),
      'error': const Icon(Icons.error_outline, color: AppColor.white),
      'info': const Icon(Icons.info_outline, color: AppColor.white),
      'warning': const Icon(Icons.warning_amber_outlined, color: AppColor.white),
    };

    final color = {
      'success': AppColor.successBorder,
      'error': AppColor.errorBorder,
      'info': AppColor.infoBorder,
      'warning': AppColor.warningBorder,
    };

    final bgColor = {
      'success': AppColor.successBorder,
      'error': AppColor.errorBorder,
      'info': AppColor.infoBorder,
      'warning': AppColor.warningBorder,
    };

    final textColor = color[status];
    final icon = statusToIcon[status];
    final bg = bgColor[status];

    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 3),
      position: DelightSnackbarPosition.top,
      builder: (context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: textColor ?? AppColor.grey200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  icon ?? const SizedBox(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      maxLines: 2,
                      style: const TextStyle(color: AppColor.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            AppSizes.w(10),
            GestureDetector(
              onTap: DelightToastBar.removeAll,
              child: const Icon(Icons.close, color: AppColor.white, size: 15),
            ),
          ],
        ),
      ),
    ).show(contexts);
  }

  //Unfocus --------------------------------------------------------------------
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  //CloseKeyboard --------------------------------------------------------------

  static void closeKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasPrimaryFocus || FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  //Navigator helper functions -------------------------------------------------

  static dynamic navigateToPage(String routeName, {Object? arguments}) {
    logger.i(':::::::::::::::::::::::::::Navigating to $routeName::::::::::::::::::::');
    Keys.navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static void popPage() {
    Keys.navigatorKey.currentState!.pop();
  }

  static dynamic navigateToPageAndReplace(String routeName, {Object? arguments}) {
    logger.i(':::::::::::::::::::::::::::Navigating to $routeName::::::::::::::::::::');
    Keys.navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static dynamic navigateToPageAndRemoveUntil(String routeName, {Object? arguments}) {
    logger.i(':::::::::::::::::::::::::::Navigating to $routeName::::::::::::::::::::');
    Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  //isDarkMode -------------------------------------------------------------------
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  //Shift focus functions --------------------------------------------------------
  static void shiftFocus(BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (nextFocus != null) {
      currentFocus?.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    } else {
      currentFocus?.unfocus();
    }
  }

  //Date Picker  ---------------------------------------------------------------
  static Future<DateTime?> datePicker(BuildContext context) async {
    DateTime? selectedDate;

    if (Platform.isAndroid || Platform.isIOS) {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
      );
    } else if (Platform.isFuchsia || Platform.isLinux || Platform.isWindows) {
      final selectedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
      );

      if (selectedDateRange != null) {
        selectedDate = selectedDateRange.start;
      }
    }

    return selectedDate;
  }

  //Time Picker  ---------------------------------------------------------------
  static Future<TimeOfDay?> timePicker(BuildContext context) async {
    final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return selectedTime;
  }

  //Capitalize first letter ----------------------------------------------------
  static String capitalizeFirstLetter(String name) {
    if (name.isEmpty) {
      return name;
    }
    return name
        .split(' ')
        .map((word) {
          final firstLetter = word.isNotEmpty ? word[0].toUpperCase() : '';
          final remainingLetters = word.length > 1 ? word.substring(1).toLowerCase() : '';
          return firstLetter + remainingLetters;
        })
        .join(' ');
  }

  // Generate unique Id --------------------------------------------------------
  static String generateUniqueId() {
    const uuid = Uuid();
    return uuid.v1();
  }

  //Haptic Feedback  -----------------------------------------------------------
  static Future<void> hapticFeedback({FeedbackType type = FeedbackType.medium}) async {
    try {
      if (Platform.isIOS) {
        // iOS - Use native Taptic Engine
        switch (type) {
          case FeedbackType.light:
            await HapticFeedback.lightImpact();
          case FeedbackType.medium:
            await HapticFeedback.mediumImpact();
          case FeedbackType.heavy:
            await HapticFeedback.heavyImpact();
          case FeedbackType.selection:
            await HapticFeedback.selectionClick();
          case FeedbackType.impact:
            await HapticFeedback.mediumImpact();
        }
      } else if (Platform.isAndroid) {
        // Android - All types map to vibrate() which uses the vibration motor
        // Android's haptic feedback is less granular than iOS
        switch (type) {
          case FeedbackType.light:
          case FeedbackType.selection:
            await HapticFeedback.lightImpact();
          case FeedbackType.medium:
          case FeedbackType.impact:
            await HapticFeedback.mediumImpact();
          case FeedbackType.heavy:
            await HapticFeedback.heavyImpact();
        }
      }
    } catch (e) {
      logger.e('Haptic feedback error: $e');
    }
  }
}
