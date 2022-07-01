import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

class MapManager {
  static Completer<GoogleMapController> controller = Completer();

  static Location location = Location();
  static late LocationData myLocation;

  static final Set<Marker> markers = <Marker>{};
  static final Set<Marker> dropOffMarkers = <Marker>{};
  static final Set<Marker> pickUpMarkers = <Marker>{};
  static List<LatLng> list = const [
    LatLng(30.742434094705523, 31.261414753496542),
    LatLng(30.742973165247875, 31.26148180872014),
    LatLng(30.743208303087613, 31.26156763940634),
    LatLng(30.74375234531529, 31.261736618575274),
    LatLng(30.744250279573716, 31.261892186695654),
    LatLng(30.744709022281885, 31.262037025979264),
    LatLng(30.745370622241744, 31.262098716786817),
    LatLng(30.745852411686016, 31.26207457690511),
    LatLng(30.74635033509026, 31.262034343766977),
    LatLng(30.747000397879724, 31.261983381795908),
    LatLng(30.747618183978922, 31.261900233317224),
    LatLng(30.74778185052999, 31.261878775646522),
    LatLng(30.748058469419263, 31.261825131467216),
    LatLng(30.748268238214607, 31.261811720422067),
    LatLng(30.748643976780073, 31.261782216122196),
    LatLng(30.74886757510967, 31.26179830937387),
    LatLng(30.74914188575072, 31.26176075844766),
    LatLng(30.749328600949735, 31.261747347402657),
    LatLng(30.749552197690356, 31.261717843101998),
    LatLng(30.74989104949169, 31.261707114266652),
    LatLng(30.750409697899197, 31.261634694625165),
    LatLng(30.75082461461084, 31.261581050444583),
    LatLng(30.751238863460706, 31.261567631662288),
    LatLng(30.751639192151952, 31.26151952996668),
    LatLng(30.751993829764544, 31.261438516583944),
    LatLng(30.75226143887113, 31.261413199902357),
    LatLng(30.752792617807444, 31.261439569921993),
    LatLng(30.753256034155463, 31.261381341551743),
    LatLng(30.754154576851285, 31.261300328167938),
    LatLng(30.755013950039107, 31.26123450479455),
    LatLng(30.755527903927756, 31.261175690012426),
    LatLng(30.756321997209923, 31.26108708162368),
    LatLng(30.75715306864811, 31.260970624886447),
    LatLng(30.758336571604612, 31.26080353478579),
    LatLng(30.75916327460504, 31.260785813103524),
    LatLng(30.75969192569639, 31.26068201470415),
    LatLng(30.760377209823236, 31.260588342980355),
    LatLng(30.76092760909866, 31.26054783628775),
    LatLng(30.76150628636592, 31.260476949576834),
    LatLng(30.76203057366818, 31.26043137954657),
    LatLng(30.762587489831343, 31.26037568284749),
    LatLng(30.76310306950382, 31.260317454479715),
    LatLng(30.76395148573718, 31.260188339401697),
    LatLng(30.764812946870812, 31.26015795938259),
    LatLng(30.765517772975528, 31.260069350990552),
    LatLng(30.7663661679267, 31.25994276758458),
    LatLng(30.76699448973356, 31.259863611540858),
    LatLng(30.768086532515294, 31.259670781423267),
    LatLng(30.769848837540305, 31.25946042130009),
    LatLng(30.771603579268543, 31.259407831269872),
    LatLng(30.773082648801115, 31.259120045178687),
    LatLng(30.77350157357217, 31.25902302175569),
    LatLng(30.773554443614124, 31.25904397017139),
    LatLng(30.773627036710153, 31.25903458244045),
    LatLng(30.773781440893842, 31.259017148081682),
    LatLng(30.773988849108346, 31.258954116170614),
    LatLng(30.77429419927875, 31.25891254193272),
    LatLng(30.774469343086363, 31.258889743157585),
    LatLng(30.774742428526938, 31.258861579964066),
    LatLng(30.775054689829492, 31.258861579968354),
    LatLng(30.77525057278644, 31.258846827819465),
    LatLng(30.77545336883837, 31.258850851132905),
    LatLng(30.775731060465713, 31.258874991013776),
    LatLng(30.77587624331846, 31.258846827820953),
    LatLng(30.775947682423244, 31.258782454804162),
    LatLng(30.776084799263092, 31.258739539457654),
    LatLng(30.77633944430173, 31.258715399578183),
    LatLng(30.77650882320753, 31.25873015172619),
    LatLng(30.77665285265525, 31.258746244979225),
    LatLng(30.776821078776862, 31.258754291605754),
    LatLng(30.776990456835744, 31.25877843148907),
    LatLng(30.777417933456704, 31.25879586584653),
    LatLng(30.777537764843558, 31.258817323517253),
    LatLng(30.777734794965763, 31.258817323517682),
    LatLng(30.777903019196096, 31.258828052353742),
    LatLng(30.778639284788397, 31.258862921072335),
    LatLng(30.778961903305373, 31.258876332117932),
    LatLng(30.779248802437174, 31.258899130895962),
    LatLng(30.77961865909272, 31.25890047199977),
    LatLng(30.78007262450298, 31.258905836416833),
    LatLng(30.780396390403503, 31.25893265850419),
    LatLng(30.780752416413375, 31.258929976298322),
    LatLng(30.781096919293812, 31.25894606955626),
    LatLng(30.781433355699992, 31.25896752722856),
    LatLng(30.7819057472963, 31.25894741065631),
    LatLng(30.782173050780877, 31.25895411618024),
    LatLng(30.782529070217404, 31.259002395943824),
    LatLng(30.782827480316964, 31.259009101465395),
    LatLng(30.782999152112797, 31.25901044256982),
    LatLng(30.78320423614628, 31.25902117140422),
    LatLng(30.78367085829161, 31.259025194720806),
    LatLng(30.78390128814571, 31.259034582449992),
    LatLng(30.784230801877303, 31.259034582448944),
    LatLng(30.78457759657926, 31.25902117140658),
    LatLng(30.784897890906134, 31.259025194722895),
    LatLng(30.785185924463523, 31.259037264661018),
    LatLng(30.78543478476322, 31.25906542785289),
    LatLng(30.785718208206855, 31.25905604012159),
    LatLng(30.785873295751117, 31.259087525644023),
    LatLng(30.786140588210607, 31.259096913374528),
    LatLng(30.78648046332325, 31.259102277794565),
    LatLng(30.78693439634587, 31.259107642209973),
    LatLng(30.7872650517952, 31.259113006632028),
    LatLng(30.787549621950443, 31.259145193136796),
    LatLng(30.787857233274114, 31.259139828717714),
    LatLng(30.788138345385192, 31.259158604175752),
    LatLng(30.788435585984317, 31.259153239755967),
    LatLng(30.788746650744564, 31.259172015216357),
    LatLng(30.789058866583506, 31.259192131780736),
    LatLng(30.789272759026133, 31.259205131419996),
    LatLng(30.789566539880106, 31.259203790315926),
    LatLng(30.78994902968602, 31.25921049583584),
    LatLng(30.79033036589821, 31.259201108106303),
    LatLng(30.790629903856708, 31.25923731792661),
    LatLng(30.79093174500894, 31.259230612402668),
    LatLng(30.791237041397817, 31.259238659027698),
    LatLng(30.791185765997945, 31.259223008915317),
    LatLng(30.791413862087726, 31.259268527508738),
    LatLng(30.791607743338588, 31.259283700373214),
  ];

  static CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);

  static CameraPosition kGooglePlex2 = const CameraPosition(
    target: LatLng(31.056840273761154, 31.488563605540325),
    zoom: 9,
  );

  static final CameraPosition cameraPosition = CameraPosition(
      bearing: 0,
      target: LatLng(myLocation.latitude!, myLocation.longitude!),
      tilt: 0,
      zoom: 19.151926040649414);

  static Future<BitmapDescriptor> positionIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetManager.placeMarker,
    );
  }

    static Future<BitmapDescriptor> stationIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetManager.busStationMarker,
    );
  }

  static void addMarker(
      {required int id,
      required Set<Marker> marker,
      required LatLng latlng,
      required BitmapDescriptor icon,
      GestureTapCallback? onTap,
      double? rotation,
      Offset? anchor}) {
    marker.add(
      Marker(
        markerId: MarkerId(
          id.toString(),
        ),
        position: latlng, //position of marker
        onTap: onTap,
        icon: icon,

        anchor: const Offset(0.5, 0.5),
      ),
    );
  }

  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        45 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 45 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  static Future<BitmapDescriptor> bitmapDisForBus(
      BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        64 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 64 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  static void removeMarker({required Marker m, required Set<Marker> marker}) {
    marker.remove(m);
  }

  static double bearingBetweenLocations(LatLng latLng1, LatLng latLng2) {
    double PI = 3.14159;
    double lat1 = latLng1.latitude * PI / 180;
    double long1 = latLng1.longitude * PI / 180;
    double lat2 = latLng2.latitude * PI / 180;
    double long2 = latLng2.longitude * PI / 180;

    double dLon = (long2 - long1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double brng = atan2(y, x);

    brng = brng * 180 / PI;
    brng = (brng + 360) % 360;

    return brng;
  }
}
