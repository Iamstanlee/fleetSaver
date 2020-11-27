import 'package:flutter/material.dart';

String pFont = 'Chococooky'; // primary font

TextStyle get textStyle {
  return TextStyle(color: AppColor.black, fontSize: 16);
}

TextStyle get textStyleDark {
  return TextStyle(color: AppColor.white, fontSize: 16);
}

class AppColor {
  static const Color primary = Color(0xFF1DA1F2);
  static final Color white = Color(0xFFffffff);
  static final Color black = Colors.black;
}

class AppTheme {
  static final ThemeData apptheme = ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: pFont,
    backgroundColor: AppColor.white,
    primaryColor: AppColor.primary,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColor.white),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      color: AppColor.white,
      iconTheme: IconThemeData(
        color: AppColor.primary,
      ),
      elevation: 0,
    ),
  );
  static final ThemeData darkApptheme = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: pFont,
      backgroundColor: AppColor.black,
      primaryColor: AppColor.primary,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColor.black),
      scaffoldBackgroundColor: Color(0xFF000000),
      appBarTheme: AppBarTheme(
        color: AppColor.black,
        iconTheme: IconThemeData(
          color: AppColor.primary,
        ),
        elevation: 0,
      ),
      cardTheme: CardTheme(color: Colors.black));
}
