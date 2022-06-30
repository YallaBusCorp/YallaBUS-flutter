part of 'bus_ride_bloc.dart';

abstract class BusRideState extends Equatable {
  const BusRideState();

  @override
  List<Object> get props => [];
}

class BusRideInitial extends BusRideState {}

class GetListOfBooking extends BusRideState {
  final List<Booking> bookings;

  const GetListOfBooking(this.bookings);
}

class Error extends BusRideState {
  final String message;

  const Error(this.message);
}
