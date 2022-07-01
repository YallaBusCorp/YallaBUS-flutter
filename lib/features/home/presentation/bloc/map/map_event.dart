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

class GetPickUpPointsEvent extends MapEvent {
  final BuildContext context;
  const GetPickUpPointsEvent(this.context);
  @override
  List<Object> get props => [context];
}

class GetDropOffPointsEvent extends MapEvent {
  final BuildContext context;
  const GetDropOffPointsEvent(this.context);
  @override
  List<Object> get props => [context];
}

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
  final BuildContext context;
  const GetCurrentRideByUIDEvent(this.uid, this.context);
}

class ShowCurrentRideAfterBookingEvent extends MapEvent {}

class RefreshBusCoordinateEvent extends MapEvent {
  final LatLng point;
  final LatLng point2;
  final BuildContext context;
  const RefreshBusCoordinateEvent(this.point, this.point2, this.context);
  @override
  List<Object> get props => [point, point2, context];
}

class ShowBothPickUpAndDropOffMarkersEvent extends MapEvent {
  final BuildContext context;
  const ShowBothPickUpAndDropOffMarkersEvent(this.context);
}

class CheckBusMarkerAccordingToPickAndDropMarkersEvent extends MapEvent {
  final LatLng bus;
  final LatLng pick;
  final LatLng drop;

  const CheckBusMarkerAccordingToPickAndDropMarkersEvent(
      this.bus, this.pick, this.drop);
}

class CheckIfDocumentExistsOrNotEvent extends MapEvent {
  final String docId;

  const CheckIfDocumentExistsOrNotEvent(this.docId);
}

class CallDriverEvent extends MapEvent {
  final String number;

  const CallDriverEvent(this.number);
}

class RefreshMyLocationChanagesEvent extends MapEvent {
  final LocationData locationData;

  const RefreshMyLocationChanagesEvent(this.locationData);
  @override
  List<Object> get props => [locationData];
}

class CancelRideEvent extends MapEvent {
  final int id;

  const CancelRideEvent(this.id);
}
