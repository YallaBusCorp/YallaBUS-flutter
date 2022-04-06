import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'completeprofile_event.dart';
part 'completeprofile_state.dart';

class CompleteprofileBloc extends Bloc<CompleteprofileEvent, CompleteprofileState> {
  CompleteprofileBloc() : super(CompleteprofileInitial()) {
    on<CompleteprofileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
