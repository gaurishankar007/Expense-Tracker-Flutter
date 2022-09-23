import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundLight,
        primaryColor: AppColor.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: AppSize.subtitle2Button["size"],
              fontWeight: AppSize.subtitle2Button["weight"],
            ),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundDark,
        primaryColor: AppColor.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: AppSize.subtitle2Button["size"],
              fontWeight: AppSize.subtitle2Button["weight"],
            ),
          ),
        ),
      );
}
