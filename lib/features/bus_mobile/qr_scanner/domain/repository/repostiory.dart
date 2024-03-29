import 'package:dartz/dartz.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';

import '../../../../../core/states/state.dart';

abstract class BusQrRepository {
  Future<Either<Failure, String>> scanQr(String qrCode, int busId);
}
