import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kitchen/core/services/open_food_facts_service.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    on<BarcodeScanned>(_onBarcodeScanned);
  }

  final _openFoodFactsService = OpenFoodFactsService();

  Future<void> _onBarcodeScanned(
    BarcodeScanned event,
    Emitter<ScannerState> emit,
  ) async {
    emit(ScannerLoading());
    try {
      final apiProduct = await _openFoodFactsService.fetchProductByBarcode(
        event.barcode,
      );
      if (apiProduct == null) {
        emit(const ScannerFailure('Продукт не знайдено в базі OpenFoodFacts'));
        return;
      }

      final product = ProductModel.fromOpenFoodFacts(apiProduct);
      emit(
        ScannerSuccess(
          message: 'Продукт ${product.name} додано',
          product: apiProduct,
        ),
      );
    } catch (e) {
      emit(ScannerFailure('Помилка при скануванні штрихкоду: $e'));
    }
  }
}
