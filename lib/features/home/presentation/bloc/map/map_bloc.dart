import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/lanuch_first_screen/lanuch_first.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_appoinments_of_am.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domain/use_case/get_appoinments_of_pm.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetAppoinmentOfAM appointmentOfAm;
  final GetAppoinmentOfPM appointmentOfPm;

  Completer<GoogleMapController> controller = Completer();
  Completer<GoogleMapController> controller2 = Completer();

  late Position _position;
  final Set<Marker> markers = <Marker>{};
  final Set<Marker> markers2 = <Marker>{};
  final Set<Marker> dropOffMarkers = <Marker>{};
  final Set<Marker> pickUpMarkers = <Marker>{};

  String timeOfSelectedRides = 'Choose Ride';

  
  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(31.046399336407333, 31.349177483660732), zoom:12);
  bool switchButtonValue = false;
  CameraPosition kGooglePlex2 = const CameraPosition(
    target: LatLng(31.056840273761154, 31.488563605540325),
    zoom: 9,
  );

  bool switchColor = false;
  SharedPreferences perfs = di<SharedPreferences>();
  List<String> amRides = [];
  List<String> pmRides = [];

  List<dynamic> pickUps = const [
    LatLng(30.85389579312156, 31.268433318547288),
    LatLng(30.750389209369917, 31.260458997797773),
    LatLng(30.95670425388353, 31.30646424602145),
  ];

  List<dynamic> dropOff = const [
    LatLng(31.016335114429555, 31.378602195301422),
    LatLng(31.044890281535398, 31.352871305627136),
    LatLng(31.07003276429378, 31.38887818181026),
  ];

  @override
  void onChange(Change<MapState> change) {
    super.onChange(change);
    print(change);
  }

  MapBloc(this.appointmentOfAm, this.appointmentOfPm) : super(MapInitial()) {
    on<GetMyLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      _position = await determinePosition();
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.placeMarker,
      );

      markers.add(
        Marker(
          markerId: MarkerId(
            LatLng(_position.latitude, _position.longitude).toString(),
          ),
          position: LatLng(
              _position.latitude, _position.longitude), //position of marker

          icon: markerbitmap,
        ),
      );
      final CameraPosition _kLake = CameraPosition(
          bearing: 0,
          target: LatLng(_position.latitude, _position.longitude),
          tilt: 0,
          zoom: 19.151926040649414);
      con.animateCamera(CameraUpdate.newCameraPosition(_kLake));
      emit(ChangePosition());
    });

    on<ShowRidesAtPMEvent>((event, emit) {
      switchButtonValue = !switchButtonValue;
      emit(ChangeSwitchButtonColor());
    });

    on<InitializeStaticMapEvent>((event, emit) async {
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );
      markers2.add(
        Marker(
          markerId: MarkerId(
            const LatLng(31.016408673053103, 31.378623652973157).toString(),
          ),
          position: const LatLng(
              31.016408673053103, 31.378623652973157), //position of marker

          icon: markerbitmap,
        ),
      );
      markers2.add(
        Marker(
          markerId: MarkerId(
            const LatLng(30.73786543468305, 30.73786543468305).toString(),
          ),
          position: const LatLng(
              30.73786543468305, 30.73786543468305), //position of marker

          icon: markerbitmap,
        ),
      );
      emit(InitializedMarkersOfStaticMap());
    });

    on<SelectAMTripEvent>((event, emit) {
      timeOfSelectedRides = event.timeOfTrip;
      emit(AMTripSelected());
    });

    on<SelectPMTripEvent>((event, emit) {
      timeOfSelectedRides += ' - ';
      timeOfSelectedRides += event.timeOfTrip;
      emit(PMTripSelected());
    });

    on<GetAmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfAm
              .getAppoinmentsAM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentAmError(failure.message));
      }, (appointments) {
        amRides = appointments
            .map((e) =>
                '${e.appointmentStartTime.substring(0, 5)} ${e.appointmentType}')
            .toList();
        amRides.sort();
        emit(GetAppoinmentAmSuccess(amRides));
      });
    });

    on<GetPmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfPm
              .getAppoinmentsPM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentPmError(failure.message));
      }, (appointments) {
        pmRides = appointments
            .map((e) =>
                '${e.appointmentStartTime.substring(0, 5)} ${e.appointmentType}')
            .toList();
        pmRides.sort();
        emit(GetAppoinmentPmSuccess(pmRides));
      });
    });

    on<GetPickUpPointsEvent>((event, emit) async {
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );
      pickUpMarkers.add(
        Marker(
            markerId: MarkerId(
              pickUps[0].toString(),
            ),
            position: pickUps[0], //position of marker

            icon: markerbitmap,
            onTap: () {}),
      );

      pickUpMarkers.add(
        Marker(
            markerId: MarkerId(
              pickUps[1].toString(),
            ),
            position: pickUps[1], //position of marker

            icon: markerbitmap,
            onTap: () {}),
      );

      pickUpMarkers.add(
        Marker(
          markerId: MarkerId(
            pickUps[2].toString(),
          ),
          position: pickUps[2], //position of marker

          icon: markerbitmap,
          onTap: () {},
        ),
      );
      emit(PickUpPointsMarkersChanged());
    });

    on<GetDropOffPointsEvent>((event, emit) async {
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );
      dropOffMarkers.add(
        Marker(
            markerId: MarkerId(
              dropOff[0].toString(),
            ),
            position: dropOff[0], //position of marker

            icon: markerbitmap,
            onTap: () {}),
      );

      dropOffMarkers.add(
        Marker(
            markerId: MarkerId(
              dropOff[1].toString(),
            ),
            position: dropOff[1], //position of marker

            icon: markerbitmap,
            onTap: () {}),
      );

      dropOffMarkers.add(
        Marker(
          markerId: MarkerId(
            dropOff[2].toString(),
          ),
          position: dropOff[2], //position of marker

          icon: markerbitmap,
          onTap: () {},
        ),
      );
      emit(DropOffPointsMarkersChanged());
    });

    on<CameraPositionOfPickUpPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;
      double avgOfLat =
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3;
      double avgOfLong =
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3;
      dynamic cameraPositionOfPickUp = LatLng(avgOfLat, avgOfLong);
      kGooglePlex = CameraPosition(
        target: cameraPositionOfPickUp,
        zoom: 11,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForPickUpPoints());
    });

    on<CameraPositionOfDropOffPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;
      
      double avgOfLat =
          (31.016335114429555 + 31.044890281535398 + 31.07006630857465) / 3;
      double avgOfLong =
          (31.378602195301422 + 31.352871305627136 + 31.38895182554876) / 3;
      dynamic cameraPositionOfDropOff = LatLng(avgOfLat, avgOfLong);
      kGooglePlex = CameraPosition(
        target: cameraPositionOfDropOff,
        zoom: 11,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForPickUpPoints());
    });
  }
}
