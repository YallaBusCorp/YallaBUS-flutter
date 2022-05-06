import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

enum Resonses { answered, inQueue }

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Color replyOrNot = Colors.red;
  List<String> dropDownOptions = [
    'Driver issues',
    'Subscription issues',
    'Other',
  ];
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
