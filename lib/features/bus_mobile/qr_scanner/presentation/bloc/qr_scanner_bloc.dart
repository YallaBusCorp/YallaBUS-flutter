import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../domain/repository/repostiory.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  bool isValidated = false;
  BusQrRepository repo;
  SharedPreferences perfs = di<SharedPreferences>();
  QrScannerBloc(this.repo) : super(QrScannerInitial()) {
    on<QrScannerEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CheckForQRCodeEvent>((event, emit) async {
      (await repo.scanQr(event.code, perfs.getInt(ConstantsManager.busId)!))
          .fold((l) {
        emit(QrScanError(l.message));
      }, (r) {
        emit(QrScanStatus(r));
      });
    });
    // on<QrValidationBasedOnDataFailedEvent>((event, emit) {
    //   emit(QrNotInProperDate());
    // });
  }
}
