import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

List<BoxShadow> selectShadow(BuildContext context){
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

