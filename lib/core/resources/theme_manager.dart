import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/constants.dart';

final TextTheme textThemeEnglish = TextTheme(
  headline1: GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,
  ),
  headline2: GoogleFonts.nunito(
    fontSize: 26,
    fontWeight: FontWeight.w600,
  ),
  headline3: GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w300,
  ),
  headline5: GoogleFonts.nunito(
    fontSize: 21,
    fontWeight: FontWeight.bold,
  ),
  headline6: GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w300,
  ),
);

//Not Completed
final TextTheme textThemeArabic = TextTheme(
  headline1: GoogleFonts.balooBhaijaan2(
    fontSize: 28,
    fontWeight: FontWeight.w800,
  ),
  headline2: GoogleFonts.balooBhaijaan2(
    fontSize: 26,
    fontWeight: FontWeight.w600,
  ),
  headline3: GoogleFonts.balooBhaijaan2(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.balooBhaijaan2(
    fontSize: 22,
    fontWeight: FontWeight.w300,
  ),
  headline5: GoogleFonts.balooBhaijaan2(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headline6: GoogleFonts.balooBhaijaan2(
    fontSize: 18,
    fontWeight: FontWeight.w200,
  ),
);

final ThemeData light = ThemeData(
  colorScheme: const ColorScheme.light(),
  primaryColor: Colors.white,
  textTheme: textThemeArabic,
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: ButtonThemeData(
    buttonColor: ColorsManager.orange,
  ),
  appBarTheme: const AppBarTheme(
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
  buttonTheme: ButtonThemeData(
    buttonColor: ColorsManager.orange,
  ),
  primaryColor: ColorsManager.black,
  textTheme: textThemeEnglish,
  scaffoldBackgroundColor: ColorsManager.black,
  appBarTheme: AppBarTheme(
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
