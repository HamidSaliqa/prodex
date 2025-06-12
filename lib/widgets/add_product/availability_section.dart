// lib/widgets/add_product/availability_section.dart

import 'package:flutter/material.dart';

/// ویجت بخش «Availability»
/// isAvailable: وضعیت فعلی
/// onChanged: تابعی که هنگام تغییر فراخوانی شود (پارامتر: true یا false)
class AvailabilitySection extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onChanged;

  const AvailabilitySection({
    Key? key,
    required this.isAvailable,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Availability',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // دکمه Available
            Expanded(
              child: ElevatedButton(
                onPressed: () => onChanged(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAvailable ? Colors.green : Colors.white,
                  side: BorderSide(
                      color: isAvailable ? Colors.green : Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Available',
                  style: TextStyle(
                    color: isAvailable ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // دکمه Not Available
            Expanded(
              child: ElevatedButton(
                onPressed: () => onChanged(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isAvailable
                      ? Colors.red.shade50
                      : Colors.white,
                  side: BorderSide(
                      color: !isAvailable ? Colors.red : Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Not Available',
                  style: TextStyle(
                    color: !isAvailable ? Colors.red : Colors.black,
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
