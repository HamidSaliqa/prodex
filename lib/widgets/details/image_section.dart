// lib/widgets/details/image_section.dart

import 'package:flutter/material.dart';

/// ویجت «بخش تصویر» در صفحه جزئیات
/// نمایش تصویر از روی یک URL یا Asset
class ImageSection extends StatelessWidget {
  final String imageUrl;

  const ImageSection({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      clipBehavior: Clip.hardEdge,
      child: imageUrl.isEmpty
          ? const Center(
        child: Text(
          'Image',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // اگر بارگذاری تصویر شکست خورد، متن جایگزین نشان داده شود
          return const Center(
            child: Text(
              'Image',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
