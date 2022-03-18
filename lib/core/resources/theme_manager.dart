import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

/* 
Orange Color: 	#EB671A
Blue Color:	#48B2FF
Green Color:	#59BD8F
Dark Color:	#111111

*/

final TextTheme textThemeEnglish = TextTheme(
  headline1: GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  ),
  headline2: GoogleFonts.nunito(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  headline3: GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headline4: GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  headline5: GoogleFonts.nunito(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  headline6: GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
);

//Not Completed
final TextTheme textThemeArabic = TextTheme(
  headline1: GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  ),
  headline2: GoogleFonts.nunito(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  headline3: GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headline4: GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  headline5: GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  headline6: GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  ),
);

final ThemeData light = ThemeData(
  primaryColor: HexToColor.hexColor("#EB671A"),
  textTheme: textThemeEnglish,
  scaffoldBackgroundColor: Colors.white,
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
  primaryColor: HexToColor.hexColor("#EB671A"),
  textTheme: textThemeEnglish,
  scaffoldBackgroundColor: HexToColor.hexColor("#111111"),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: HexToColor.hexColor("#111111"),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexToColor.hexColor("#111111"),
    ),
  ),
);
