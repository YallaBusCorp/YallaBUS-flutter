part of 'ride_booking_bloc.dart';

abstract class RideBookingState extends Equatable {
  const RideBookingState();

  @override
  List<Object> get props => [];
}

class RideBookingInitial extends RideBookingState {}

class ChangeSwitchButtonColor extends RideBookingState {}

class AMTripSelected extends RideBookingState {
  final String trip;

  const AMTripSelected(this.trip);
  @override
  List<Object> get props => [trip];
}

class PMTripSelected extends RideBookingState {
  final String trip;

  const PMTripSelected(this.trip);
  @override
  List<Object> get props => [trip];
}


class GetAppoinmentAmSuccess extends RideBookingState {
  final List<String> am;

  const GetAppoinmentAmSuccess(this.am);
  @override
  List<Object> get props => [am];
}

class GetAppoinmentPmSuccess extends RideBookingState {
  final List<String> pm;

  const GetAppoinmentPmSuccess(this.pm);
  @override
  List<Object> get props => [pm];
}

class GetAppoinmentAmError extends RideBookingState {
  final String message;

  const GetAppoinmentAmError(this.message);
}

class GetAppoinmentPmError extends RideBookingState {
  final String message;

  const GetAppoinmentPmError(this.message);
}

class LoadingOfBooking extends RideBookingState {}

class BookRideSuccess extends RideBookingState {}

class BookRideError extends RideBookingState {
  final String error;

  const BookRideError(this.error);
}
