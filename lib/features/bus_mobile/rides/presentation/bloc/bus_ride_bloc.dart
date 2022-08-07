import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../data/repostiory_implementation.dart';
import '../../data/send_notification.dart';
import '../../domain/entity/all_rides.dart';

import '../../../../../core/injection/di.dart';

part 'bus_ride_event.dart';
part 'bus_ride_state.dart';

class BusRideBloc extends Bloc<BusRideEvent, BusRideState> {
  BusRideRepostiory repo;
  SendNotificationApiClient client;
  SharedPreferences perfs = di<SharedPreferences>();
  @override
  void onChange(Change<BusRideState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  BusRideBloc(this.repo, this.client) : super(BusRideInitial()) {
    on<BusRideEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckIfThereIsCurrentRideOrNotEvent>((event, emit) async {
      (await repo.getCurrentRideByBusUid(
              perfs.getString(ConstantsManager.busUid)!))
          .fold((l) {
        emit(Error(l.message));
      }, (r) {
        perfs.setString(ConstantsManager.rideID, r[0].ride.id.toString());
        emit(GetListOfBooking(r));
      });
    });

    on<SignOutEvent>((event, emit) async {
      try {
        await FirebaseAuth.instance.signOut();
        emit(SignOutSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignOutError(e.message!));
      }
    });

    on<SendNotificationEvent>((event, emit) async {
      await client.sendNotification(event.rideId);
    });
  }
}
