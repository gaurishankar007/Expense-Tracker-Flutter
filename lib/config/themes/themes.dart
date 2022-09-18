import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundLight,
        primaryColor: AppColor.primary,
      );

  static ThemeData get dark => ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundDark,
        primaryColor: AppColor.primary,
      );
}
