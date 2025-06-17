import 'package:flutter/material.dart';

/// فیلد ورودی Quantity یا Weight با پشتیبانی از validator
class QuantityWeightField extends StatelessWidget {
  final bool isQuantity;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const QuantityWeightField({
    Key? key,
    required this.isQuantity,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isQuantity ? 'Quantity' : 'Weight',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: isQuantity ? 'Enter quantity' : 'Enter weight',
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
