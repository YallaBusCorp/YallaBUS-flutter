import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';

final TextTheme textThemeEnglish = TextTheme(
  bodyText2: GoogleFonts.nunito(
    fontSize: 40,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: GoogleFonts.nunito(
    fontSize: 26,
    fontWeight: FontWeight.w600,
  ),
  subtitle1: GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  subtitle2: GoogleFonts.nunito(
    fontSize: 21,
    fontWeight: FontWeight.w500,
  ),
  caption: GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  headline6: GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);

//Not Completed
final TextTheme textThemeArabic = TextTheme(
  headline1: GoogleFonts.balooBhaijaan2(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  ),
  headline2: GoogleFonts.balooBhaijaan2(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  ),
  headline3: GoogleFonts.balooBhaijaan2(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
  headline6: GoogleFonts.balooBhaijaan2(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.balooBhaijaan2(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);

final ThemeData light = ThemeData(
  colorScheme: const ColorScheme.light(),
  primaryColor: Colors.white,
  textTheme: textThemeEnglish,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
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
  scaffoldBackgroundColor: ColorsManager.black,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
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
