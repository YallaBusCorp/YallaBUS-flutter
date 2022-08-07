part of 'ride_booking_bloc.dart';

abstract class RideBookingEvent extends Equatable {
  const RideBookingEvent();

  @override
  List<Object> get props => [];
}

class ShowRidesAtPMEvent extends RideBookingEvent {}

class SelectAMTripEvent extends RideBookingEvent {
  final String timeOfTrip;

  const SelectAMTripEvent(this.timeOfTrip);
}

class SelectPMTripEvent extends RideBookingEvent {
  final String timeOfTrip;

  const SelectPMTripEvent(this.timeOfTrip);
}

class GetAmAppoinmentsEvent extends RideBookingEvent {}

class GetPmAppoinmentsEvent extends RideBookingEvent {}


class GetStudentIDEvent extends RideBookingEvent {
  final String uid;

  const GetStudentIDEvent(this.uid);
}

class BookRideEvent extends RideBookingEvent {
  final Ride ride;

  const BookRideEvent(this.ride);
}
