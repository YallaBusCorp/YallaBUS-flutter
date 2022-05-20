import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/network_info.dart';
import '../../features/choose_company/data/data_sources/remote_data_source.dart';
import '../../features/choose_company/data/repository_implementation/company_repository_implementation.dart';
import '../../features/choose_company/domain/repository/company_repository.dart';
import '../../features/choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../features/home/domain/use_case/get_appoinments_of_am.dart';
import '../../features/home/domain/use_case/get_map_drop_off_points.dart';
import '../../features/home/domain/use_case/get_map_pick_up_points.dart';
import '../../features/login_otp/domain/use%20case/send_code_verification.dart';
import '../../features/login_otp/presentation/bloc/Login/login_bloc.dart';
import '../../features/settings/data/data_sources/settings_remote_data_source.dart';
import '../../features/settings/data/repostiory_implementation/settings_repostiory_implementation.dart';
import '../../features/settings/domain/repostiory/settings_repostiory.dart';
import '../../features/settings/domain/use_case/get_company_info.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/sign_up/data/data_sources/remote_data_source.dart';
import '../../features/sign_up/data/repository_implementation/complete_profile_repository_implementation.dart';
import '../../features/sign_up/domain/repository/complete_profile_repository.dart';
import '../../features/sign_up/domain/use_case/get_all_universities.dart';
import '../../features/sign_up/domain/use_case/post_student_information.dart';
import '../../features/sign_up/presentation/bloc/completeprofile_bloc.dart';

import '../../features/choose_company/domain/use_case/get_companies_info.dart';
import '../../features/home/data/data_sources/remote_data_source.dart';
import '../../features/home/data/repository_implementation/map_repository_implementation.dart';
import '../../features/home/domain/repository/map_repository.dart';
import '../../features/home/domain/use_case/get_appoinments_of_pm.dart';
import '../../features/home/presentation/bloc/map/map_bloc.dart';
import '../../features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import '../../features/sign_up/domain/use_case/get_all_towns.dart';

GetIt di = GetIt.instance;
Future<void> init() async {
  final perfs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => perfs);

  di.registerFactory(() => LoginBloc());

  di.registerFactory(() => KeyboardBloc());

  di.registerLazySingleton(() => SendCodeVerification(di()));

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(di()));

  di.registerLazySingleton(() => Connectivity());

  di.registerFactory(() => CompanySelectionBloc(di()));
  di.registerLazySingleton(() => GetCompaniesInfo(di()));
  di.registerLazySingleton<CompanyRepository>(
      () => CompanyRepositoryImplementation(di(), di()));
  di.registerLazySingleton(() => CompaniesApiClient());

  di.registerFactory(() => CompleteprofileBloc(di(), di(), di()));
  di.registerLazySingleton(() => GetAllUniversities(di()));
  di.registerLazySingleton(() => GetAllTowns(di()));
  di.registerLazySingleton(() => PostStudentInformation(di()));
  di.registerLazySingleton<CompleteProfileRepository>(
      () => ComplelteProfileRepositoryImplemenation(di(), di()));
  di.registerLazySingleton(() => CompleteProfileApiClient());

  di.registerFactory(() => MapBloc(di(), di(), di(), di()));
  di.registerLazySingleton(() => GetAppoinmentOfAM(di()));
  di.registerLazySingleton(() => GetAppoinmentOfPM(di()));
  di.registerLazySingleton(() => GetMapPickUpPoints(di()));
  di.registerLazySingleton(() => GetMapDropOffPoints(di()));
  di.registerLazySingleton<MapRepository>(
      () => MapRepositoryImplementation(di(), di()));
  di.registerLazySingleton(() => MapApiClient());

  di.registerFactory(() => SettingsBloc(di(), di(), di()));
  di.registerLazySingleton(() => GetCompanyInfo(di()));
  di.registerLazySingleton<SettingsRepostiory>(
      () => SettingsRepostioryImplementation(di(), di()));
  di.registerLazySingleton(() => SettingsApiClient());
}
