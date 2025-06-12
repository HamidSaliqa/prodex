// lib/widgets/add_product/unit_type_section.dart

import 'package:flutter/material.dart';

/// ویجت بخش «Unit Type»
/// isQuantity: true = Quantity، false = Weight
/// onChanged: تابعی که با انتخاب هرکدام فراخوانی می‌شود (پارامتر: true یا false)
class UnitTypeSection extends StatelessWidget {
  final bool isQuantity;
  final ValueChanged<bool> onChanged;

  const UnitTypeSection({
    Key? key,
    required this.isQuantity,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Unit Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // دکمه Quantity
            Expanded(
              child: ElevatedButton(
                onPressed: () => onChanged(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isQuantity ? Colors.blue : Colors.grey.shade200,
                  side: BorderSide(
                      color: isQuantity ? Colors.blue : Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Quantity',
                  style: TextStyle(
                    color: isQuantity ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // دکمه Weight
            Expanded(
              child: ElevatedButton(
                onPressed: () => onChanged(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  !isQuantity ? Colors.blue : Colors.grey.shade200,
                  side: BorderSide(
                      color: !isQuantity ? Colors.blue : Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Weight',
                  style: TextStyle(
                    color: !isQuantity ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
