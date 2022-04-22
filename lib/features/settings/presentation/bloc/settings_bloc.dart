import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignOutEvent>((event, emit) async {
      
      try {
        await FirebaseAuth.instance.signOut();
        emit(SignOutSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignOutError(e.message!));
      }
    });
  }
}
