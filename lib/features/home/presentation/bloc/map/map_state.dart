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



class GetStudentID extends MapState {}

class ChangeMapViewAfterBooking extends MapState {}



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

class ChangeMarkersOfBus extends MapState {
  final CameraPosition p;

  const ChangeMarkersOfBus(this.p);
  @override
  List<Object> get props => [p];
}