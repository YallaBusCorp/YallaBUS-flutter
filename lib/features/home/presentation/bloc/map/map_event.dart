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

  const AddPickUpMarkerTitleToTexts(this.title);
  @override
  List<Object> get props => [title];
}

class AddDropOffMarkerTitleToTexts extends MapEvent {
  final String title;

  const AddDropOffMarkerTitleToTexts(this.title);
  @override
  List<Object> get props => [title];
}

class SaveInSharedPerfsEvent extends MapEvent {}

class CancelRideEvent extends MapEvent{}

