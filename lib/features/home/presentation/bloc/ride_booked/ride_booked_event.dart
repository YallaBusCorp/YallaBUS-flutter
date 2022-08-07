part of 'ride_booked_bloc.dart';

abstract class RideBookedEvent extends Equatable {
  const RideBookedEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentRideByUIDEvent extends RideBookedEvent {
  final String uid;
  final BuildContext context;
  const GetCurrentRideByUIDEvent(this.uid, this.context);
}

class FormToPreparationEvent extends RideBookedEvent {}

class CancelRideEvent extends RideBookedEvent {
  final int id;

  const CancelRideEvent(this.id);
}

class RescheduleRideEvent extends RideBookedEvent {
  final Reschedule rescheduleRide;

  const RescheduleRideEvent(this.rescheduleRide);
}

class CallDriverEvent extends RideBookedEvent {
  final String number;

  const CallDriverEvent(this.number);
}

