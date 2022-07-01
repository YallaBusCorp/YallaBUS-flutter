part of 'bus_map_bloc.dart';

abstract class BusMapEvent extends Equatable {
  const BusMapEvent();

  @override
  List<Object> get props => [];
}

class GetBusLocation extends BusMapEvent {
  final BuildContext context;

  const GetBusLocation(this.context);
}

class InitializeBusMarkersEvent extends BusMapEvent {
  final List<Booking> bookings;
  final BuildContext context;
  const InitializeBusMarkersEvent(this.bookings, this.context);
}

class BusMovesEvent extends BusMapEvent {
  final LatLng a;
  final LatLng b;

  const BusMovesEvent(this.a, this.b);
}

class RefershBusEvent extends BusMapEvent {
  final LatLng x;
  final BuildContext context;
  const RefershBusEvent(this.x, this.context);
  @override
  List<Object> get props => [x, context];
}

class FinishRideEvent extends BusMapEvent {
  const FinishRideEvent();
}
