import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/login_otp/data/firebase/send_code.dart';
import 'package:yalla_bus/features/login_otp/data/repository_implementation/repository_implementation.dart';
import 'package:yalla_bus/features/login_otp/domain/repository/repository.dart';
import 'package:yalla_bus/features/login_otp/domain/use%20case/send_code_verification.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';

GetIt di = GetIt.instance;
Future<void> init() async {
  final perfs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => perfs);

  di.registerFactory(() => LoginBloc());

  di.registerLazySingleton(() => SendCodeVerification(di()));

  di.registerLazySingleton<Repository>(() => RepositoryImplementation(di(), di()));

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(di()));

  di.registerLazySingleton(() => FirebaseAuthLogin());

  di.registerLazySingleton(() => Connectivity());
}
