import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../domain/repostiory.dart';

part 'employee_code_event.dart';
part 'employee_code_state.dart';

class EmployeeCodeBloc extends Bloc<EmployeeCodeEvent, EmployeeCodeState> {
  List<String> pins = List.generate(6, (index) => '');
  late String pinCode = "";
  late int indexOfPhoneNumber = 0;
  late int indexOfPinNumber = 0;
  EmployeeCodeRepository repo;
  String empName = "";
  SharedPreferences perfs = di<SharedPreferences>();
  EmployeeCodeBloc(this.repo) : super(EmployeeCodeInitial()) {
    on<EmployeeCodeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WritePinCodeEvent>((event, emit) {
      emit(LoadingCode());
      pins[indexOfPinNumber] = event.number.toString();
      pinCode += event.number.toString();
      if (indexOfPinNumber < pins.length) {
        indexOfPinNumber++;
      }
      emit(ChangeIndexOfPin());
    });

    on<RemovePinNumberEvent>((event, emit) {
      emit(LoadingCode());
      if (indexOfPinNumber >= 1) {
        pinCode = pinCode.substring(0, pinCode.length - 1);
        indexOfPinNumber--;
        pins[indexOfPinNumber] = '';
      }
      emit(ChangeIndexOfPin());
    });

    on<SaveEmployeeCodeEvent>((event, emit) async {
      perfs.setString(ConstantsManager.employeeCode, event.code);
      emit(Saved());
    });
    on<GetEmployeeEntityEvent>((event, emit) async {
      emit(LoadingCode());
      (await repo.getEmployee(event.code)).fold((l) {
        emit(AuthFailed(l.message));
      }, (r) {
        empName = r.empName;
        perfs.setString(ConstantsManager.employeeCode, event.code);
        add(SaveTxRideEvent(r.id));
        add(GetCompanyName(r.company.id));
        emit(GetEmployeeSuccess());
      });
    });

    on<SaveTxRideEvent>((event, emit) async {
      (await repo.saveTxRide(event.id, perfs.getInt(ConstantsManager.busId)!))
          .fold((l) {}, (r) {
        emit(AuthSuccess());
      });
    });

    on<GetCompanyName>((event, emit) async {
      (await repo.getCompanyName(event.id)).fold((l) {
        emit(Error(l.message));
      }, (r) {
        perfs.setString(ConstantsManager.companyName, r);
        emit(SuccessID());
      });
    });
  }
}
