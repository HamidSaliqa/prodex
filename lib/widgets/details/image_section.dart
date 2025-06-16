// lib/widgets/details/image_section.dart

import 'dart:io';
import 'package:flutter/material.dart';

/// بخشی برای نمایش تصویر محصول در صفحهٔ جزئیات
/// اگر مسیر تصویر محلی موجود و فایل واقعی باشد، آن را نمایش می‌دهد
/// در غیر این صورت، یک placeholder نشان می‌دهد
class ImageSection extends StatelessWidget {
  final String imageUrl;

  const ImageSection({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // مسیر تصویر خالی نیست و فایل وجود دارد؟
    if (imageUrl.isNotEmpty) {
      final file = File(imageUrl);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            file,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      }
    }

    // اگر تصویر موجود نباشد یا فایل نیابد، placeholder
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}
