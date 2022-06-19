import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../domain/enitity/ride.dart';
import '../../../domain/use_case/book_ride.dart';
import '../../../domain/use_case/get_appoinments_of_am.dart';
import '../../../domain/use_case/get_map_pick_up_points.dart';

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
  final BookRide bookRide;

  Completer<GoogleMapController> controller = Completer();

  late Position _position;
  final Set<Marker> markers = <Marker>{};
  final Set<Marker> dropOffMarkers = <Marker>{};
  final Set<Marker> pickUpMarkers = <Marker>{};

  String timeOfSelectedRides = StringManager.timeOfSelectedRides;

  SharedPreferences perfs = di<SharedPreferences>();
  String from = StringManager.pickUpPoint;
  String to = StringManager.dropOffPoint;
  List<int> pickUpIDs = [];
  List<int> dropOffIDs = [];
  late LatLng pickUpSelectedPosition;
  late LatLng dropOffSelectedPosition;
  List<String> amTitle = [];
  List<String> pmTitle = [];
  Map<String, int> amTimeAndID = {};
  Map<String, int> pmTimeAndID = {};
  late int pickUpID;
  late int dropOffID;
  late int amID;
  late int pmID;
  late int std;

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

  MapBloc(this.appointmentOfAm, this.appointmentOfPm, this.pickUp, this.dropOff,
      this.bookRide)
      : super(MapInitial()) {
    on<GetMyLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      _position = await determinePosition();
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.placeMarker,
      );
      BitmapDescriptor markerbitmap2 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );

      if (perfs.getBool('Booked') != null && perfs.getBool('Booked')!) {
        markers.add(
          Marker(
            markerId: MarkerId(
              pickUpSelectedPosition.toString(),
            ),
            position: pickUpSelectedPosition, //position of marker

            icon: markerbitmap2,
          ),
        );
        markers.add(
          Marker(
            markerId: MarkerId(
              dropOffSelectedPosition.toString(),
            ),
            position: dropOffSelectedPosition, //position of marker

            icon: markerbitmap2,
          ),
        );
      }

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

    on<SelectAMTripEvent>((event, emit) {
      timeOfSelectedRides = "";
      timeOfSelectedRides = event.timeOfTrip;
      amID = amTimeAndID[timeOfSelectedRides]!;
      emit(AMTripSelected());
    });

    on<SelectPMTripEvent>((event, emit) {
      if (timeOfSelectedRides.contains('-')) {
        timeOfSelectedRides = "";
      } else if (timeOfSelectedRides.isNotEmpty) {
        timeOfSelectedRides += " - ";
      }
      timeOfSelectedRides += event.timeOfTrip;
      pmID = pmTimeAndID[timeOfSelectedRides]!;
      emit(PMTripSelected());
    });

    on<GetAmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfAm
              .getAppoinmentsAM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentAmError(failure.message));
      }, (appointments) {
        for (var e in appointments) {
          amTimeAndID.addEntries([
            MapEntry(
                '${e.appointmentStartTime.substring(0, 5)} ${e.appointmentType}',
                e.id)
          ]);
        }
        amTitle = amTimeAndID.keys.toList();
        amTitle.sort();
        emit(GetAppoinmentAmSuccess(amRides));
      });
    });

    on<GetPmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfPm
              .getAppoinmentsPM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentPmError(failure.message));
      }, (appointments) {
        for (var e in appointments) {
          pmTimeAndID.addEntries([
            MapEntry(
                '${e.appointmentStartTime.substring(0, 5)} ${e.appointmentType}',
                e.id)
          ]);
        }
        pmTitle = pmTimeAndID.keys.toList();
        pmTitle.sort();
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
        pickUpIDs = pick.map((e) => e.id).toList();
        for (int i = 0; i < pickUps.length; i++) {
          pickUpMarkers.add(
            Marker(
              markerId: MarkerId(
                pickUps[i].toString(),
              ),
              onTap: () {
                pickUpSelectedPosition = pickUps[i];
                from = titlesOfPickUp[i];
                pickUpID = pickUpIDs[i];
                add(AddPickUpMarkerTitleToTexts(from, pickUpIDs[i]));
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
        dropOffIDs = drop.map((e) => e.id).toList();
        for (int i = 0; i < dropOffs.length; i++) {
          dropOffMarkers.add(
            Marker(
              markerId: MarkerId(
                dropOffs[i].toString(),
              ),
              onTap: () {
                dropOffSelectedPosition = dropOffs[i];
                to = titlesOfDropOff[i];
                add(AddDropOffMarkerTitleToTexts(to, dropOffIDs[i]));
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
      pickUpID = event.id;
      emit(SelectPickUpFromPlace(event.title));
    });

    on<AddDropOffMarkerTitleToTexts>((event, emit) {
      dropOffID = event.id;
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

    on<BookRideEvent>((event, emit) async {
      emit(Loading());
      (await bookRide.bookRide(event.ride)).fold((l) {
        emit(BookRideError(l.message));
      }, (r) {
        emit(BookRideSuccess());
        add(CameraPositionAfterBookingEvent());
      });
    });

    on<CameraPositionAfterBookingEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = pickUpSelectedPosition;
      LatLng location2 = dropOffSelectedPosition;

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPosition = LatLng(avgOfLat, avgOfLong);
      kGooglePlex = CameraPosition(
        target: cameraPosition,
        zoom: 13,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewAfterBooking());
    });

    on<RefreshBusCoordinateEvent>((event, emit) async {
      // BitmapDescriptor busIcon = await BitmapDescriptor.fromAssetImage(
      //   const ImageConfiguration(),
      //   AssetManager.busIconTracking,
      // );
      BitmapDescriptor markerbitmap2 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.busStationMarker,
      );
     
      markers.add(
        Marker(
          markerId: MarkerId(
            LatLng(event.point.latitude, event.point.longitude).toString(),
          ),
          position: LatLng(
              event.point.latitude, event.point.longitude), //position of marker

          icon: markerbitmap2,
        ),
      );
      emit(ChangeBusCoordinate());
    });
  }
}
