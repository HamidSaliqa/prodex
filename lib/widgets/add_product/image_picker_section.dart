// lib/widgets/add_product/image_picker_section.dart

import 'package:flutter/material.dart';

/// ویجت بخش «Upload Image»
class ImagePickerSection extends StatelessWidget {
  final VoidCallback onTap;

  const ImagePickerSection({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: const Center(
          child: Text(
            'Upload Image',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
