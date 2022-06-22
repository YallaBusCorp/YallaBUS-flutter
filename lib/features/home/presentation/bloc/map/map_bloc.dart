import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/map_manager.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_current_ride.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
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
  final GetCurrentRide currentRide;
  bool departAndFromToVisible = false;
  bool rideVisible = false;

  String timeOfSelectedRides = StringManager.timeOfSelectedRides;
  Set<Marker> markersOfBus = {};
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
  bool switchButtonValue = false;
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
      this.bookRide, this.currentRide)
      : super(MapInitial()) {
    on<GetMyLocation>((event, emit) async {
      final GoogleMapController con = await MapManager.controller.future;
      MapManager.position = await determinePosition();

      if (perfs.getBool('Booked') != null && perfs.getBool('Booked')!) {
        MapManager.addMarker(
            latlng: pickUpSelectedPosition,
            icon: await MapManager.stationIcon(),
            marker: MapManager.markers);
        MapManager.addMarker(
            latlng: dropOffSelectedPosition,
            icon: await MapManager.stationIcon(),
            marker: MapManager.markers);
      }
      MapManager.addMarker(
          latlng: LatLng(
              MapManager.position.latitude, MapManager.position.longitude),
          icon: await MapManager.positionIcon(),
          marker: MapManager.markers);
      con.animateCamera(
          CameraUpdate.newCameraPosition(MapManager.cameraPosition));
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
      (await pickUp.getMapPickUpPoints(
        perfs.getInt(ConstantsManager.company)!,
      ))
          .fold((failure) {
        emit(GetPickUpPointsError(failure.message));
      }, (pick) async {
        titlesOfPickUp = pick.map((e) => e.mapPointTitleEn).toList();
        pickUps = pick.map((e) => LatLng(e.latitude, e.longitude)).toList();
        pickUpIDs = pick.map((e) => e.id).toList();
        for (int i = 0; i < pickUps.length; i++) {
          MapManager.addMarker(
              marker: MapManager.pickUpMarkers,
              latlng: pickUps[i],
              icon: await MapManager.stationIcon(),
              onTap: () {
                pickUpSelectedPosition = pickUps[i];
                from = titlesOfPickUp[i];
                pickUpID = pickUpIDs[i];
                add(AddPickUpMarkerTitleToTexts(from, pickUpIDs[i]));
              });
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
      }, (drop) async {
        titlesOfDropOff = drop.map((e) => e.mapPointTitleEn).toList();
        dropOffs = drop.map((e) => LatLng(e.latitude, e.longitude)).toList();
        dropOffIDs = drop.map((e) => e.id).toList();
        for (int i = 0; i < dropOffs.length; i++) {
          MapManager.addMarker(
              marker: MapManager.dropOffMarkers,
              latlng: dropOffSelectedPosition,
              icon: await MapManager.stationIcon(),
              onTap: () {
                dropOffSelectedPosition = dropOffs[i];
                to = titlesOfDropOff[i];
                add(AddDropOffMarkerTitleToTexts(to, dropOffIDs[i]));
              });
        }
        add(CameraPositionOfDropOffPoints());
      });
      emit(DropOffPointsMarkersChanged());
    });

    on<CameraPositionOfPickUpPoints>((event, emit) async {
      final GoogleMapController con = await MapManager.controller.future;
      LatLng location1 = pickUps[0];
      LatLng location2 = pickUps[pickUps.length - 1];

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPositionOfPickUp = LatLng(avgOfLat, avgOfLong);
      MapManager.kGooglePlex = CameraPosition(
        target: cameraPositionOfPickUp,
        zoom: 12,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForPickUpPoints());
    });

    on<CameraPositionOfDropOffPoints>((event, emit) async {
      final GoogleMapController con = await MapManager.controller.future;

      LatLng location1 = dropOffs[0];
      LatLng location2 = dropOffs[dropOffs.length - 1];

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPositionOfDropOff = LatLng(avgOfLat, avgOfLong);
      MapManager.kGooglePlex = CameraPosition(
        target: cameraPositionOfDropOff,
        zoom: 13,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
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

    on<BookRideEvent>((event, emit) async {
      emit(Loading());
      (await bookRide.bookRide(event.ride)).fold((l) {
        emit(BookRideError(l.message));
      }, (r) {
        perfs.setString(ConstantsManager.dateOfRide, timeOfSelectedRides);
        emit(BookRideSuccess());

        add(CameraPositionAfterBookingEvent());
      });
    });

    on<CameraPositionAfterBookingEvent>((event, emit) async {
      final GoogleMapController con = await MapManager.controller.future;
      LatLng location1 = pickUpSelectedPosition;
      LatLng location2 = dropOffSelectedPosition;

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPosition = LatLng(avgOfLat, avgOfLong);
      MapManager.kGooglePlex = CameraPosition(
        target: cameraPosition,
        zoom: 13,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewAfterBooking());
    });

    on<RefreshBusCoordinateEvent>((event, emit) async {
      final GoogleMapController con = await MapManager.controller.future;
      markersOfBus.clear();
      MapManager.addMarker(
          marker: markersOfBus,
          latlng: LatLng(event.point.latitude, event.point.longitude),
          icon: await MapManager.busIcon(),
          anchor: const Offset(0.5, 0.5));
      emit(ChangeMarkersOfBus(markersOfBus));
      MapManager.kGooglePlex = CameraPosition(
        bearing: 0,
        tilt: 0,
        target: LatLng(event.point.latitude, event.point.longitude),
        zoom: 16,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
      con.animateCamera(update);

      emit(ChangeBusCoordinate());
    });

    on<GetCurrentRideByUIDEvent>((event, emit) async {
      emit(Loading());
      (await currentRide.getCurrentRideByUID(event.uid)).fold((l) {
        emit(StudentCurrentRideError(l.message));
      }, (r) {
        if (r.id == -1) {
          departAndFromToVisible = true;
          rideVisible = false;
          emit(const StudentNotInCurrentRide());
        } else {
          rideVisible = true;
          departAndFromToVisible = false;
          emit(StudentInCurrentRide(r));
        }
      });
    });
  }
}
