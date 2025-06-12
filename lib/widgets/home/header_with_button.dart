import 'package:flutter/material.dart';

/// ویجت: هدر شامل عنوان "Products" و دکمه‌ی افزودن محصول
class HeaderWithButton extends StatelessWidget {
  final VoidCallback? onAddPressed;

  const HeaderWithButton({Key? key, this.onAddPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Products',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onAddPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add product'),
        ),
      ],
    );
  }
}
