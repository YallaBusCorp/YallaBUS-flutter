import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/features/login_otp/data/repository_implementation/repository_implementation.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../home/presentation/bloc/map/map_bloc.dart';
import '../../../domain/repository/repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NetworkInfo network = di<NetworkInfo>();
  late String verificationId;
  late UserCredential user;
  LoginRepository imple;
  bool driverFoundOrNot = false;
  bool studentFoundOrNot = false;
  SharedPreferences perfs = di<SharedPreferences>();

  @override
  void onChange(Change<LoginState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  LoginBloc(this.imple) : super(LoginInitial()) {
    on<SendCodeVerificationEvent>((event, emit) async {
      emit(SendingData());
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (await network.isConnected()) {
        await _auth.verifyPhoneNumber(
            phoneNumber: event.number,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            timeout: const Duration(seconds: 60),
            codeAutoRetrievalTimeout: (String verificationId) {});
      } else {
        emit(const Error('You are not connected to internet'));
      }
    });

    on<VerifyCodeVerificationEvent>((event, emit) async {
      await submitOtp(event.otpCode);
    });

    on<CheckIfUserIsStudentOrDriverEvent>((event, emit) async {
      driverFoundOrNot = await FirebaseExtensions.checkIfRoleIsBus(
          perfs.getString(ConstantsManager.uid)!);
      studentFoundOrNot = await FirebaseExtensions.checkIfRoleIsStudent(
          perfs.getString(ConstantsManager.uid)!);
      if (driverFoundOrNot) {
        perfs.setString(ConstantsManager.driver, 'Exists');
        emit(ThisIsDriverAccount());
      }
      else if (studentFoundOrNot) {
        perfs.setString(ConstantsManager.student, 'Exists');
        emit(ThisIsStudentAccount());
      } else {
        perfs.setString(ConstantsManager.student, 'New');
        emit(ThisIsStudentAccount());
      }
    });

    on<GetBusUidEvent>((event, emit) async {
      (await imple.getBusUid(
        int.parse(FirebaseAuth.instance.currentUser!.phoneNumber!.substring(1)),
      ))
          .fold((l) {}, (r) {
        perfs.setString(ConstantsManager.busUid, r.uid);
        perfs.setInt(ConstantsManager.busId, r.id);
      });
    });
  }

  void verificationCompleted(AuthCredential credential) {}
  void verificationFailed(FirebaseAuthException authException) {
    emit(Error('${authException.message}'));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(Success());
  }

  Future<void> submitOtp(String otpCode) async {
    emit(SendingData());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    try {
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      final userFirebase = FirebaseAuth.instance.currentUser;
      final uid = userFirebase!.uid;
      final number = FirebaseAuth.instance.currentUser!.phoneNumber!;
      perfs.setString(ConstantsManager.uid, uid);
      perfs.setString(ConstantsManager.number, number);
      add(GetBusUidEvent());
      add(CheckIfUserIsStudentOrDriverEvent());
    } on FirebaseAuthException {
      emit(const Error('Wrong Verification!'));
    }
  }
}
