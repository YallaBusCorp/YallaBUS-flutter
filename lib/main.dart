import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/injection/di.dart' as sl;
import 'package:yalla_bus/core/injection/di.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/theme_manager.dart';
import 'package:yalla_bus/features/choose_company/data/repository_implementation/company_repository_implementation.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/choose_company/domain/use_case/get_companies_info.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/pages/choose_company.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Login/login_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/pages/verify.dart';
import 'package:yalla_bus/features/onBoarding/pages/onBoarding_base.dart';
import 'package:yalla_bus/features/settings/presentation/pages/settings.dart';
import 'package:yalla_bus/features/sign_up/data/data_sources/remote_data_source.dart';
import 'package:yalla_bus/features/sign_up/data/repository_implementation/company_repository_implementation.dart';
import 'package:yalla_bus/features/sign_up/domain/use_case/get_all_towns.dart';
import 'package:yalla_bus/features/sign_up/domain/use_case/get_all_universities.dart';
import 'package:yalla_bus/features/sign_up/presentation/bloc/completeprofile_bloc.dart';
import 'package:yalla_bus/features/sign_up/presentation/pages/complete_profile.dart';

import 'features/choose_company/data/data_sources/remote_data_source.dart';
import 'features/home/presentation/bloc/map_bloc.dart';
import 'features/home/presentation/pages/home.dart';
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
          create: (builder) => di<CompanySelectionBloc>(),
          child: const ChooseCompany(),
        ),
        BlocProvider(
          create: (builder) => LoginBloc(),
          child: const LoginOtp(),
        ),
        BlocProvider(
          create: (builder) => KeyboardBloc(),
          child: const LoginOtp(),
        ),
        BlocProvider(
          create: (builder) => MapBloc(),
          child: const Home(),
        ),
        BlocProvider(
          create: (builder) =>di<CompleteprofileBloc>(),
          child: const CompleteProfile(),
        ),
      ],
      child: MaterialApp(
        // showPerformanceOverlay: true,
        onGenerateRoute: RouteGenerator.getRoute,
        localizationsDelegates: context.localizationDelegates,
        locale: context.deviceLocale,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: context.deviceLocale.languageCode == 'ar'
            ? light.copyWith(textTheme: textThemeArabic)
            : light,
        darkTheme: context.deviceLocale.languageCode == 'ar'
            ? dark.copyWith(textTheme: textThemeArabic)
            : dark,
        home: isSeen ? const ChooseCompany() : const OnBoardingBase(),
        // home: const ChooseCompany(),
      ),
    );
  }
}
