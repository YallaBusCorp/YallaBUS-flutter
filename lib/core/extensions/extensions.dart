import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import '../injection/di.dart';
import '../resources/asset_manager.dart';
import 'package:latlong2/latlong.dart' as d;
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

  static Future<String> generateQR(String dateOfRide) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String code = dateOfRide.replaceFirst(RegExp(r' '), '') +
        '/' +
        perfs.getString(ConstantsManager.uid)!;
    perfs.setString(ConstantsManager.qrCode, code);
    return code;
  }

  static String convertHourTo12HoursOnly(String d) {
    String date = d.substring(0, 5);
    int hours = int.parse(date[0]) * 10 + int.parse(date[1]);
    if (hours > 12) {
      String p = d.substring(2, 6);
      hours -= 12;
      date = "0" + hours.toString();
      date += p;
    }
    return date;
  }
}

extension RouteDistanceExtensions on double {
  static double calculateDistanceFromPickToDrop(
      gmaps.LatLng a, gmaps.LatLng b) {
    return const d.Distance().as(
        d.LengthUnit.Kilometer,
        d.LatLng(a.latitude.toDouble(), a.longitude.toDouble()),
        d.LatLng(b.latitude.toDouble(), b.longitude.toDouble()));
  }

  static double reduceDistance(
      gmaps.LatLng bus, gmaps.LatLng pick, gmaps.LatLng drop, double distance) {
    double dis1 = const d.Distance().as(
        d.LengthUnit.Kilometer,
        d.LatLng(bus.latitude.toDouble(), bus.longitude.toDouble()),
        d.LatLng(drop.latitude.toDouble(), drop.longitude.toDouble()));
    double dis2 = const d.Distance().as(
        d.LengthUnit.Kilometer,
        d.LatLng(bus.latitude.toDouble(), bus.longitude.toDouble()),
        d.LatLng(pick.latitude.toDouble(), pick.longitude.toDouble()));

    if (dis1 <= distance) {
      distance -= dis2;
    }
    return distance;
  }
}

extension MapExtensions on bool {
  static Future<bool> CheckIfDocumentExistsOrNotEvent(String docId) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('company')
        .doc('serkes')
        .collection('ride');
    final document = await collectionRef.doc(docId).get();
    return document.exists;
  }
}
/*
   await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': 'this is a body',
         'title': 'this is a title'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done'
       },
       'to': await firebaseMessaging.getToken(),
     },
    ),



 */