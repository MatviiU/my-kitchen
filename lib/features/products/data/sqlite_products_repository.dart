import 'package:my_kitchen/core/database/app_database_service.dart';
import 'package:my_kitchen/features/products/data/products_repository.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteProductsRepository implements ProductsRepository {
  static const _tableName = 'products';

  @override
  Future<void> deleteProduct(int id) async {
    final db = await AppDatabaseService.database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final db = await AppDatabaseService.database;
    final maps = await db.query(_tableName);
    return maps.map(ProductModel.fromDb).toList();
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    final db = await AppDatabaseService.database;
    await db.insert(
      _tableName,
      product.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final db = await AppDatabaseService.database;
    await db.update(
      _tableName,
      product.toDb(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<void> insertScannedProduct(ProductModel product) async {
    final db = await AppDatabaseService.database;

    await db.insert(
      _tableName,
      product.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
