import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../bloc/qr_scanner_bloc.dart';
import 'border_painter.dart';
import '../widgets/unsuccessful_dialog.dart';

import '../../../../../core/custom_widgets/success_dialog.dart';
import '../../../../../core/extensions/extensions.dart';

class BusQRScanner extends StatefulWidget {
  const BusQRScanner({Key? key}) : super(key: key);

  @override
  State<BusQRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<BusQRScanner> {
  late QrScannerBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<QrScannerBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Qr',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: BlocConsumer<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state is QrScanStatus) {
            if (state.status == 'Valid QR Code') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                  });
                  Vibration.vibrate();
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: SuccessDialog(
                      message: state.status,
                    ),
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                  });
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: InvalidDialog(
                      message: state.status,
                    ),
                  );
                },
              );
            }
          }
          if (state is QrScanError) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: ErrorDialog(message: state.message, onTap: () {}),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MobileScanner(
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    setState(() {
                      bloc.add(CheckForQRCodeEvent(barcode.rawValue!));
                    });
                    debugPrint('Barcode found! ${barcode.rawValue!}');
                  }
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: 0.2,
                            child: Container(
                              width: 100,
                              height: 300,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomPaint(
                            painter: BorderPainter(),
                            child: Container(
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Opacity(
                            opacity: 0.2,
                            child: Container(
                              width: 100,
                              height: 300,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
