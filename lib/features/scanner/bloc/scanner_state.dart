part of 'scanner_bloc.dart';

class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerSuccess extends ScannerState {
  const ScannerSuccess({required this.product, required this.message});

  final String message;
  final Product product;

  @override
  List<Object?> get props => [message];
}

class ScannerFailure extends ScannerState {
  const ScannerFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
