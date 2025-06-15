// lib/widgets/common/category_picker.dart

import 'package:flutter/material.dart';

/// ویجت انتخاب دسته‌بندی که BottomSheet را نمایش می‌دهد
class CategoryPicker extends StatelessWidget {
  final String? selected;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const CategoryPicker({
    Key? key,
    this.selected,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
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
                selected ?? 'Select category',
                style: TextStyle(
                  color: selected == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: options.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final option = options[i];
            return ListTile(
              title: Text(option),
              selected: option == selected,
              onTap: () {
                onSelected(option);
                Navigator.of(ctx).pop();
              },
            );
          },
        );
      },
    );
  }
}
