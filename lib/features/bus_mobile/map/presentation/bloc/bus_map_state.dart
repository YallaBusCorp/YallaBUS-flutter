part of 'bus_map_bloc.dart';

abstract class BusMapState extends Equatable {
  const BusMapState();

  @override
  List<Object> get props => [];
}

class BusMapInitial extends BusMapState {}

class ChangePosition extends BusMapState {
  final CameraPosition p;

  const ChangePosition(this.p);
  @override
  List<Object> get props => [p];
}

class InitalizeMarkers extends BusMapState {}

class GetListOfCoordinates extends BusMapState {
  final List<LatLng> list;

  const GetListOfCoordinates(this.list);
  @override
  List<Object> get props => [list];
}

class RideCompletedSuccess extends BusMapState {}

class RideCompletedError extends BusMapState {
  final String message;

  const RideCompletedError(this.message);
}
