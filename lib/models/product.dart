// lib/models/product.dart

class Product {
  final int? id;            // → اضافه می‌کنیم تا SQLite بتونه PK ذخیره کنه
  final String name;
  final String category;
  final double purchasePrice;
  final double sellingPrice;
  final bool isAvailable;
  final int quantity;
  final double weight;
  final String imageUrl;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.isAvailable,
    required this.quantity,
    required this.weight,
    required this.imageUrl,
  });

  /// تبدیل شیء به Map برای درج/به‌روز‌رسانی در دیتابیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'isAvailable': isAvailable ? 1 : 0,
      'quantity': quantity,
      'weight': weight,
      'imageUrl': imageUrl,
    };
  }

  /// ساخت یک شیء Product از Map دریافتی از دیتابیس
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      purchasePrice: map['purchasePrice'] as double,
      sellingPrice: map['sellingPrice'] as double,
      isAvailable: (map['isAvailable'] as int) == 1,
      quantity: map['quantity'] as int,
      weight: map['weight'] as double,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
