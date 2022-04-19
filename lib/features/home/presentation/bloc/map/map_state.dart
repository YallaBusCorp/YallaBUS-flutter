part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class ChangePosition extends MapState {}

class BookRideInitial extends MapState {}

class ChangeSwitchButtonColor extends MapState {}

class AMTripSelected extends MapState {}

class PMTripSelected extends MapState {}

class InitializedMarkersOfStaticMap extends MapState {}

class GetAppoinmentAmSuccess extends MapState {
  final List<String> am;

  const GetAppoinmentAmSuccess(this.am);
}

class GetAppoinmentPmSuccess extends MapState {
  final List<String> pm;

  const GetAppoinmentPmSuccess(this.pm);
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
 





// class DrawMarkers extends MapState {
//   Set<Marker> markers;
//   DrawMarkers(this.markers);
// }
