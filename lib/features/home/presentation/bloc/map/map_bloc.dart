import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/map_manager.dart';
import 'pickup_dropoff_info.dart';
import '../ride_booked/ride_booked_bloc.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../domain/use_case/get_map_pick_up_points.dart';
import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domain/use_case/get_map_drop_off_points.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetMapDropOffPoints dropOff;
  final GetMapPickUpPoints pickUp;
  RideBookedBloc rideBookedBloc = di<RideBookedBloc>();
  Completer<GoogleMapController> controller = Completer();
  double distanceOfRide = 0.0;
  SharedPreferences perfs = di<SharedPreferences>();
  LatLng busPosition = const LatLng(30.965317563392837, 31.316227249605518);
  @override
  void onChange(Change<MapState> change) {
    super.onChange(change);
  }

  MapBloc(
    this.pickUp,
    this.dropOff,
  ) : super(MapInitial()) {
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
      distanceOfRide = RouteDistanceExtensions.calculateDistanceFromPickToDrop(
          LatLng(MapManager.myLocation.latitude!,
              MapManager.myLocation.longitude!),
          PickUpAndDropOffInfo.dropOffSelectedPosition);
      emit(ChangeMyLocationState(event.locationData));
    });

    on<GetPickUpPointsEvent>((event, emit) async {
      (await pickUp.getMapPickUpPoints(
        perfs.getInt(ConstantsManager.company)!,
      ))
          .fold((failure) {
        emit(GetPickUpPointsError(failure.message));
      }, (pick) async {
        PickUpAndDropOffInfo.titlesOfPickUp =
            pick.map((e) => e.mapPointTitleEn).toList();
        PickUpAndDropOffInfo.pickUps =
            pick.map((e) => LatLng(e.latitude, e.longitude)).toList();
        PickUpAndDropOffInfo.pickUpIDs = pick.map((e) => e.id).toList();
        for (int i = 0; i < PickUpAndDropOffInfo.pickUps.length; i++) {
          MapManager.addMarker(
              id: i,
              marker: MapManager.pickUpMarkers,
              latlng: PickUpAndDropOffInfo.pickUps[i],
              icon: await MapManager.stationIcon(),
              onTap: () {
                PickUpAndDropOffInfo.pickUpSelectedPosition =
                    PickUpAndDropOffInfo.pickUps[i];
                perfs.setDouble(ConstantsManager.pickUpSelectedPositionLat,
                    PickUpAndDropOffInfo.pickUpSelectedPosition.latitude);
                perfs.setDouble(ConstantsManager.pickUpSelectedPositionLong,
                    PickUpAndDropOffInfo.pickUpSelectedPosition.longitude);
                rideBookedBloc.from = PickUpAndDropOffInfo.titlesOfPickUp[i];
                PickUpAndDropOffInfo.pickUpID =
                    PickUpAndDropOffInfo.pickUpIDs[i];
                perfs.setString(ConstantsManager.pickUp, rideBookedBloc.from);
                add(AddPickUpMarkerTitleToTexts(
                    rideBookedBloc.from, PickUpAndDropOffInfo.pickUpIDs[i]));
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
        PickUpAndDropOffInfo.titlesOfDropOff =
            drop.map((e) => e.mapPointTitleEn).toList();
        PickUpAndDropOffInfo.dropOffs =
            drop.map((e) => LatLng(e.latitude, e.longitude)).toList();
        PickUpAndDropOffInfo.dropOffIDs = drop.map((e) => e.id).toList();
        for (int i = 0; i < PickUpAndDropOffInfo.dropOffs.length; i++) {
          MapManager.addMarker(
              id: i,
              marker: MapManager.dropOffMarkers,
              latlng: PickUpAndDropOffInfo.dropOffs[i],
              icon: await MapManager.stationIcon(),
              onTap: () {
                PickUpAndDropOffInfo.dropOffSelectedPosition =
                    PickUpAndDropOffInfo.dropOffs[i];
                perfs.setDouble(ConstantsManager.dropOffSelectedPositionLat,
                    PickUpAndDropOffInfo.dropOffSelectedPosition.latitude);
                perfs.setDouble(ConstantsManager.dropOffSelectedPositionLong,
                    PickUpAndDropOffInfo.dropOffSelectedPosition.longitude);
                rideBookedBloc.to = PickUpAndDropOffInfo.titlesOfDropOff[i];
                perfs.setString(ConstantsManager.dropOff, rideBookedBloc.to);
                add(AddDropOffMarkerTitleToTexts(
                    rideBookedBloc.to, PickUpAndDropOffInfo.dropOffIDs[i]));
              });
        }
      });
      add(CameraPositionOfDropOffPoints());
      emit(DropOffPointsMarkersChanged());
    });

    on<CameraPositionOfPickUpPoints>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = PickUpAndDropOffInfo.pickUps[0];
      LatLng location2 = PickUpAndDropOffInfo.pickUps[1];

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

      LatLng location1 = PickUpAndDropOffInfo.dropOffs[0];
      LatLng location2 = PickUpAndDropOffInfo
          .dropOffs[PickUpAndDropOffInfo.dropOffs.length - 1];

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
      PickUpAndDropOffInfo.pickUpID = event.id;
      emit(SelectPickUpFromPlace(event.title));
    });

    on<AddDropOffMarkerTitleToTexts>((event, emit) {
      PickUpAndDropOffInfo.dropOffID = event.id;
      emit(SelectDropOffFromPlace(event.title));
    });

    on<CameraPositionAfterBookingEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      LatLng location1 = PickUpAndDropOffInfo.pickUpSelectedPosition;
      LatLng location2 = PickUpAndDropOffInfo.dropOffSelectedPosition;
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

    on<ShowBothPickUpAndDropOffMarkersEvent>((event, emit) async {
      MapManager.pickUpMarkers.clear();
      MapManager.dropOffMarkers.clear();
      MapManager.addMarker(
          id: 3,
          latlng: PickUpAndDropOffInfo.pickUpSelectedPosition,
          icon: await MapManager.stationIcon(),
          marker: MapManager.markers);
      MapManager.addMarker(
          id: 4,
          latlng: PickUpAndDropOffInfo.dropOffSelectedPosition,
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
    on<RefreshBusCoordinateEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      busPosition = LatLng(event.point.latitude, event.point.longitude);
      MapManager.addMarker(
        id: 2,
        marker: MapManager.markersOfBus,
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

      emit(ChangeMarkersOfBus(kGooglePlex));
    });
  }
}
