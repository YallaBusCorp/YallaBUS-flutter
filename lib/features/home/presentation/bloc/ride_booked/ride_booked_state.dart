part of 'ride_booked_bloc.dart';

abstract class RideBookedState extends Equatable {
  const RideBookedState();

  @override
  List<Object> get props => [];
}

class RideBookedInitial extends RideBookedState {}

class LoadingOfBooked extends RideBookedState {}


class StudentInCurrentRide extends RideBookedState {
  final RideHis ride;

  const StudentInCurrentRide(this.ride);
}

class StudentNotInCurrentRide extends RideBookedState {
  const StudentNotInCurrentRide();
}

class StudentCurrentRideError extends RideBookedState {
  final String message;

  const StudentCurrentRideError(this.message);
}

class ShowCurrentRideAfterBooking extends RideBookedState {}

class StudentRideComplete extends RideBookedState {}



class Calling extends RideBookedState {}

class CancelRideError extends RideBookedState {
  final String message;

  const CancelRideError(this.message);
}

class CancelRideSuccess extends RideBookedState {
  final Set<Marker> s;

  const CancelRideSuccess(this.s);
}

class FormToPreparationSuccess extends RideBookedState {}

class RescheduleRideSuccess extends RideBookedState {}

class RescheduleRideError extends RideBookedState {
  final String message;

  const RescheduleRideError(this.message);
}
class ChangeBusCoordinate extends RideBookedState {}

