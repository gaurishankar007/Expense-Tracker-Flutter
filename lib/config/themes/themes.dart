import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';

ColorScheme appLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF6200EE),
  primaryContainer: Color(0xFF3700B3),
  secondary: Color(0xFF03DAC6),
  secondaryContainer: Color(0xFF018786),
  background: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  error: Color(0xFFB00020),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFF000000),
  onBackground: Color(0xFF000000),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
);

ColorScheme appDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0XFFBB86FC),
  primaryContainer: Color(0xFF3700B3),
  secondary: Color(0xFF03DAC6),
  secondaryContainer: Color(0xFF03DAC6),
  background: Color(0xFF121212),
  surface: Color(0xFF2C2C2C),
  error: Color(0xFFCF6679),
  onPrimary: Color(0xFF000000),
  onSecondary: Color(0xFF000000),
  onBackground: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
  onError: Color(0xFF000000),
);

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: appLight.background,
    colorScheme: appLight,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: appLight.onPrimary,
        fontSize: AppSize.h6["size"],
        fontWeight: AppSize.h6["weight"],
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: appLight.primary,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: appLight.onBackground,
        fontSize: AppSize.subtitle1["size"],
        fontWeight: AppSize.subtitle1["weight"],
      ),
      hintStyle: TextStyle(
        color: appLight.onBackground.withOpacity(.5),
        fontSize: AppSize.subtitle1["size"],
        fontWeight: AppSize.subtitle1["weight"],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appLight.primary,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appLight.error,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appLight.primary,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        backgroundColor: appLight.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.bBorderRadius,
          ),
        ),
        textStyle: TextStyle(
          fontSize: AppSize.subtitle1["size"],
          fontWeight: FontWeight.w600,
          color: appLight.onPrimary,
        ),
        elevation: 5,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: appLight.surface,
        foregroundColor: appLight.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.bBorderRadius,
          ),
        ),
        side: BorderSide(
          width: 2,
          color: appLight.primary,
        ),
        textStyle: TextStyle(
          fontSize: AppSize.subtitle1["size"],
          fontWeight: FontWeight.w600,
        ),
        elevation: 5,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: appDark.background,
    colorScheme: appDark,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: appDark.onSurface,
        fontSize: AppSize.h6["size"],
        fontWeight: AppSize.h6["weight"],
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: appLight.primary,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: appDark.onBackground,
        fontSize: AppSize.subtitle1["size"],
        fontWeight: AppSize.subtitle1["weight"],
      ),
      hintStyle: TextStyle(
        color: appDark.onBackground.withOpacity(.5),
        fontSize: AppSize.subtitle1["size"],
        fontWeight: AppSize.subtitle1["weight"],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appDark.primary,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appDark.error,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: appDark.primary,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.cBorderRadius,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        backgroundColor: appDark.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.bBorderRadius,
          ),
        ),
        textStyle: TextStyle(
          fontSize: AppSize.subtitle1["size"],
          fontWeight: FontWeight.w600,
          color: appDark.onPrimary,
        ),
        elevation: 5,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: appDark.surface,
        foregroundColor: appDark.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.bBorderRadius,
          ),
        ),
        side: BorderSide(
          width: 2,
          color: appDark.primary,
        ),
        textStyle: TextStyle(
          fontSize: AppSize.subtitle1["size"],
          fontWeight: FontWeight.w600,
        ),
        elevation: 5,
      ),
    ),
  );
}
