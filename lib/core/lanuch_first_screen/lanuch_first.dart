import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      if (perfs.getInt(ConstantsManager.company) != null) {
        if (perfs.getString(ConstantsManager.firstName) != null) {
          return const Home();
        } else {
          return const CompleteProfile();
        }
      } else {
        return  ChooseCompany();
      }
    } else {
      return LoginOtp();
    }
  } else {
    return const OnBoardingBase();
  }
}
