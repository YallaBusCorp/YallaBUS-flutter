import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/theme_manager.dart';
import 'package:yalla_bus/features/onBoarding/pages/onBoarding_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', 'Uk'),
    ),
  );
}

class MyApp extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      locale: context.deviceLocale,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: context.deviceLocale.runtimeType == const Locale('ar').runtimeType
          ? light.copyWith(textTheme: textThemeArabic)
          : light,
      darkTheme: context.deviceLocale.runtimeType == const Locale('ar').runtimeType
          ? dark.copyWith(textTheme: textThemeArabic)
          : dark,
      home: const OnBoardingBase(),
    );
  }

}
