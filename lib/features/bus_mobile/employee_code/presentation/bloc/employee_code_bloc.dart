import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/domain/repostiory.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/constants_manager.dart';

part 'employee_code_event.dart';
part 'employee_code_state.dart';

class EmployeeCodeBloc extends Bloc<EmployeeCodeEvent, EmployeeCodeState> {
  List<String> pins = List.generate(6, (index) => '');
  late String pinCode = "";
  late int indexOfPhoneNumber = 0;
  late int indexOfPinNumber = 0;
  EmployeeCodeRepository repo;
  SharedPreferences perfs = di<SharedPreferences>();
  EmployeeCodeBloc(this.repo) : super(EmployeeCodeInitial()) {
    on<EmployeeCodeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WritePinCodeEvent>((event, emit) {
      emit(Loading());
      pins[indexOfPinNumber] = event.number.toString();
      pinCode += event.number.toString();
      if (indexOfPinNumber < pins.length) {
        indexOfPinNumber++;
      }
      emit(ChangeIndexOfPin());
    });

    on<RemovePinNumberEvent>((event, emit) {
      emit(Loading());
      if (indexOfPinNumber >= 1) {
        pinCode = pinCode.substring(0, pinCode.length - 1);
        indexOfPinNumber--;
        pins[indexOfPinNumber] = '';
      }
      emit(ChangeIndexOfPin());
    });

    on<GetBusUidEvent>((event, emit) async {
      (await repo.getBusUid(
        int.parse(event.number.substring(1)),
      ))
          .fold((l) {}, (r) {
        perfs.setString(ConstantsManager.busUid, r.uid);
        perfs.setInt(ConstantsManager.busId, r.id);
      });
    });

    on<SaveEmployeeCodeEvent>((event, emit) async {
      perfs.setString(ConstantsManager.employeeCode, event.code);
      emit(Saved());
    });
  }
}
