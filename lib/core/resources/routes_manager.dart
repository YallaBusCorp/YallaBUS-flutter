import 'package:flutter/material.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/pages/verify.dart';
import 'package:yalla_bus/features/bus_mobile/qr_scanner/presentation/pages/qr_scanner.dart';
import 'package:yalla_bus/features/bus_mobile/rides/presentation/pages/bus_rides.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/faqs/fags.dart';
import '../../features/login_otp/presentation/pages/verify.dart';
import '../../features/payment/presentation/pages/add_payment.dart';
import '../../features/payment/presentation/pages/success_payment.dart';
import '../../features/settings/presentation/pages/settings.dart';
import '../../features/settings/presentation/widgets/complaints/complaint_response.dart';
import '../../features/settings/presentation/widgets/complaints/complaints.dart';
import '../../features/settings/presentation/widgets/complaints/file_complaint.dart';
import '../../features/settings/presentation/widgets/edit_profile/edit_profile.dart';
import '../../features/settings/presentation/widgets/goodbye.dart';
import '../../features/settings/presentation/widgets/ride_history/ride_history.dart';
import '../../features/settings/presentation/widgets/subscription_details/subscription_details.dart';

import '../../features/choose_company/presentation/pages/choose_company.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../features/login_otp/presentation/pages/login.dart';
import '../../features/sign_up/presentation/pages/complete_profile.dart';

class Routes {
  static const String home = '/home';
  static const String chooseCompany = '/chooseCompany';
  static const String loginOtp = '/login';
  static const String verifyOtp = '/verifyOtp';
  static const String completeProfile = '/completeProfile';
  static const String addPayment = '/addPayment';
  static const String successfulPayment = '/successfulPayment';
  static const String settings = '/settings';
  static const String goodBye = '/goodBye';
  static const String complaints = '/complaints';
  static const String rideHistory = '/rideHistory';
  static const String fileComplaint = '/fileComplaint';
  static const String subscriptionDetails = '/subscriptionDetails';
  static const String editProfile = '/editProfile';
  static const String faqs = '/faqs';
  static const String complaintMessageAndResponse =
      'complaintMessageAndResponse';
  static const String busRides = 'BusRides';
  static const String busSettings = 'BusSettings';
  static const String busMap = 'BusMap';
  static const String busQrScanner = 'BusQr';
  static const String busEmployeeCode = 'busEmployeeCode';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.chooseCompany:
        var args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ChooseCompany(
                  edit: args,
                ));
      case Routes.loginOtp:
        var args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => LoginOtp(
                  editOrRegister: args,
                ));
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.completeProfile:
        return MaterialPageRoute(builder: (_) => const CompleteProfile());
      case Routes.addPayment:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.successfulPayment:
        return MaterialPageRoute(builder: (_) => const SuccessPayment());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.complaints:
        return MaterialPageRoute(builder: (_) => const Complaints());
      case Routes.rideHistory:
        return MaterialPageRoute(builder: (_) => const RidesHistory());
      case Routes.goodBye:
        return MaterialPageRoute(builder: (_) => const GoodBye());
      case Routes.fileComplaint:
        return MaterialPageRoute(builder: (_) => const FileComplaint());
      case Routes.subscriptionDetails:
        return MaterialPageRoute(builder: (_) => const SubscriptionDetails());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case Routes.faqs:
        return MaterialPageRoute(builder: (_) => FAQs());
      case Routes.busRides:
        return MaterialPageRoute(builder: (_) => const BusRides());
      case Routes.busQrScanner:
        return MaterialPageRoute(builder: (_) => const BusQRScanner());
      case Routes.busEmployeeCode:
        return MaterialPageRoute(builder: (_) => const EmployeeCodeScreen());

      case Routes.complaintMessageAndResponse:
        var args = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ComplaintResponse(
                  index: args,
                ));
      case Routes.verifyOtp:
        ScreenArguments argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => VerifyScreen(
            number: argument.number,
            mode: argument.mode,
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

class ScreenArguments {
  final String number;
  final String mode;

  ScreenArguments(this.number, this.mode);
}
