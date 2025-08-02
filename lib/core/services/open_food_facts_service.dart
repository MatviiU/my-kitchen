import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsService {
  static const _user = User(userId: 'off', password: 'off');

  /// Повертає [Product] або null, якщо не знайдено або сталася помилка
  Future<Product?> fetchProductByBarcode(String barcode) async {
    final configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.UKRAINIAN,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );

    try {
      final result = await OpenFoodAPIClient.getProductV3(
        configuration,
        user: _user,
      );

      if (result.status == ProductResultV3.statusSuccess &&
          result.product != null) {
        return result.product;
      }
    } catch (e) {
      throw Exception('Помилка під час отримання продукту: $e');
    }
    return null;
  }
}
