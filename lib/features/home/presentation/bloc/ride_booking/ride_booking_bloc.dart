import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../map/map_bloc.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/constants_manager.dart';

import '../../../../../core/resources/map_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../domain/enitity/ride.dart';
import '../../../domain/use_case/book_ride.dart';
import '../../../domain/use_case/get_appoinments_of_am.dart';
import '../../../domain/use_case/get_appoinments_of_pm.dart';
import '../../../domain/use_case/get_student_id.dart';
import '../map/pickup_dropoff_info.dart';

part 'ride_booking_event.dart';
part 'ride_booking_state.dart';

class RideBookingBloc extends Bloc<RideBookingEvent, RideBookingState> {
  List<bool> selectedAmShips = List.generate(10, (index) => false);
  List<bool> selectedPmShips = List.generate(10, (index) => false);
  int previousIndex = 10;
  int previousIndexOfPm = 10;
  bool switchButtonValue = false;
  bool switchColor = false;
  String timeOfSelectedRides = StringManager.timeOfSelectedRides;
  SharedPreferences perfs = di<SharedPreferences>();
  final BookRide bookRide;
  final GetAppoinmentOfAM appointmentOfAm;
  final GetAppoinmentOfPM appointmentOfPm;
  final GetStudentId stdId;

  double distanceOfRide = 0.0;
  Map<String, int> dictionaryOfAmTimeAndId = {};
  List<String> titlesOfAm = [];
  Map<String, int> dictionaryOfPmTimeAndId = {};
  List<String> titlesOfPm = [];
  RideBookingBloc(
      this.appointmentOfAm, this.appointmentOfPm, this.stdId, this.bookRide)
      : super(RideBookingInitial()) {
    on<RideBookingEvent>((event, emit) {
      // TODO: implement event handler
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
          dictionaryOfAmTimeAndId.addEntries([
            MapEntry(
                StringsExtensions.convertHourTo12HoursOnly(
                    e.appointmentStartTime),
                e.id)
          ]);
        }
        titlesOfAm = dictionaryOfAmTimeAndId.keys.toList();
        titlesOfAm.sort();
        emit(GetAppoinmentAmSuccess(titlesOfAm));
      });

      emit(GetAppoinmentAmSuccess(titlesOfAm));
    });

    on<GetPmAppoinmentsEvent>((event, emit) async {
      (await appointmentOfPm
              .getAppoinmentsPM(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(GetAppoinmentPmError(failure.message));
      }, (appointments) {
        for (var e in appointments) {
          dictionaryOfPmTimeAndId.addEntries([
            MapEntry(
                StringsExtensions.convertHourTo12HoursOnly(
                    e.appointmentStartTime),
                e.id)
          ]);
        }
        titlesOfPm = dictionaryOfPmTimeAndId.keys.toList();
        titlesOfPm.sort();
        emit(GetAppoinmentPmSuccess(titlesOfPm));
      });
      emit(GetAppoinmentPmSuccess(titlesOfPm));
    });

    on<GetStudentIDEvent>((event, emit) async {
      (await stdId.getStudentId(event.uid)).fold((l) {}, (r) {
        perfs.setInt(ConstantsManager.stdId, r.id);
        perfs.setString(ConstantsManager.userName, r.name);
      });
    });

    on<BookRideEvent>((event, emit) async {
      emit(LoadingOfBooking());
      (await bookRide.bookRide(event.ride)).fold((l) {
        emit(BookRideError(l.message));
      }, (r) {
        perfs.setInt(ConstantsManager.bookingID, r);
        distanceOfRide =
            RouteDistanceExtensions.calculateDistanceFromPickToDrop(
                LatLng(MapManager.myLocation.latitude!,
                    MapManager.myLocation.longitude!),
                PickUpAndDropOffInfo.dropOffSelectedPosition);
        perfs.setDouble(ConstantsManager.distance, distanceOfRide);
        emit(BookRideSuccess());
      });
    });
  }
}
