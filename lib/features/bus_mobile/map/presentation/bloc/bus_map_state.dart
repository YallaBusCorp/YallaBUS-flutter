part of 'bus_map_bloc.dart';

abstract class BusMapState extends Equatable {
  const BusMapState();

  @override
  List<Object> get props => [];
}

class BusMapInitial extends BusMapState {}

class ChangePosition extends BusMapState {}
