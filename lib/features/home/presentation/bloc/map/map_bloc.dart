import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/map_manager.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_current_ride.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../../domain/enitity/reschedule_body.dart';
import '../../../domain/enitity/returned_ride.dart';
import '../../../domain/enitity/ride.dart';
import '../../../domain/use_case/book_ride.dart';
import '../../../domain/use_case/cancel_ride.dart';
import '../../../domain/use_case/get_appoinments_of_am.dart';
import '../../../domain/use_case/get_map_pick_up_points.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domain/use_case/get_appoinments_of_pm.dart';
import '../../../domain/use_case/get_map_drop_off_points.dart';
import '../../../domain/use_case/get_student_id.dart';
import '../../../domain/use_case/reschedule_ride.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetAppoinmentOfAM appointmentOfAm;
  final GetAppoinmentOfPM appointmentOfPm;
  final GetMapDropOffPoints dropOff;
  final GetMapPickUpPoints pickUp;
  final BookRide bookRide;
  final CancelRide cancelRide;
  final GetCurrentRide currentRide;
  final GetStudentId stdId;
  final RescheduleRide rescheduleRide;
  Completer<GoogleMapController> controller = Completer();
  bool departAndFromToVisible = false;
  bool rideVisible = false;
  double distanceOfRide = 0.0;
  String timeOfSelectedRides = StringManager.timeOfSelectedRides;
  Set<Marker> markersOfBus = {};
  SharedPreferences perfs = di<SharedPreferences>();
  String from = StringManager.pickUpPoint;
  String to = StringManager.dropOffPoint;
  List<int> pickUpIDs = [];
  List<int> dropOffIDs = [];
  LatLng pickUpSelectedPosition =
      const LatLng(30.965317563392837, 31.316227249605518);
  LatLng dropOffSelectedPosition =
      const LatLng(31.020093991171894, 31.370074396647205);
  LatLng busPosition = LatLng(30.965317563392837, 31.316227249605518);
  List<String> amTitle = [];
  List<String> pmTitle = [];
  Map<String, int> amTimeAndID = {};
  Map<String, int> pmTimeAndID = {};

  late int pickUpID;
  late int dropOffID;
  late int std;
  bool switchButtonValue = false;
  bool switchColor = false;
  List<String> titlesOfPickUp = [];
  List<String> titlesOfDropOff = [];
  List<dynamic> pickUps = const [];
  List<dynamic> dropOffs = const [];

  List<bool> selectedAmShips = List.generate(10, (index) => false);
  List<bool> selectedPmShips = List.generate(10, (index) => false);
  int previousIndex = 10;
  int previousIndexOfPm = 10;

  @override
  void onChange(Change<MapState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  MapBloc(
      this.appointmentOfAm,
      this.appointmentOfPm,
      this.pickUp,
      this.dropOff,
      this.bookRide,
      this.currentRide,
      this.cancelRide,
      this.stdId,
      this.rescheduleRide)
      : super(MapInitial()) {
    on<GetMyLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      MapManager.myLocation = await determineLocation();

      final m = MapManager.markers.firstWhere(
        (element) => element.markerId.value == '1',
        orElse: () => const Marker(
          markerId: MarkerId('3553'),
        ),
      );
      MapManager.removeMarker(m: m, marker: MapManager.markers);

      MapManager.addMarker(
          latlng: LatLng(MapManager.myLocation.latitude!,
              MapManager.myLocation.longitude!),
          icon: await MapManager.positionIcon(),
          marker: MapManager.markers,
          id: 1);
      con.animateCamera(
          CameraUpdate.newCameraPosition(MapManager.cameraPosition));
      emit(ChangePosition());
    });

    on<RefreshMyLocationChanagesEvent>((event, emit) async {
      MapManager.myLocation = event.locationData;
      MapManager.addMarker(
          latlng: LatLng(MapManager.myLocation.latitude!,
              MapManager.myLocation.longitude!),
          icon: await MapManager.positionIcon(),
          marker: MapManager.markers,
          id: 1);
      emit(ChangeMyLocationState(event.locationData));
    });

    on<ShowRidesAtPMEvent>((event, emit) {
      switchButtonValue = !switchButtonValue;
      emit(ChangeSwitchButtonColor());
    });

    on<SelectAMTripEvent>((event, emit) {
      timeOfSelectedRides = "";
      timeOfSelectedRides = event.timeOfTrip;
      perfs.setString(ConstantsManager.dateOfRide, timeOfSelectedRides);
      emit(AMTripSelected(timeOfSelectedRides));
    });

    on<SelectPMTripEvent>((event, emit) {
      if (timeOfSelectedRides == "Choose Ride") {
        timeOfSelectedRides = "";
      }
      if (timeOfSelectedRides.contains('-')) {
        timeOfSelectedRides = "";
      } else if (timeOfSelectedRides.isNotEmpty) {
        timeOfSelectedRides += " - ";
      }
      timeOfSelectedRides += event.timeOfTrip;
      perfs.setString(ConstantsManager.dateOfRide, timeOfSelectedRides);
      emit(PMTripSelected(timeOfSelectedRides));
    });

    on<GetAmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfAm
              .getAppoinmentsAM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentAmError(failure.message));
      }, (appointments) {
        for (var e in appointments) {
          String date = StringsExtensions.convertHourTo12HoursOnly(
              e.appointmentStartTime);
          amTimeAndID.addEntries([MapEntry(date, e.id)]);
        }
        amTitle = amTimeAndID.keys.toList();
        amTitle.sort();
        emit(GetAppoinmentAmSuccess(amTitle));
      });

      emit(GetAppoinmentAmSuccess(amTitle));
    });

    on<GetPmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfPm
              .getAppoinmentsPM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentPmError(failure.message));
      }, (appointments) {
        for (var e in appointments) {
          String date = StringsExtensions.convertHourTo12HoursOnly(
              e.appointmentStartTime);
          pmTimeAndID.addEntries([MapEntry(date, e.id)]);
        }
        pmTitle = pmTimeAndID.keys.toList();
        pmTitle.sort();
        emit(GetAppoinmentPmSuccess(pmTitle));
      });
      emit(GetAppoinmentPmSuccess(pmTitle));
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
              id: i,
              marker: MapManager.pickUpMarkers,
              latlng: pickUps[i],
              icon: await MapManager.stationIcon(),
              onTap: () {
                pickUpSelectedPosition = pickUps[i];
                perfs.setDouble(ConstantsManager.pickUpSelectedPositionLat,
                    pickUpSelectedPosition.latitude);
                perfs.setDouble(ConstantsManager.pickUpSelectedPositionLong,
                    pickUpSelectedPosition.longitude);
                from = titlesOfPickUp[i];
                pickUpID = pickUpIDs[i];
                perfs.setString(ConstantsManager.pickUp, from);
                add(AddPickUpMarkerTitleToTexts(from, pickUpIDs[i]));
              });
        }
      });
      add(CameraPositionOfPickUpPoints());
      emit(PickUpPointsMarkersChanged());
    });

    on<GetDropOffPointsEvent>((event, emit) async {
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
              id: i,
              marker: MapManager.dropOffMarkers,
              latlng: dropOffs[i],
              icon: await MapManager.stationIcon(),
              onTap: () {
                dropOffSelectedPosition = dropOffs[i];
                perfs.setDouble(ConstantsManager.dropOffSelectedPositionLat,
                    dropOffSelectedPosition.latitude);
                perfs.setDouble(ConstantsManager.dropOffSelectedPositionLong,
                    dropOffSelectedPosition.longitude);
                to = titlesOfDropOff[i];
                perfs.setString(ConstantsManager.dropOff, to);
                add(AddDropOffMarkerTitleToTexts(to, dropOffIDs[i]));
              });
        }
      });
      add(CameraPositionOfDropOffPoints());
      emit(DropOffPointsMarkersChanged());
    });

    on<CameraPositionOfPickUpPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = pickUps[0];
      LatLng location2 = pickUps[1];

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
      final GoogleMapController con = await controller.future;

      LatLng location1 = dropOffs[0];
      LatLng location2 = dropOffs[dropOffs.length - 1];

      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPositionOfDropOff = LatLng(avgOfLat, avgOfLong);
      MapManager.kGooglePlex = CameraPosition(
        target: cameraPositionOfDropOff,
        zoom: 12,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewForDropOffPoints());
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
        perfs.setInt(ConstantsManager.bookingID, r);
        distanceOfRide =
            RouteDistanceExtensions.calculateDistanceFromPickToDrop(
                pickUpSelectedPosition, dropOffSelectedPosition);
        perfs.setDouble(ConstantsManager.distance, distanceOfRide);
        emit(BookRideSuccess());
      });
    });

    on<CameraPositionAfterBookingEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = pickUpSelectedPosition;
      LatLng location2 = dropOffSelectedPosition;
      double avgOfLat = (location1.latitude + location2.latitude) / 2;
      double avgOfLong = (location1.longitude + location2.longitude) / 2;
      dynamic cameraPosition = LatLng(avgOfLat, avgOfLong);
      MapManager.kGooglePlex = CameraPosition(
        target: cameraPosition,
        zoom: 12,
      );
      CameraUpdate update =
          CameraUpdate.newCameraPosition(MapManager.kGooglePlex);
      con.animateCamera(update);
      emit(ChangeMapViewAfterBooking());
    });

    on<RefreshBusCoordinateEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      busPosition = LatLng(event.point.latitude, event.point.longitude);
      MapManager.addMarker(
        id: 2,
        marker: markersOfBus,
        latlng: busPosition,
        icon: await MapManager.bitmapDisForBus(
            event.context, AssetManager.busIconTracking),
      );

      CameraPosition kGooglePlex = CameraPosition(
        bearing: 0,
        tilt: 90,
        target: LatLng(event.point.latitude, event.point.longitude),
        zoom: 14.5,
      );
      CameraUpdate update = CameraUpdate.newCameraPosition(kGooglePlex);
      con.animateCamera(update);
      if (markersOfBus.isNotEmpty) {
        distanceOfRide = RouteDistanceExtensions.reduceDistance(
            LatLng(event.point.latitude, event.point.longitude),
            pickUpSelectedPosition,
            dropOffSelectedPosition,
            distanceOfRide);
      }

      emit(ChangeMarkersOfBus(kGooglePlex));
    });

    on<GetCurrentRideByUIDEvent>((event, emit) async {
      emit(Loading());
      (await currentRide.getCurrentRideByUID(event.uid)).fold((l) {
        emit(StudentCurrentRideError(l.message));
        departAndFromToVisible = true;
        rideVisible = false;
      }, (r) {
        if (r.id == -1) {
          departAndFromToVisible = true;
          rideVisible = false;
          emit(const StudentNotInCurrentRide());
        } else {
          pickUpSelectedPosition = LatLng(r.pick!.latitude, r.pick!.longitude);
          dropOffSelectedPosition = LatLng(r.drop!.latitude, r.drop!.longitude);
          if (markersOfBus.isEmpty) {
            distanceOfRide =
                RouteDistanceExtensions.calculateDistanceFromPickToDrop(
                    pickUpSelectedPosition, dropOffSelectedPosition);
          }
          rideVisible = true;
          departAndFromToVisible = false;
          add(ShowBothPickUpAndDropOffMarkersEvent(event.context));
          if (r.txRide!.rideStatus == 'process') {
            perfs.setString(ConstantsManager.rideID, r.txRide!.id.toString());
            FirebaseMessaging.instance.subscribeToTopic("${r.txRide!.id}");
            emit(StudentInCurrentRide(r));
          } else if (r.txRide!.rideStatus == 'complete') {
            rideVisible = false;
            departAndFromToVisible = true;
            Marker pick1 = MapManager.markers
                .firstWhere((element) => element.markerId.value == '3',
                    orElse: () => const Marker(
                          markerId: MarkerId('3553'),
                        ));
            Marker drop1 = MapManager.markers
                .firstWhere((element) => element.markerId.value == '4',
                    orElse: () => const Marker(
                          markerId: MarkerId('3553'),
                        ));
            MapManager.removeMarker(m: pick1, marker: MapManager.markers);
            MapManager.removeMarker(m: drop1, marker: MapManager.markers);
            markersOfBus.clear();
            emit(StudentRideComplete());
            add(FormToPreparationEvent());
          } else {
            emit(StudentInCurrentRide(r));
          }
        }
      });
    });

    on<ShowBothPickUpAndDropOffMarkersEvent>((event, emit) async {
      MapManager.pickUpMarkers.clear();
      MapManager.dropOffMarkers.clear();
      MapManager.addMarker(
          id: 3,
          latlng: pickUpSelectedPosition,
          icon: await MapManager.stationIcon(),
          marker: MapManager.markers);
      MapManager.addMarker(
          id: 4,
          latlng: dropOffSelectedPosition,
          icon: await MapManager.stationIcon(),
          marker: MapManager.markers);
      emit(AddBothPickUpAndDropOffMarkers(
          MapManager.pickUpMarkers, MapManager.dropOffMarkers));
    });

    on<CheckBusMarkerAccordingToPickAndDropMarkersEvent>((event, emit) async {
      Marker pick1 = MapManager.markers
          .firstWhere((element) => element.markerId.value == '3',
              orElse: () => const Marker(
                    markerId: MarkerId('3553'),
                  ));
      Marker drop1 = MapManager.markers
          .firstWhere((element) => element.markerId.value == '4',
              orElse: () => const Marker(
                    markerId: MarkerId('3553'),
                  ));
      if (distanceOfRide < perfs.getDouble(ConstantsManager.distance)!) {
        MapManager.removeMarker(m: pick1, marker: MapManager.pickUpMarkers);
      } else if (distanceOfRide > perfs.getDouble(ConstantsManager.distance)!) {
        MapManager.removeMarker(m: drop1, marker: MapManager.dropOffMarkers);
      }
      emit(MarkersRemoved());
    });

    on<CancelRideEvent>((event, emit) async {
      (await cancelRide.cancelRide(event.id)).fold((l) {
        emit(CancelRideError(l.message));
      }, (r) {
        Marker pick1 = MapManager.markers
            .firstWhere((element) => element.markerId.value == '3',
                orElse: () => const Marker(
                      markerId: MarkerId('3553'),
                    ));
        Marker drop1 = MapManager.markers
            .firstWhere((element) => element.markerId.value == '4',
                orElse: () => const Marker(
                      markerId: MarkerId('3553'),
                    ));
        MapManager.removeMarker(m: pick1, marker: MapManager.markers);
        MapManager.removeMarker(m: drop1, marker: MapManager.markers);
        markersOfBus.clear();
        add(FormToPreparationEvent());
        emit(CancelRideSuccess(MapManager.markers));
      });
    });

    on<CallDriverEvent>((event, emit) async {
      final url = "tel://+2${event.number}";
      launch(url);
      emit(Calling());
    });

    on<GetStudentIDEvent>((event, emit) async {
      (await stdId.getStudentId(event.uid)).fold((l) {}, (r) {
        perfs.setInt(ConstantsManager.stdId, r.id);
        perfs.setString(ConstantsManager.userName, r.name);
      });
    });

    on<FormToPreparationEvent>((event, emit) {
      timeOfSelectedRides = StringManager.timeOfSelectedRides;
      from = StringManager.pickUpPoint;
      to = StringManager.dropOffPoint;
      emit(FormToPreparationSuccess());
    });

    on<RescheduleRideEvent>((event, emit) async {
      (await rescheduleRide.rescheduleRide(event.rescheduleRide)).fold((l) {
        emit(RescheduleRideError(l.message));
      }, (r) {
        perfs.setString(ConstantsManager.qrCode, r.qrCode!);
        emit(RescheduleRideSuccess());
      });
    });
  }
}
