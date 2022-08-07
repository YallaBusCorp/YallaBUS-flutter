import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickUpAndDropOffInfo {
  static List<int> pickUpIDs = [];
  static List<int> dropOffIDs = [];
  static LatLng pickUpSelectedPosition =
      const LatLng(30.965317563392837, 31.316227249605518);
  static LatLng dropOffSelectedPosition =
      const LatLng(31.020093991171894, 31.370074396647205);
  static late int pickUpID;
  static late int dropOffID;

  static List<String> titlesOfPickUp = [];
  static List<String> titlesOfDropOff = [];
  static List<dynamic> pickUps = const [];
  static List<dynamic> dropOffs = const [];
}
