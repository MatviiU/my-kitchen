part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable{
  const ScannerEvent();

  @override
  List<Object?> get props => [];
}

class BarcodeScanned extends ScannerEvent {
  const BarcodeScanned(this.barcode);

  final String barcode;

  @override
  List<Object?> get props => [barcode];
}
