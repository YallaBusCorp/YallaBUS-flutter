import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yalla_bus/features/bus_mobile/qr_scanner/presentation/pages/border_painter.dart';

class BusQRScanner extends StatefulWidget {
  const BusQRScanner({Key? key}) : super(key: key);

  @override
  State<BusQRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<BusQRScanner> {
  late String code = "Loading ...";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Qr',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                setState(() {
                  code = barcode.rawValue!;
                });
                debugPrint('Barcode found! $code');
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  code,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
