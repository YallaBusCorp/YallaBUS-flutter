import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import '../injection/di.dart';
import '../resources/asset_manager.dart';
import '../../features/choose_company/presentation/bloc/company_selection_bloc.dart';

import '../resources/colors_manager.dart';
import '../resources/values_manager.dart';

extension ColorsExtensions on Color {
  static Color hexColor(String color) {
    final buffer = StringBuffer();
    if (color.length == 6 || color.length == 7) buffer.write('ff');
    buffer.write(color.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color setColorOfCompanyItem(
      CompanySelectionBloc bloc, BuildContext context, int index) {
    if (bloc.isSelected.isNotEmpty && bloc.isSelected[index]) {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return ColorsManager.black2;
      } else {
        return Colors.grey;
      }
    } else {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return ColorsManager.black;
      } else {
        return Colors.white;
      }
    }
  }

  static Color setColorOfPin(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ColorsManager.black2
        : Colors.white;
  }

  static Color setColorOfTextForm(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ColorsManager.black2
        : Colors.grey;
  }

  static Color setColorOfContainersOverMap(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ColorsManager.black
        : ColorsManager.offGrey;
  }

  static Color checkSelectedOrNot(String a, String b, BuildContext context) {
    if (a == b) return Colors.grey;
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.white
        : ColorsManager.black;
  }
}

extension TextFormStyle on InputDecoration {
  static InputDecoration applyDecoration(
      String hintText, IconData? icon, BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(top: ValuesManager.v20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.v8),
        borderSide: BorderSide(
          color: ColorsManager.orange,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.v8),
        borderSide: BorderSide.none,
      ),
      hintText: hintText,
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      hintStyle:
          Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey),
      filled: true,
      fillColor: ColorsExtensions.setColorOfTextForm(context),
    );
  }
}

extension StringsExtensions on String {
  static List<String> splitDate(Timestamp time) {
    return time.toDate().toString().split(' ');
  }

  static String removeSecondsFromDate(String time, String amOrPm) {
    return time.substring(0, 5) + ' ' + amOrPm;
  }

  static String selectAnimationLightOrDark(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return AssetManager.darkverify;
    }
    return AssetManager.lightverify;
  }

  static String generateQR(String dateOfRide) {
    SharedPreferences perfs = di<SharedPreferences>();
    return dateOfRide + '/' + perfs.getString(ConstantsManager.uid)!;
  }
}
