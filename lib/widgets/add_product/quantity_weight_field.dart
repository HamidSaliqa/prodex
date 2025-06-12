// lib/widgets/add_product/quantity_weight_field.dart

import 'package:flutter/material.dart';

/// ویجت فیلد «Quantity یا Weight»
/// isQuantity: اگر true باشد، متن hint «Quantity» وگرنه «Weight» نمایش داده می‌شود.
/// controller: کنترلر مربوط به TextField
class QuantityWeightField extends StatelessWidget {
  final bool isQuantity;
  final TextEditingController controller;

  const QuantityWeightField({
    Key? key,
    required this.isQuantity,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: isQuantity ? 'Quantity' : 'Weight',
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
      ),
    );
  }
}
