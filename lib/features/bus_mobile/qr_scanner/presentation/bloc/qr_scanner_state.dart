part of 'qr_scanner_bloc.dart';

abstract class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object> get props => [];
}

class QrScannerInitial extends QrScannerState {}

class InvalidQR extends QrScannerState {}
