part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class Loading extends MapState {}

class ChangePosition extends MapState {}

class BookRideInitial extends MapState {}

class ChangeSwitchButtonColor extends MapState {}

class AMTripSelected extends MapState {
  final String trip;

  const AMTripSelected(this.trip);
  @override
  List<Object> get props => [trip];
}

class PMTripSelected extends MapState {
  final String trip;

  const PMTripSelected(this.trip);
  @override
  List<Object> get props => [trip];
}

class InitializedMarkersOfStaticMap extends MapState {}

class GetAppoinmentAmSuccess extends MapState {
  final List<String> am;

  const GetAppoinmentAmSuccess(this.am);
  @override
  List<Object> get props => [am];
}

class GetAppoinmentPmSuccess extends MapState {
  final List<String> pm;

  const GetAppoinmentPmSuccess(this.pm);
  @override
  List<Object> get props => [pm];
}

class GetAppoinmentAmError extends MapState {
  final String message;

  const GetAppoinmentAmError(this.message);
}

class GetAppoinmentPmError extends MapState {
  final String message;

  const GetAppoinmentPmError(this.message);
}

class ChangeMapViewForDropOffPoints extends MapState {}

class ChangeMapViewForPickUpPoints extends MapState {}

class PickUpPointsMarkersChanged extends MapState {}

class DropOffPointsMarkersChanged extends MapState {}

class SelectDropOffFromPlace extends MapState {
  final String title;
  const SelectDropOffFromPlace(this.title);
  @override
  List<Object> get props => [title];
}

class SelectPickUpFromPlace extends MapState {
  final String title;
  const SelectPickUpFromPlace(this.title);
  @override
  List<Object> get props => [title];
}

class GetPickUpPointsError extends MapState {
  final String message;

  const GetPickUpPointsError(this.message);
}

class GetDropOffPointsError extends MapState {
  final String message;

  const GetDropOffPointsError(this.message);
}

class Saved extends MapState {}

class BookRideSuccess extends MapState {}

class BookRideError extends MapState {
  final String error;

  const BookRideError(this.error);
}

class GetStudentID extends MapState {}

class ChangeMapViewAfterBooking extends MapState {}

class ChangeBusCoordinate extends MapState {}

class ChangeMarkersOfBus extends MapState {
  final CameraPosition p;

  const ChangeMarkersOfBus(this.p);
  @override
  List<Object> get props => [p];
}

class StudentInCurrentRide extends MapState {
  final RideHis ride;

  const StudentInCurrentRide(this.ride);
}

class StudentNotInCurrentRide extends MapState {
  const StudentNotInCurrentRide();
}

class StudentCurrentRideError extends MapState {
  final String message;

  const StudentCurrentRideError(this.message);
}

class ShowCurrentRideAfterBooking extends MapState {}

class DocumentExists extends MapState {}

class DocumentNotExists extends MapState {}

class AddBothPickUpAndDropOffMarkers extends MapState {
  final Set<Marker> s;
  final Set<Marker> s1;

  const AddBothPickUpAndDropOffMarkers(this.s, this.s1);
}

class MarkersRemoved extends MapState {}

class ChangeMyLocationState extends MapState {
  final LocationData data;

  const ChangeMyLocationState(this.data);

  @override
  List<Object> get props => [data];
}

class Calling extends MapState {}

class CancelRideError extends MapState {
  final String message;

  const CancelRideError(this.message);
}

class CancelRideSuccess extends MapState {
  final Set<Marker> s;

  const CancelRideSuccess(this.s);
}
