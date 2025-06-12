// lib/widgets/home/product_card.dart

import 'package:flutter/material.dart';
import '../../models/product.dart';

/// یک کارت کوچک برای نمایش اطلاعات پایهٔ محصول در HomeScreen
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // ------------------------------------------------------------
            // تصویر محصول (اگر imageUrl خالی باشد، Placeholder می‌زنیم)
            // ------------------------------------------------------------
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: product.imageUrl.isEmpty
                  ? const Center(
                child: Text(
                  'Photo',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(
                      child: Text(
                        'Photo',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // ------------------------------------------------------------
            // جزئیات محصول (نام، قیمت فروش، دسته‌بندی، تعداد و وضعیت)
            // ------------------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // نام و قیمت فروش (قرمز)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${product.sellingPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // دسته‌بندی
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // تعداد و وضعیت موجودی
                  Row(
                    children: [
                      Text(
                        'Qty: ${product.quantity}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: product.isAvailable
                              ? Colors.green
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.isAvailable
                              ? 'Available'
                              : 'Not Available',
                          style: TextStyle(
                            color: product.isAvailable
                                ? Colors.white
                                : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
