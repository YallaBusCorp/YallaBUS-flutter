part of 'bus_map_bloc.dart';

abstract class BusMapState extends Equatable {
  const BusMapState();

  @override
  List<Object> get props => [];
}

class BusMapInitial extends BusMapState {}

class ChangePosition extends BusMapState {
  final Set<Marker> s;

  const ChangePosition(this.s);
   @override
  List<Object> get props => [s];
}

class InitalizeMarkers extends BusMapState {}

class GetListOfCoordinates extends BusMapState {
  final List<LatLng> list;

  const GetListOfCoordinates(this.list);
   @override
  List<Object> get props => [list];
}
