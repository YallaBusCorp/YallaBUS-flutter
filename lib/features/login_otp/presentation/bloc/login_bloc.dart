import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  List<int> phoneNumber = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,

  ];

  int index = 0;
  LoginBloc() : super(LoginInitial()) {
    on<WritePhoneNumber>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      phoneNumber[index] = event.number;
      if (index < phoneNumber.length) {
        index++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePhoneNumber>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      if(index >= 1)
      {
      index--;
      phoneNumber[index] = 0;
      }
      emit(ChangeIndexOfNumber());
    });
  }
}
