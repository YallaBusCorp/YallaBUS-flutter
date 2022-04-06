part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMyLocation extends MapEvent{}

class GetMarkers extends MapEvent{}
