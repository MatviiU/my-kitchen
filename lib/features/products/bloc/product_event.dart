part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  const AddProductEvent(this.product);

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  const DeleteProductEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  const UpdateProductEvent(this.product);

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class ToggleProductSelectionEvent extends ProductEvent {
  const ToggleProductSelectionEvent(this.productId);

  final int productId;

  @override
  List<Object?> get props => [productId];
}

class AddScannedProduct extends ProductEvent {
  const AddScannedProduct(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}
