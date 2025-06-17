import 'package:flutter/material.dart';

/// بخش فیلدهای قیمت خرید و فروش با پشتیبانی از validator
class PriceFieldsSection extends StatelessWidget {
  final TextEditingController purchaseController;
  final TextEditingController sellingController;
  final String? Function(String?)? purchaseValidator;
  final String? Function(String?)? sellingValidator;

  const PriceFieldsSection({
    Key? key,
    required this.purchaseController,
    required this.sellingController,
    this.purchaseValidator,
    this.sellingValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildPriceField(
          label: 'Purchase Price',
          controller: purchaseController,
          hint: '0.00',
          validator: purchaseValidator,
        )),
        const SizedBox(width: 16),
        Expanded(child: _buildPriceField(
          label: 'Selling Price',
          controller: sellingController,
          hint: '0.00',
          validator: sellingValidator,
        )),
      ],
    );
  }

  Widget _buildPriceField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
