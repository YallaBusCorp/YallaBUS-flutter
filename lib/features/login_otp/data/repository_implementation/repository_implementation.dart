import 'package:yalla_bus/core/states/state.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/login_otp/data/remote_data_source/login_remote_data_source.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/repository.dart';

class LoginRepositoryImplementation extends LoginRepository {
  final LoginApiClient client;
  final NetworkInfo info;
  LoginRepositoryImplementation(this.client, this.info);
 
}
