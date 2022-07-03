import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/pages/verify.dart';
import 'package:yalla_bus/features/bus_mobile/rides/presentation/pages/bus_rides.dart';
import '../../features/choose_company/presentation/pages/choose_company.dart';
import '../../features/login_otp/presentation/pages/login.dart';
import '../../features/onBoarding/pages/onboarding_base.dart';
import '../../features/sign_up/presentation/pages/complete_profile.dart';

import '../../features/home/presentation/pages/home.dart';
import '../injection/di.dart';
import '../resources/constants_manager.dart';

SharedPreferences perfs = di<SharedPreferences>();
Widget launchFirst() {
  if (perfs.getBool(ConstantsManager.seenKey) != null) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (perfs.getString(ConstantsManager.student) == 'Exists' ||
          (perfs.getInt(ConstantsManager.company) != null &&
              perfs.getString(ConstantsManager.companyName) != null)) {
        return const Home();
      } else if (perfs.getString(ConstantsManager.student) == 'New') {
        if (perfs.getInt(ConstantsManager.company) != null) {
          return const CompleteProfile();
        } else {
          return const ChooseCompany(edit: ConstantsManager.register);
        }
      } else {
        if (perfs.getString(ConstantsManager.employeeCode) == null) {
          return const EmployeeCodeScreen();
        } else {
          return const BusRides();
        }
      }
    } else {
      return LoginOtp(
        editOrRegister: ConstantsManager.register,
      );
    }
  } else {
    return const OnBoardingBase();
  }
}
