part of 'bus_map_bloc.dart';

abstract class BusMapEvent extends Equatable {
  const BusMapEvent();

  @override
  List<Object> get props => [];
}

class GetBusLocation extends BusMapEvent {}
