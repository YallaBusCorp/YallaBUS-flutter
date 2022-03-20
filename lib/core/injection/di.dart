import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.instance;
Future<void> init() async {
  final perfs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => perfs);
}
