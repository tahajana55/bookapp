import 'package:flutter/material.dart';


class AppColors {
  static const Color primary = Color(0xffE79AB6);
  static const Color background = Color(0xffFFF8FB);
  static const Color text = Color(0xff4B4453);
}

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.background,
);