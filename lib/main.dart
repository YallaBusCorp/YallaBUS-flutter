import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/injection/di.dart' as sl;
import 'package:yalla_bus/core/injection/di.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/theme_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/pages/choose_company.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import 'package:yalla_bus/features/onBoarding/pages/onBoarding_base.dart';

import 'features/login_otp/presentation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  await Firebase.initializeApp();

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

class MyApp extends StatelessWidget {
  final SharedPreferences perfs = di<SharedPreferences>();
  late bool isSeen;
  MyApp({Key? key}) : super(key: key) {
    isSeen = perfs.getBool(ConstantsManager.seenKey) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (builder) => CompanySelectionBloc(),
          child: const ChooseCompany(),
        ),
        BlocProvider(
          create: (builder) => LoginBloc(),
          child: const LoginOtp(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.getRoute,
        localizationsDelegates: context.localizationDelegates,
        locale: context.deviceLocale,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: context.deviceLocale.hashCode == const Locale('ar').hashCode
            ? light.copyWith(textTheme: textThemeArabic)
            : light,
        darkTheme: context.deviceLocale.hashCode == const Locale('ar').hashCode
            ? dark.copyWith(textTheme: textThemeArabic)
            : dark,
        home: isSeen ? const ChooseCompany() : const OnBoardingBase(),
        // home: LoginOtp(),
      ),
    );
  }
}
