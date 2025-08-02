
import 'package:my_kitchen/features/products/domain/product_model.dart';

abstract class ProductsRepository {
  Future<void> insertProduct(ProductModel product);

  Future<List<ProductModel>> getAllProducts();

  Future<void> deleteProduct(int id);

  Future<void> updateProduct(ProductModel product);

  Future<void> insertScannedProduct(ProductModel product);
}
