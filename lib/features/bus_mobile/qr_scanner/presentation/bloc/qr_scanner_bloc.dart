import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  bool isValidated = false;
  QrScannerBloc() : super(QrScannerInitial()) {
    on<QrScannerEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CheckForQRCodeEvent>((event, emit) {
      String dateFromQr = event.code.split('/').first;
      String dateOfRide =
          StringsExtensions.convertHourTo12HoursOnly('18:00:00');
      isValidated = dateFromQr == dateOfRide;
      if (!isValidated) {
        emit(InvalidQR());
      }
    });
  }
}
