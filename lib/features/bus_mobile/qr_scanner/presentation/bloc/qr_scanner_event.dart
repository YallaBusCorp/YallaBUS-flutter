part of 'qr_scanner_bloc.dart';

abstract class QrScannerEvent extends Equatable {
  const QrScannerEvent();

  @override
  List<Object> get props => [];
}

class CheckForQRCodeEvent extends QrScannerEvent {
  final String code;

  const CheckForQRCodeEvent(this.code);
}
