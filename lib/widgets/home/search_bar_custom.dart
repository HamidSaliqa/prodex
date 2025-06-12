// lib/widgets/home/search_bar_custom.dart

import 'package:flutter/material.dart';

/// ویجت: نوار جستجو با آیکون جستجو و فیلتر
class SearchBarCustom extends StatelessWidget {
  /// وقتی متن وارد می‌شود این callback فراخوانی می‌شود
  final ValueChanged<String>? onTextChanged;

  /// وقتی آیکون فیلتر زده شود این callback فراخوانی می‌شود
  final VoidCallback? onFilterPressed;

  const SearchBarCustom({
    Key? key,
    this.onTextChanged,
    this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onTextChanged,
              decoration: const InputDecoration(
                hintText: 'Search products',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            onPressed: onFilterPressed,
            icon: const Icon(Icons.filter_list, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
