import 'package:flutter/material.dart';

class AppColor {
  static Color primary = Color(0XFF5B86E5);
  static Color onPrimary = Color(0xFFFFFFFF);
  static Color backgroundLight = Color(0xFFF5F6FB);
  static Color backgroundDark = Color(0xFF202124);
  static Color form = Color(0xFFD4D4D4);
  static Color text = Color(0xFF1A1A1A);
  static Color textLight = Color(0xFF4F5050);
  static Color buttonBG = Color(0xE1C8D3E7);
}

class AppSize {
  static const Map<String, dynamic> h3 = {
    "size": 48.0,
    "weight": FontWeight.w400,
  };

  static const Map<String, dynamic> h4 = {
    "size": 34.0,
    "weight": FontWeight.w400,
  };

  static const Map<String, dynamic> h5 = {
    "size": 24.0,
    "weight": FontWeight.w400,
  };

  static const Map<String, dynamic> h6 = {
    "size": 20.0,
    "weight": FontWeight.w500,
  };

  static const Map<String, dynamic> subtitleBody1 = {
    "size": 16.0,
    "weight": FontWeight.w400, // Normal or Regular
  };

  static const Map<String, dynamic> subtitle2Button = {
    "size": 14.0,
    "weight": FontWeight.w500, // Medium
  };

  static const Map<String, dynamic> body2 = {
    "size": 14.0,
    "weight": FontWeight.w400,
  };

  static const Map<String, dynamic> caption = {
    "size": 12.0,
    "weight": FontWeight.w400,
  };

  static const double icon = 25;

  static const double borderRadius = 10;
}

class ExpenseCategoryColors {
  static List<Color> colorList = [
    Color(0XFF777777),
    Color(0XFF477D95),
    Color(0XFF5B86E5),
    Color(0XFFBA5D07),
    Color(0XFF8D67AB),
    Color(0XFF148A08),
    Color(0XFFE61E32),
    Color(0xFF0A4937),
    Color(0XFFE8115B),
    Color(0XFF1E3264),
    Color(0XFF0D73EC),
    Color(0XFF503750),
    Color(0XFFAF2896),
    Color(0XFF8C1932),
    Color(0XFF2D46B9),
  ];
}

class IncomeCategoryColors {
  static List<Color> colorList = [
    Color(0XFF777777),
    Color(0XFFBA5D07),
    Color(0XFFE61E32),
    Color(0XFF1E3264),
    Color(0XFF148A08),
    Color(0XFF0D73EC),
    Color(0XFFAF2896),
  ];
}
