import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/injection/di.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';

class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  List<int> phoneNumber = List.generate(9, (index) => 0);
  List<String> pins = List.generate(6, (index) => '');
  late String number = "+201";
  late String pinCode = "";
  late int indexOfPhoneNumber = 0;
  late int indexOfPinNumber = 0;
  SharedPreferences perfs = di<SharedPreferences>();

  @override
  void onChange(Change<KeyboardState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  KeyboardBloc() : super(KeyboardInitial()) {
    on<WritePhoneNumberEvent>((event, emit) {
      emit(Loading());
      phoneNumber[indexOfPhoneNumber] = event.number;
      number += event.number.toString();
      if (indexOfPhoneNumber < phoneNumber.length) {
        indexOfPhoneNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePhoneNumberEvent>((event, emit) {
      emit(Loading());
      if (indexOfPhoneNumber >= 1) {
        number = number.substring(0, number.length - 1);
        indexOfPhoneNumber--;
        phoneNumber[indexOfPhoneNumber] = 0;
      }
      emit(ChangeIndexOfNumber());
    });

    on<WritePinCodeEvent>((event, emit) {
      emit(Loading());
      pins[indexOfPinNumber] = event.number.toString();
      pinCode += event.number.toString();
      if (indexOfPinNumber < pins.length) {
        indexOfPinNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePinNumberEvent>((event, emit) {
      emit(Loading());
      if (indexOfPinNumber >= 1) {
        pinCode = pinCode.substring(0, pinCode.length - 1);
        indexOfPinNumber--;
        pins[indexOfPinNumber] = '';
      }
      emit(ChangeIndexOfNumber());
    });
  }
}
