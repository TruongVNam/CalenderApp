import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimens.dart';

class CalendarTheme {
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color headerBackground(BuildContext context) =>
      isDark(context) ? AppColors.greyDark : AppColors.greyLight;

  static Color footerBackground(BuildContext context) =>
      headerBackground(context);

  static Color themeToggleIconColor(BuildContext context) =>
      isDark(context) ? AppColors.yellow : AppColors.black;

  static Color primaryTextColor(BuildContext context) =>
      isDark(context) ? AppColors.white : AppColors.black;

  static Color dayNumberColor(BuildContext context) =>
      primaryTextColor(context);

  static Color monthTitleColor(BuildContext context, DateTime now, int year, int month) {
    final isCurrent = now.year == year && now.month == month;
    if (isCurrent) return AppColors.red;
    return isDark(context) ? Colors.white70 : Colors.grey.shade600;
  }

  static Color backgroundColor(BuildContext context) => // 👈 thêm dòng này
  isDark(context) ? Colors.black : Colors.white;

  static const Color footerTextColor = AppColors.red;
}
