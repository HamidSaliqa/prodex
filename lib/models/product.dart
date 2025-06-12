// lib/models/product.dart

/// مدل داده‌ای برای نمایش و جابجایی اطلاعات محصول در اپ
class Product {
  /// نام محصول
  final String name;

  /// دسته‌بندی محصول
  final String category;

  /// قیمت خرید (Purchase Price)
  final double purchasePrice;

  /// قیمت فروش (Selling Price)
  final double sellingPrice;

  /// وضعیت موجودی: true = Available، false = Not Available
  final bool isAvailable;

  /// تعداد موجود (Quantity)
  final int quantity;

  /// وزن محصول (به کیلوگرم)
  final double weight;

  /// آدرس یا مسیر تصویر محصول (می‌تواند URL یا مسیر asset باشد)
  final String imageUrl;

  /// سازنده‌ی کلاس با مقداردهی همهٔ فیلدها
  Product({
    required this.name,
    required this.category,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.isAvailable,
    required this.quantity,
    required this.weight,
    required this.imageUrl,
  });
}
