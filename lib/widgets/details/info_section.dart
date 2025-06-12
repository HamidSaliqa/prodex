// lib/widgets/details/info_section.dart

import 'package:flutter/material.dart';
import '../../models/product.dart';

/// ردیف ساده برای نمایش یک «تیتر» و «مقدار»
class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor; // اگر نیاز باشد مقدار رنگ متفاوت داشته باشد

  const InfoRow({
    Key? key,
    required this.title,
    required this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // عنوان در سمت چپ
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // مقدار در سمت راست (رنگ اختیاری)
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/// ویجت مجموعهٔ تیتر «Products Name» و ردیف‌های اطلاعات زیر آن
class InfoSection extends StatelessWidget {
  final Product product;

  const InfoSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------------------------------------
        // عنوان «Products Name» (درشت‌تر)
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // -----------------------------------------------------------------
        // Category
        InfoRow(
          title: 'Category',
          value: product.category,
        ),

        // Purchase price (رنگ مقدار را خاکستری روشن می‌کنیم)
        InfoRow(
          title: 'Purchase price',
          value: '\$${product.purchasePrice.toStringAsFixed(2)}',
          valueColor: Colors.grey,
        ),

        // Selling Price
        InfoRow(
          title: 'Selling Price',
          value: '\$${product.sellingPrice.toStringAsFixed(2)}',
          valueColor: Colors.grey,
        ),

        // Availability (اگر Available است سبز، در غیر این صورت قرمز)
        InfoRow(
          title: 'Availability',
          value: product.isAvailable ? 'Available' : 'Not Available',
          valueColor: product.isAvailable ? Colors.green : Colors.red,
        ),

        // Quantity (عدد)
        InfoRow(
          title: 'Quantity',
          value: product.quantity.toString(),
        ),

        // Weight (مقدار و واحد کیلوگرم)
        InfoRow(
          title: 'Weight',
          value: '${product.weight.toStringAsFixed(1)} kg',
        ),
      ],
    );
  }
}
