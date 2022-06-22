part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMyLocation extends MapEvent {}

class SubmitBookRideEvent extends MapEvent {}

class ShowRidesAtPMEvent extends MapEvent {}

class InitializeStaticMapEvent extends MapEvent {}

class SelectAMTripEvent extends MapEvent {
  final String timeOfTrip;

  const SelectAMTripEvent(this.timeOfTrip);
}

class SelectPMTripEvent extends MapEvent {
  final String timeOfTrip;

  const SelectPMTripEvent(this.timeOfTrip);
}

class GetAmAppoinmentsEvent extends MapEvent {}

class GetPmAppoinmentsEvent extends MapEvent {}

class GetPickUpPointsEvent extends MapEvent {}

class GetDropOffPointsEvent extends MapEvent {}

class CameraPositionOfPickUpPoints extends MapEvent {}

class CameraPositionOfDropOffPoints extends MapEvent {}

class AddPickUpMarkerTitleToTexts extends MapEvent {
  final String title;
  final int id;
  const AddPickUpMarkerTitleToTexts(this.title, this.id);
  @override
  List<Object> get props => [title];
}

class AddDropOffMarkerTitleToTexts extends MapEvent {
  final String title;
  final int id;

  const AddDropOffMarkerTitleToTexts(this.title, this.id);
  @override
  List<Object> get props => [title];
}

class BookRideEvent extends MapEvent {
  final Ride ride;

  const BookRideEvent(this.ride);
}

class GetStudentIDEvent extends MapEvent {
  final String uid;

  const GetStudentIDEvent(this.uid);
}

class CameraPositionAfterBookingEvent extends MapEvent {}

class GetCurrentRideByUIDEvent extends MapEvent {
  final String uid;

  const GetCurrentRideByUIDEvent(this.uid);
}

class RefreshBusCoordinateEvent extends MapEvent {
  final GeoPoint point;
  final GeoPoint point2;

  const RefreshBusCoordinateEvent(this.point, this.point2);
}
