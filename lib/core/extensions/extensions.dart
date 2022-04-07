import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

import '../resources/colors_manager.dart';
import '../resources/values_manager.dart';

extension ColorsExtensions on Color {
  static Color hexColor(String color) {
    final buffer = StringBuffer();
    if (color.length == 6 || color.length == 7) buffer.write('ff');
    buffer.write(color.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color isDarkOrNot(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}

List<BoxShadow> selectShadow(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light
      ? [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: ValuesManager.v5,
          ),
        ]
      : [
          const BoxShadow(blurRadius: ValuesManager.v0),
        ];
}

Color setColorOfCompanyItem(
    CompanySelectionBloc bloc, BuildContext context, int index) {
  if (bloc.isSelected[index]) {
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

Color setColorOfPin(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark
      ? ColorsManager.black2
      : Colors.white;
}

Color setColorOfTextForm(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark
      ? ColorsManager.black2
      : Colors.grey;
}


