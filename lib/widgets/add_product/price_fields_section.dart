// lib/widgets/add_product/price_fields_section.dart

import 'package:flutter/material.dart';

/// ویجت «فیلد قیمت» (کمکی) برای Purchase یا Selling
class PriceField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const PriceField({
    Key? key,
    required this.label,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }
}

/// ویجت «ردیف فیلدهای قیمت» شامل Purchase price و Selling Price
class PriceFieldsSection extends StatelessWidget {
  final TextEditingController purchaseController;
  final TextEditingController sellingController;

  const PriceFieldsSection({
    Key? key,
    required this.purchaseController,
    required this.sellingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PriceField(
            label: 'Purchase price',
            controller: purchaseController,
            hint: '\$0.00',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PriceField(
            label: 'Selling Price',
            controller: sellingController,
            hint: '\$0.00',
          ),
        ),
      ],
    );
  }
}
