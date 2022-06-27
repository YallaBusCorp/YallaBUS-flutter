import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/map_manager.dart';

part 'bus_map_event.dart';
part 'bus_map_state.dart';

class BusMapBloc extends Bloc<BusMapEvent, BusMapState> {
  Completer<GoogleMapController> controller = Completer();

  Location location = Location();
  late LocationData myLocation;

  final Set<Marker> markers = <Marker>{};

  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);

  BusMapBloc() : super(BusMapInitial()) {
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
          icon: await MapManager.busIcon(),
          position: LatLng(myLocation.latitude!, myLocation.longitude!),
        ),
      );

      con.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(ChangePosition());
    });
  }
}
