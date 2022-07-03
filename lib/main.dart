// ignore_for_file: must_be_immutable
import 'dart:async';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/injection/di.dart' as sl;
import 'package:yalla_bus/core/injection/di.dart';
import 'package:yalla_bus/core/lanuch_first_screen/lanuch_first.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/debugger_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/theme_manager.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/bloc/employee_code_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/pages/verify.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/pages/bus_map.dart';
import 'package:yalla_bus/features/bus_mobile/qr_scanner/presentation/bloc/qr_scanner_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/qr_scanner/presentation/pages/qr_scanner.dart';
import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';
import 'package:yalla_bus/features/bus_mobile/rides/presentation/pages/bus_rides.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/pages/choose_company.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Login/login_bloc.dart';
import 'package:yalla_bus/features/onBoarding/pages/onboarding_base.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/goodbye.dart';
import 'package:yalla_bus/features/sign_up/presentation/bloc/completeprofile_bloc.dart';
import 'package:yalla_bus/features/sign_up/presentation/pages/complete_profile.dart';
import 'features/bus_mobile/rides/presentation/bloc/bus_ride_bloc.dart';
import 'features/home/domain/enitity/map_point.dart';
import 'features/home/presentation/bloc/map/map_bloc.dart';
import 'features/home/presentation/pages/home.dart';
import 'features/home/presentation/widgets/map.dart';
import 'features/login_otp/presentation/pages/login.dart';
import 'features/settings/presentation/pages/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundNotification);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: 'basic_channel',
          title: 'Your ride has just been started!',
          body: 'Tab here to track your bus'),
    );
  });
  await Future.wait([
    precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderOutsideViewBoxBuilder, // See UPDATE below!
        AssetManager.error404,
      ),
      null,
    ),
  ]);
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          importance: NotificationImportance.Max,
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
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

Future<void> backgroundNotification(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: Random().nextInt(1000),
        channelKey: 'basic_channel',
        title: 'Your ride has just been started!',
        body: 'Tab here to track your bus'),
  );
}

class MyApp extends StatefulWidget {
  late bool isSeen;

  MyApp({Key? key}) : super(key: key) {
    isSeen = perfs.getBool(ConstantsManager.seenKey) ?? false;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferences perfs = di<SharedPreferences>();

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (builder) => di<CompanySelectionBloc>(),
          child: const ChooseCompany(
            edit: ConstantsManager.register,
          ),
        ),
        BlocProvider(
          create: (builder) => di<LoginBloc>(),
          child: LoginOtp(
            editOrRegister: ConstantsManager.register,
          ),
        ),
        BlocProvider(
          create: (builder) => KeyboardBloc(),
          child: LoginOtp(
            editOrRegister: ConstantsManager.register,
          ),
        ),
        BlocProvider(
          create: (builder) => KeyboardBloc(),
          child: const EmployeeCodeScreen(),
        ),
        BlocProvider(
          create: (builder) => di<MapBloc>(),
          child: const Home(),
        ),
        BlocProvider(
          create: (builder) => di<CompleteprofileBloc>(),
          child: const CompleteProfile(),
        ),
        BlocProvider(
          create: (builder) => di<SettingsBloc>(),
          child: const GoodBye(),
        ),
        BlocProvider(
          create: (builder) => di<SettingsBloc>(),
          child: const SettingsScreen(),
        ),
        BlocProvider(
          create: (builder) => di<EmployeeCodeBloc>(),
          child: const EmployeeCodeScreen(),
        ),
        BlocProvider(
          create: (builder) => di<QrScannerBloc>(),
          child: const BusQRScanner(),
        ),
        BlocProvider(
          create: (builder) => di<BusRideBloc>(),
          child: const BusRides(),
        ),
        BlocProvider(
          create: (builder) => di<BusMapBloc>(),
          child: const BusMap(
            bookings: [],
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: DebuggerManager.alice.getNavigatorKey(),
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
        // home: BusMap(
        //   bookings: [
        //     Booking(
        //       Appoinment(
        //           id: 4,
        //           appointmentStartTime: "18:00:00",
        //           appointmentType: "PM"),
        //       MapPoint(
        //           id: 18,
        //           mapPointTitleEn: 'Fisha Bana',
        //           mapPointTitleAr: 'فيشا بنا',
        //           longitude: 31.260197,
        //           latitude: 30.809932),
        //       MapPoint(
        //           id: 27,
        //           mapPointTitleEn: 'Elslap',
        //           mapPointTitleAr: 'معهد السلا',
        //           longitude: 31.377755,
        //           latitude: 31.015205),
        //       TxRide(158, 'process'),
        //     ),
        //     Booking(
        //       Appoinment(
        //           id: 4,
        //           appointmentStartTime: "18:00:00",
        //           appointmentType: "PM"),
        //       MapPoint(
        //           id: 18,
        //           mapPointTitleEn: 'Fisha Bana',
        //           mapPointTitleAr: 'فيشا بنا',
        //           longitude: 31.2655,
        //           latitude: 30.839355),
        //       MapPoint(
        //           id: 27,
        //           mapPointTitleEn: 'Elslap',
        //           mapPointTitleAr: 'معهد السلا',
        //           longitude: 31.354753,
        //           latitude: 31.038515),
        //       TxRide(158, 'process'),
        //     ),
        //   ],
        // ),
        home: launchFirst(),
      ),
    );
  }
}
