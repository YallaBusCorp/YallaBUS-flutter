import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/bus_mobile/rides/data/repostiory_implementation.dart';
import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';

import '../../../../../core/injection/di.dart';

part 'bus_ride_event.dart';
part 'bus_ride_state.dart';

class BusRideBloc extends Bloc<BusRideEvent, BusRideState> {
  BusRideRepostiory repo;
  SharedPreferences perfs = di<SharedPreferences>();
  @override
  void onChange(Change<BusRideState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  BusRideBloc(this.repo) : super(BusRideInitial()) {
    on<BusRideEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckIfThereIsCurrentRideOrNotEvent>((event, emit) async {
      (await repo.getCurrentRideByBusUid(
              perfs.getString(ConstantsManager.busUid)!))
          .fold((l) {
        emit(Error(l.message));
      }, (r) {
        perfs.setInt(ConstantsManager.rideID, r[0].ride.id);
        emit(GetListOfBooking(r));
      });
    });
  }
}
