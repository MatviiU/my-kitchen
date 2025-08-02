import 'package:openfoodfacts/openfoodfacts.dart';

class ProductModel {
  const ProductModel({
    required this.name,
    required this.barcode,
    required this.addedDate,
    required this.expirationDate,
    required this.quantity,
    required this.unit,
    this.id,
  });

  factory ProductModel.fromDb(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      addedDate: map['addedDate'] as String,
      expirationDate: map['expirationDate'] as String,
      quantity: map['quantity'] as double,
      unit: map['unit'] as String,
    );
  }

  factory ProductModel.fromOpenFoodFacts(Product product) {
    return ProductModel(
      id: null,
      name: product.productName ?? 'Невідомо',
      barcode: product.barcode ?? '---',
      quantity: 1,
      unit: 'шт',
      addedDate: DateTime.now().toIso8601String(),
      expirationDate:
          product.expirationDate ?? DateTime.now().toIso8601String(),
    );
  }

  final int? id;
  final String name;
  final String barcode;
  final String addedDate;
  final String expirationDate;
  final double quantity;
  final String unit;

  Map<String, dynamic> toDb() => {
    'id': id,
    'name': name,
    'barcode': barcode,
    'addedDate': addedDate,
    'expirationDate': expirationDate,
    'quantity': quantity,
    'unit': unit,
  };
}
