import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/bus_mobile/employee_code/domain/remote_data_source.dart';
import '../../features/bus_mobile/employee_code/domain/repostiory.dart';
import '../../features/bus_mobile/employee_code/presentation/bloc/employee_code_bloc.dart';
import '../../features/bus_mobile/map/api/all_coordinates.dart';
import '../../features/bus_mobile/map/api/remote_data_source.dart';
import '../../features/bus_mobile/map/api/repostiory.dart';
import '../../features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';
import '../../features/bus_mobile/qr_scanner/data/remote_data_source.dart';
import '../../features/bus_mobile/qr_scanner/data/repostiory_implementation.dart';
import '../../features/bus_mobile/qr_scanner/domain/repository/repostiory.dart';
import '../../features/bus_mobile/qr_scanner/presentation/bloc/qr_scanner_bloc.dart';
import '../../features/bus_mobile/rides/data/remote_data_source.dart';
import '../../features/bus_mobile/rides/data/repostiory_implementation.dart';
import '../../features/bus_mobile/rides/data/send_notification.dart';
import '../../features/bus_mobile/rides/presentation/bloc/bus_ride_bloc.dart';
import '../../features/home/domain/use_case/book_ride.dart';
import '../../features/home/domain/use_case/cancel_ride.dart';
import '../../features/home/domain/use_case/get_current_ride.dart';
import '../../features/home/domain/use_case/reschedule_ride.dart';
import '../../features/home/presentation/bloc/ride_booked/ride_booked_bloc.dart';
import '../../features/home/presentation/bloc/ride_booking/ride_booking_bloc.dart';
import '../../features/login_otp/data/remote_data_source/login_remote_data_source.dart';
import '../../features/login_otp/data/repository_implementation/repository_implementation.dart';
import '../../features/login_otp/domain/repository/repository.dart';
import '../../features/settings/domain/use_case/get_non_scanned_rides.dart';
import '../../features/settings/domain/use_case/get_scanned_rides.dart';
import '../../features/settings/domain/use_case/update_student.dart';
import '../../features/home/domain/use_case/get_student_id.dart';
import '../network/network_info.dart';
import '../../features/choose_company/data/data_sources/remote_data_source.dart';
import '../../features/choose_company/data/repository_implementation/company_repository_implementation.dart';
import '../../features/choose_company/domain/repository/company_repository.dart';
import '../../features/choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../features/home/domain/use_case/get_appoinments_of_am.dart';
import '../../features/home/domain/use_case/get_map_drop_off_points.dart';
import '../../features/home/domain/use_case/get_map_pick_up_points.dart';
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

  di.registerFactory(() => LoginBloc(di()));

  di.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImplementation(di(), di()));
  di.registerLazySingleton(() => LoginApiClient());

  di.registerFactory(() => KeyboardBloc());

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(di()));

  di.registerLazySingleton(() => Connectivity());

  di.registerFactory(() => CompanySelectionBloc(di()));
  di.registerLazySingleton(() => GetCompaniesInfo(di()));
  di.registerLazySingleton<CompanyRepository>(
      () => CompanyRepositoryImplementation(di(), di()));
  di.registerLazySingleton(() => CompaniesApiClient());

  di.registerFactory(() => CompleteprofileBloc(di(), di(), di(), di()));

  di.registerLazySingleton(() => GetAllUniversities(di()));
  di.registerLazySingleton(() => GetAllTowns(di()));
  di.registerLazySingleton(() => PostStudentInformation(di()));

  di.registerLazySingleton<CompleteProfileRepository>(
      () => ComplelteProfileRepositoryImplemenation(di(), di()));
  di.registerLazySingleton(() => CompleteProfileApiClient());

  di.registerFactory(() => MapBloc(
        di(),
        di(),
      ));
  di.registerFactory(() => RideBookedBloc(
        di(),
        di(),
        di(),
      ));
  di.registerFactory(() => RideBookingBloc(
        di(),
        di(),
        di(),
        di(),
      ));
  di.registerLazySingleton(() => GetCurrentRide(di()));
  di.registerLazySingleton(() => CancelRide(di()));
  di.registerLazySingleton(() => GetAppoinmentOfAM(di()));
  di.registerLazySingleton(() => GetAppoinmentOfPM(di()));
  di.registerLazySingleton(() => GetMapPickUpPoints(di()));
  di.registerLazySingleton(() => GetMapDropOffPoints(di()));
  di.registerLazySingleton(() => BookRide(di()));
  di.registerLazySingleton(() => GetStudentId(di()));
  di.registerLazySingleton(() => RescheduleRide(di()));
  di.registerLazySingleton<MapRepository>(
      () => MapRepositoryImplementation(di(), di()));
  di.registerLazySingleton(() => MapApiClient());

  di.registerFactory(() => SettingsBloc(di(), di(), di(), di(), di(), di()));

  di.registerLazySingleton(() => GetCompanyInfo(di()));
  di.registerLazySingleton(() => GetNonScannedRides(di()));
  di.registerLazySingleton(() => GetScannedRides(di()));
  di.registerLazySingleton(() => UpdateStudentInfo(di()));
  di.registerLazySingleton<SettingsRepostiory>(
      () => SettingsRepostioryImplementation(di(), di()));
  di.registerLazySingleton(() => SettingsApiClient());

  di.registerFactory(() => QrScannerBloc(di()));

  di.registerLazySingleton<BusQrRepository>(
      () => BusQrRepostioryImplementation(di(), di()));

  di.registerLazySingleton(() => BusQrApiClient());

  di.registerFactory(() => EmployeeCodeBloc(di()));

  di.registerLazySingleton(() => EmployeeCodeRepository(di(), di()));
  di.registerLazySingleton(() => EmployeeApiClient());

  di.registerFactory(() => BusRideBloc(di(), di()));

  di.registerLazySingleton(() => BusRideRepostiory(di(), di()));
  di.registerLazySingleton(() => BusRideApiClient());
  di.registerLazySingleton(() => SendNotificationApiClient());

  di.registerFactory(() => BusMapBloc(di()));
  di.registerLazySingleton(() => BusMapRepository(di(), di()));
  di.registerLazySingleton(() => BusMapApiClient());
}
