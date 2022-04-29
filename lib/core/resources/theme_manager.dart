import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/fonts_family.dart';

const TextTheme textThemeEnglish = TextTheme(
  headline6: TextStyle(
    fontFamily: FontFamily.nunitoSemiBold,
  ),
  headline5: TextStyle(
    fontFamily: FontFamily.nunitoBold,
  ),
  headline4: TextStyle(
    fontFamily: FontFamily.nunitoLight,
  ),
  caption: TextStyle(
    fontFamily: FontFamily.nunitoRegular,
  ),
  
);

//Not Completed
const TextTheme textThemeArabic = TextTheme(
  headline6: TextStyle(
    fontFamily: FontFamily.balooRegular,
  ),
  headline5: TextStyle(
    fontFamily: FontFamily.balooSemiBold,
  ),
  headline4: TextStyle(
    fontFamily: FontFamily.balooBold,
  ),
);

final ThemeData light = ThemeData(
  colorScheme: const ColorScheme.light(),
  primaryColor: Colors.white,
  textTheme: textThemeEnglish,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
    size: 30,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(
      color: ColorsManager.orange,
    ),
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
  ),
);

final ThemeData dark = ThemeData(
  colorScheme: const ColorScheme.dark(),
  primaryColor: ColorsManager.black,
  textTheme: textThemeEnglish,
  backgroundColor: ColorsManager.black2,
  scaffoldBackgroundColor: ColorsManager.black,
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 30,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(
      color: ColorsManager.orange,
    ),
    color: ColorsManager.black,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: ColorsManager.black,
    ),
  ),
);
