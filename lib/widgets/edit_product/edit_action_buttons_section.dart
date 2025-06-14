import 'package:flutter/material.dart';

/// ویجت دکمه‌های انتهای صفحهٔ Edit: «Cancel» و «Update»
class EditActionButtonsSection extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback? onUpdate;

  const EditActionButtonsSection({
    Key? key,
    required this.onCancel,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ---------------------------------------------------------------
        // دکمه Cancel (سفید با متن مشکی)
        // ---------------------------------------------------------------
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // ---------------------------------------------------------------
        // دکمه Update (آبی با متن سفید)
        // ---------------------------------------------------------------
        Expanded(
          child: ElevatedButton(
            onPressed: onUpdate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
