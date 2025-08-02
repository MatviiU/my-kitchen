part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    this.products = const [],
    this.selectedIds = const {},
    this.isLoading = false,
    this.error,
  });

  final List<ProductModel> products;
  final Set<int> selectedIds;
  final bool? isLoading;
  final String? error;

  ProductState copyWith({
    List<ProductModel>? products,
    Set<int>? selectedIds,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      selectedIds: selectedIds ?? this.selectedIds,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [products, selectedIds, isLoading, error];
}
