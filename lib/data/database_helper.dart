// lib/data/db_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DbHelper {
  /// باز کردن دیتابیس یا ساخت جدید اگر وجود نداشته باشد
  static Future<Database> db() async {
    final path = join(await getDatabasesPath(), 'prodex.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            purchasePrice REAL NOT NULL,
            sellingPrice REAL NOT NULL,
            isAvailable INTEGER NOT NULL,
            quantity INTEGER NOT NULL,
            weight REAL NOT NULL,
            imageUrl TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// درج محصول جدید
  static Future<int> addProduct(Product p) async {
    final database = await db();
    return database.insert(
      'products',
      p.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// ویرایش محصول موجود
  static Future<int> editProduct(Product p) async {
    final database = await db();
    return database.update(
      'products',
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
  }

  /// حذف محصول
  static Future<int> deleteProduct(int id) async {
    final database = await db();
    return database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// نمایش همهٔ محصولات
  static Future<List<Product>> getProducts() async {
    final database = await db();
    final maps = await database.query('products');
    return maps.map((m) => Product.fromMap(m)).toList();
  }
}
