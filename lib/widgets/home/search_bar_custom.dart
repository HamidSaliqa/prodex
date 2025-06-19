import 'package:flutter/material.dart';

/// یک نوار جست‌وجوی ساده با فیلتر
class SearchBarCustom extends StatelessWidget {
  final ValueChanged<String> onTextChanged;
  final VoidCallback onFilterPressed;
  final String hintText;        // ← اضافه شد

  const SearchBarCustom({
    Key? key,
    required this.onTextChanged,
    required this.onFilterPressed,
    this.hintText = 'Search',    // ← مقدار پیش‌فرض
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onTextChanged,
              decoration: InputDecoration(
                hintText: hintText,        // ← اینجا استفاده می‌شود
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            onPressed: onFilterPressed,
          ),
        ],
      ),
    );
  }
}
