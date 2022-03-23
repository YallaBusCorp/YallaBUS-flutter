import 'package:flutter/material.dart';
import 'package:yalla_bus/features/login_otp/presentation/pages/verify.dart';

import '../../features/choose_company/presentation/pages/choose_company.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../features/login_otp/presentation/pages/login.dart';

class Routes {
  static const String home = '/home';
  static const String chooseCompany = '/chooseCompany';
  static const String loginOtp = '/login';
  static const String verifyOtp = '/verifyOtp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.chooseCompany:
        return MaterialPageRoute(builder: (_) => const ChooseCompany());
      case Routes.loginOtp:
        return MaterialPageRoute(builder: (_) => const LoginOtp());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.verifyOtp:
        var args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerifyScreen(
            number: args,
          ),
        );
      default:
        return unDefainedRoute();
    }
  }

  static Route<dynamic> unDefainedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Not Found!'),
              ),
              body: const Center(child: Text('Not Found!')),
            ));
  }
}
