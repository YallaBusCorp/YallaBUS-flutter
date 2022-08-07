import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../map/map_bloc.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../../domain/enitity/reschedule_body.dart';
import '../../../domain/use_case/cancel_ride.dart';
import '../../../domain/use_case/get_current_ride.dart';
import '../../../domain/use_case/reschedule_ride.dart';
import '../map/pickup_dropoff_info.dart';
import '../ride_booking/ride_booking_bloc.dart';

part 'ride_booked_event.dart';
part 'ride_booked_state.dart';

class RideBookedBloc extends Bloc<RideBookedEvent, RideBookedState> {
  final CancelRide cancelRide;
  final GetCurrentRide currentRide;
  final RescheduleRide rescheduleRide;
  String from = StringManager.pickUpPoint;
  String to = StringManager.dropOffPoint;
  Completer<GoogleMapController> controller = Completer();
  MapBloc mapBloc = di<MapBloc>();

  RideBookingBloc bookingBloc = di<RideBookingBloc>();
  SharedPreferences perfs = di<SharedPreferences>();
  bool departAndFromToVisible = false;
  bool rideVisible = false;

  bool value = false;

  RideBookedBloc(this.cancelRide, this.currentRide, this.rescheduleRide)
      : super(RideBookedInitial()) {
    on<RideBookedEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetCurrentRideByUIDEvent>((event, emit) async {
      emit(LoadingOfBooked());
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
          PickUpAndDropOffInfo.pickUpSelectedPosition =
              LatLng(r.pick!.latitude, r.pick!.longitude);
          PickUpAndDropOffInfo.dropOffSelectedPosition =
              LatLng(r.drop!.latitude, r.drop!.longitude);

          rideVisible = true;
          departAndFromToVisible = false;
          mapBloc.add(ShowBothPickUpAndDropOffMarkersEvent(event.context));
          if (r.txRide!.rideStatus == 'process') {
            value = true;
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
            MapManager.markersOfBus.clear();
            emit(StudentRideComplete());
            add(FormToPreparationEvent());
          } else {
            emit(StudentInCurrentRide(r));
          }
        }
      });
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
        MapManager.markersOfBus.clear();
        add(FormToPreparationEvent());
        emit(CancelRideSuccess(MapManager.markers));
      });
    });

    on<CallDriverEvent>((event, emit) async {
      final url = "tel://+2${event.number}";
      launchUrl(Uri.parse(url));
      emit(Calling());
    });

    on<FormToPreparationEvent>((event, emit) {
      bookingBloc.timeOfSelectedRides = StringManager.timeOfSelectedRides;
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
