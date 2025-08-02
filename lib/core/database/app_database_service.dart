import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseService {
  static Database? _database;

  static const _dbName = 'my_kitchen.db';
  static const _dbVersion = 1;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT NOT NULL, 
            barcode TEXT NOT NULL, 
            addedDate TEXT NOT NULL, 
            expirationDate TEXT NOT NULL, 
            quantity REAL NOT NULL, 
            unit TEXT NOT NULL
          );
          ''');

    await db.execute('''
            CREATE TABLE IF NOT EXISTS recipes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            imagePath TEXT NOT NULL,
            ingredients TEXT NOT NULL,
            steps TEXT NOT NULL,
            tags TEXT NOT NULL
          );
          ''');
  }
}
