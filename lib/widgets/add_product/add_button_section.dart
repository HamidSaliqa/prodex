// lib/widgets/add_product/add_button_section.dart

import 'package:flutter/material.dart';

/// ویجت بخش «Add» (دکمهٔ نهایی) با قابلیت غیرفعال شدن
class AddButtonSection extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddButtonSection({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null ? Colors.blue : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
