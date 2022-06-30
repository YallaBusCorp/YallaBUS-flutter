import 'package:dartz/dartz.dart';

import '../../../../../core/states/state.dart';

abstract class BusQrRepository {
  Future<Either<Failure, String>> scanQr(String qrCode, int busId);
}
