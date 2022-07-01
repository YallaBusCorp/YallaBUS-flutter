part of 'qr_scanner_bloc.dart';

abstract class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object> get props => [];
}

class QrScannerInitial extends QrScannerState {}

class InvalidQR extends QrScannerState {}

class QrScanError extends QrScannerState {
  final String message;

  const QrScanError(this.message);
}

class QrScanStatus extends QrScannerState {
  final String status;
  final String code;
  const QrScanStatus(this.status,this.code);
  @override
  List<Object> get props => [status,code];
}

class QrNotInProperDate extends QrScannerState {}
