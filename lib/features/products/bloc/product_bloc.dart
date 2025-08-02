import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kitchen/features/products/data/sqlite_products_repository.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

part 'product_state.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<LoadProductsEvent>(_loadProducts);
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<UpdateProductEvent>(_updateProduct);
    on<AddScannedProduct>(_addScannedProduct);
    on<ToggleProductSelectionEvent>((event, emit) {
      final current = state.selectedIds;
      final newSet = Set<int>.from(current);
      if (newSet.contains(event.productId)) {
        newSet.remove(event.productId);
      } else {
        newSet.add(event.productId);
      }
      emit(state.copyWith(selectedIds: newSet));
    });
  }

  final productRepository = SqliteProductsRepository();

  Future<void> _loadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await productRepository.getAllProducts();
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _addProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final currentProducts = state.products;
      final exists = currentProducts.any(
        (product) => product.barcode == event.product.barcode,
      );
      if (exists) {
        emit(state.copyWith(error: 'Продукт вже існує', isLoading: false));
        return;
      }
      await productRepository.insertProduct(event.product);
      final updatedProducts = List<ProductModel>.from(state.products)
        ..add(event.product);
      emit(state.copyWith(products: updatedProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _addScannedProduct(
    AddScannedProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final model = ProductModel.fromOpenFoodFacts(event.product);
      await productRepository.insertScannedProduct(model);
      final updatedProducts = List<ProductModel>.from(state.products)
        ..add(model);
      emit(state.copyWith(products: updatedProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _deleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await productRepository.deleteProduct(event.id);
      final updatedProducts = state.products
          .where((product) => product.id != event.id)
          .toList();
      emit(state.copyWith(products: updatedProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _updateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await productRepository.updateProduct(event.product);
      final updatedProducts = state.products.map((product) {
        return product.id == event.product.id ? event.product : product;
      }).toList();
      emit(state.copyWith(products: updatedProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
