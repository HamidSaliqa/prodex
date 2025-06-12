// lib/widgets/add_product/category_field_section.dart

import 'package:flutter/material.dart';

/// ویجت بخش «Category» (نمایش دسته‌بندی انتخاب‌شده و فراخوانی دیالوگ)
class CategoryFieldSection extends StatelessWidget {
  final String? selectedCategory;
  final VoidCallback onTap;

  const CategoryFieldSection({
    Key? key,
    required this.selectedCategory,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedCategory ?? 'Select category',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                      selectedCategory == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.grid_view, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
