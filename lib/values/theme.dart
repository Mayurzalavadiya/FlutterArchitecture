import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/values/style.dart';

import 'colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: const Color(0xfff9f9f9),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    iconTheme: const IconThemeData(color: AppColor.white, size: 30.0),
    toolbarTextStyle: TextTheme(
      titleLarge: textBold,
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: textBold,
    ).titleLarge,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor, // status bar bg color
      statusBarIconBrightness: Brightness.light, // icon/text color for Android
      statusBarBrightness: Brightness.dark, // status bar text color for iOS
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColor.textBackgroundColor,
    disabledColor: AppColor.textBackgroundColor,
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColor.brownColor),
);


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.purple,
    scaffoldBackgroundColor: AppColor.grey,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.purple,
      foregroundColor: AppColor.black,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.white),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.purple,
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.grey,
      foregroundColor: AppColor.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.lightBlue),
    ),
  );
}