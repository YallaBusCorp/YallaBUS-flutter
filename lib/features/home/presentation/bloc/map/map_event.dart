part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMyLocation extends MapEvent {}

class SubmitBookRideEvent extends MapEvent {}


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


class GetPickUpPointsEvent extends MapEvent {
  final BuildContext context;
  const GetPickUpPointsEvent(this.context);
  @override
  List<Object> get props => [context];
}


class CameraPositionAfterBookingEvent extends MapEvent {}


class ShowCurrentRideAfterBookingEvent extends MapEvent {}



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


class RefreshMyLocationChanagesEvent extends MapEvent {
  final LocationData locationData;

  const RefreshMyLocationChanagesEvent(this.locationData);
  @override
  List<Object> get props => [locationData];
}


class RefreshBusCoordinateEvent extends MapEvent {
  final LatLng point;
  final BuildContext context;
  const RefreshBusCoordinateEvent(this.point, this.context);
  @override
  List<Object> get props => [point, context];
}
