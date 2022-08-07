import '../../../../core/states/state.dart';
import 'package:dartz/dartz.dart';
import 'remote_data_source.dart';
import '../../../settings/data/model/settings_model_converters.dart';
import '../../../settings/domain/entity/ride_history_model.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../domain/repository/repostiory.dart';

class BusQrRepostioryImplementation extends BusQrRepository {
  final BusQrApiClient client;
  final NetworkInfo info;

  BusQrRepostioryImplementation(this.client, this.info);
  @override
  Future<Either<Failure, String>> scanQr(String qrCode, int busId) async {
    if (await info.isConnected()) {
      try {
        final result = await client.scanQr(qrCode, busId);
        return Right(result);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

 
}
