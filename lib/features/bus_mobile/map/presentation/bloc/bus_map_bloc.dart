import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/bus_mobile/map/api/all_coordinates.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../../rides/domain/entity/all_rides.dart';
import '../../api/repostiory.dart';

part 'bus_map_event.dart';
part 'bus_map_state.dart';

class BusMapBloc extends Bloc<BusMapEvent, BusMapState> {
  Completer<GoogleMapController> controller = Completer();

  Location location = Location();
  late LocationData myLocation;
  final Set<Marker> markers = <Marker>{};
  final Set<Marker> dropAndPick = <Marker>{};
  SharedPreferences perfs = di<SharedPreferences>();
  BusMapRepository repo;
  List<LatLng> list = [];
  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);

  BusMapBloc(this.repo) : super(BusMapInitial()) {
    on<BusMapEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetBusLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      myLocation = await determineLocation();
      final CameraPosition cameraPosition = CameraPosition(
          bearing: 0,
          target: LatLng(myLocation.latitude!, myLocation.longitude!),
          tilt: 0,
          zoom: 19.151926040649414);
      final m = markers.firstWhere(
        (element) => element.markerId.value == '1',
        orElse: () => const Marker(
          markerId: MarkerId('3553'),
        ),
      );
      markers.remove(m);
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: await MapManager.bitmapDisForBus(
              event.context, AssetManager.busIconTracking),
          position: LatLng(myLocation.latitude!, myLocation.longitude!),
          anchor: const Offset(0.5, 0.5),
        ),
      );
      con.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(ChangePosition(cameraPosition));
    });

    on<InitializeBusMarkersEvent>((event, emit) async {
      // dropAndPick.clear();
      for(int i=0; i<event.bookings.length;i++)
      {
        dropAndPick.add(
          Marker(
            markerId:  MarkerId( LatLng(event.bookings[i].pickUp.latitude, event.bookings[i].pickUp.longitude).toString()),
            icon: await MapManager.bitmapDescriptorFromSvgAsset(
                event.context, AssetManager.busStationSvg),
            position: LatLng(event.bookings[i].pickUp.latitude, event.bookings[i].pickUp.longitude),
            anchor: const Offset(0.5, 0.5),
          ),
        );
        dropAndPick.add(
          Marker(
            markerId: MarkerId( LatLng(event.bookings[i].dropOff.latitude, event.bookings[i].dropOff.longitude).toString()),
            icon: await MapManager.bitmapDescriptorFromSvgAsset(
                event.context, AssetManager.busStationSvg),
            position: LatLng(event.bookings[i].dropOff.latitude, event.bookings[i].dropOff.longitude),
            anchor: const Offset(0.5, 0.5),
          ),
        );
      }
      
      emit(InitalizeMarkers());
    });

    on<RefershBusEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      final CameraPosition cameraPosition = CameraPosition(
          bearing: 0,
          target: LatLng(event.x.latitude, event.x.longitude),
          tilt: 0,
          zoom: 13.5);
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: await MapManager.bitmapDisForBus(
              event.context, AssetManager.busIconTracking),
          position: LatLng(event.x.latitude, event.x.longitude),
          anchor: const Offset(0.5, 0.5),
        ),
      );
      con.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(ChangePosition(cameraPosition));
    });

    on<FinishRideEvent>((event, emit) async {
      (await repo.finishRide(perfs.getInt(ConstantsManager.rideID)!))
          .fold((l) {}, (r) {
        if (r) {
          emit(RideCompletedSuccess());
        } else {
          emit(const RideCompletedError('Try again in another time'));
        }
      });
    });
  }
}
