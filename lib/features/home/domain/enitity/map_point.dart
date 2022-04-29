class MapPoint {
  final int id;
  final String mapPointTitleEn;
  final String mapPointTitleAr;
  final double longitude;
  final double latitude;

  MapPoint(
      {required this.id,
      required this.mapPointTitleEn,
      required this.mapPointTitleAr,
      required this.longitude,
      required this.latitude});
}


/*

 "id": 4,
        "mapPointTitle": "الصنيه",
        "mapPointType": "D",
        "longitude": 111.500024,
        "latitude": 51111.099609,

 */