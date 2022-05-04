import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_appoinments_of_am.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_map_pick_up_points.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domain/use_case/get_appoinments_of_pm.dart';
import '../../../domain/use_case/get_map_drop_off_points.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetAppoinmentOfAM appointmentOfAm;
  final GetAppoinmentOfPM appointmentOfPm;
  final GetMapDropOffPoints dropOff;
  final GetMapPickUpPoints pickUp;

  Completer<GoogleMapController> controller = Completer();
  Completer<GoogleMapController> controller2 = Completer();

  late Position _position;
  final Set<Marker> markers = <Marker>{};
  final Set<Marker> dropOffMarkers = <Marker>{};
  final Set<Marker> pickUpMarkers = <Marker>{};

  String timeOfSelectedRides = StringManager.timeOfSelectedRides;
  String from = StringManager.pickUpPoint;
  String to = StringManager.dropOffPoint;
  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);
  bool switchButtonValue = false;
  CameraPosition kGooglePlex2 = const CameraPosition(
    target: LatLng(31.056840273761154, 31.488563605540325),
    zoom: 9,
  );

  bool switchColor = false;
  SharedPreferences perfs = di<SharedPreferences>();
  List<String> amRides = [];
  List<String> pmRides = [];
  List<String> titlesOfPickUp = [];
  List<String> titlesOfDropOff = [];
  List<dynamic> pickUps = const [];

  List<dynamic> dropOffs = const [];

  @override
  void onChange(Change<MapState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  MapBloc(this.appointmentOfAm, this.appointmentOfPm, this.pickUp, this.dropOff)
      : super(MapInitial()) {
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
      emit(InitializedMarkersOfStaticMap());
    });

    on<SelectAMTripEvent>((event, emit) {
      timeOfSelectedRides = "";
      timeOfSelectedRides = event.timeOfTrip;
      emit(AMTripSelected());
    });

    on<SelectPMTripEvent>((event, emit) {
      if (timeOfSelectedRides.length > 10) {
        timeOfSelectedRides = "";
      } else {
        timeOfSelectedRides += ' - ';
      }
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

      (await pickUp.getMapPickUpPoints(
        perfs.getInt(ConstantsManager.company)!,
      ))
          .fold((failure) {
        emit(GetPickUpPointsError(failure.message));
      }, (pick) {
        titlesOfPickUp = pick.map((e) => e.mapPointTitleEn).toList();
        pickUps = pick.map((e) => LatLng(e.latitude, e.longitude)).toList();
        for (int i = 0; i < pickUps.length; i++) {
          pickUpMarkers.add(
            Marker(
              markerId: MarkerId(
                pickUps[i].toString(),
              ),
              onTap: () {
                from = titlesOfPickUp[i];
                add(AddPickUpMarkerTitleToTexts(from));
              },
              position: pickUps[i], //position of marker
              icon: markerbitmap,
            ),
          );
        }
      });
      add(CameraPositionOfPickUpPoints());
      emit(PickUpPointsMarkersChanged());
    });

    on<GetDropOffPointsEvent>((event, emit) async {
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );

      (await dropOff.getMapDropOffPoints(
        perfs.getInt(ConstantsManager.company)!,
      ))
          .fold((failure) {
        emit(GetDropOffPointsError(failure.message));
      }, (drop) {
        titlesOfDropOff = drop.map((e) => e.mapPointTitleEn).toList();
        dropOffs = drop.map((e) => LatLng(e.latitude, e.longitude)).toList();
        for (int i = 0; i < dropOffs.length; i++) {
          dropOffMarkers.add(
            Marker(
              markerId: MarkerId(
                dropOffs[i].toString(),
              ),
              onTap: () {
                to = titlesOfDropOff[i];
                add(AddDropOffMarkerTitleToTexts(to));
              },
              position: dropOffs[i], //position of marker
              icon: markerbitmap,
            ),
          );
        }
        add(CameraPositionOfDropOffPoints());
      });
      emit(DropOffPointsMarkersChanged());
    });

    on<CameraPositionOfPickUpPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = pickUps[0];
      LatLng location2 = pickUps[pickUps.length - 1];

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPositionOfPickUp = LatLng(avgOfLat, avgOfLong);
      kGooglePlex = CameraPosition(
        target: cameraPositionOfPickUp,
        zoom: 12,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForPickUpPoints());
    });

    on<CameraPositionOfDropOffPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;

      LatLng location1 = dropOffs[0];
      LatLng location2 = dropOffs[dropOffs.length - 1];

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPositionOfDropOff = LatLng(avgOfLat, avgOfLong);
      kGooglePlex = CameraPosition(
        target: cameraPositionOfDropOff,
        zoom: 13,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForPickUpPoints());
    });

    on<AddPickUpMarkerTitleToTexts>((event, emit) {
      emit(SelectPickUpFromPlace(event.title));
    });

    on<AddDropOffMarkerTitleToTexts>((event, emit) {
      emit(SelectDropOffFromPlace(event.title));
    });

    on<SaveInSharedPerfsEvent>((event, emit) {
      perfs.setBool(ConstantsManager.booked, true);
      perfs.setString(ConstantsManager.pickUp, from);
      perfs.setString(ConstantsManager.dropOff, to);
      emit(Saved());
    });

    on<CancelRideEvent>((event, emit) {
      perfs.setBool(ConstantsManager.booked, false);
      emit(CancelRide());
    });
  }
}
