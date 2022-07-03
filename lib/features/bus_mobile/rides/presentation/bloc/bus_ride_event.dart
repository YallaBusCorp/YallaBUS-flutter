part of 'bus_ride_bloc.dart';

abstract class BusRideEvent extends Equatable {
  const BusRideEvent();

  @override
  List<Object> get props => [];
}

class CheckIfThereIsCurrentRideOrNotEvent extends BusRideEvent {}

class SignOutEvent extends BusRideEvent {}

class SendNotificationEvent extends BusRideEvent {
  final int rideId;

  const SendNotificationEvent(this.rideId);
}
