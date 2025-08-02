import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerViewfinder extends StatelessWidget {
  const ScannerViewfinder({
    required this.isScanned,
    required this.onBarcodeDetected,
    super.key,
  });

  final bool isScanned;
  final void Function(String barcode) onBarcodeDetected;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        if (isScanned) return;
        final barcode = capture.barcodes.firstOrNull?.rawValue;
        if (barcode != null) onBarcodeDetected(barcode);
      },
    );
  }
}
