// lib/widgets/add_product/image_picker_section.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// ویجتی برای انتخاب و نمایش تصویر محصول
/// - onImageSelected: دریافت مسیر نهایی فایل ذخیره‌شده
/// - imagePath: مسیر فعلی تصویر (برای نمایش پیش‌نمایش)
class ImagePickerSection extends StatelessWidget {
  final ValueChanged<String> onImageSelected;
  final String? imagePath;

  const ImagePickerSection({
    Key? key,
    required this.onImageSelected,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // انتخاب تصویر از گالری
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked == null) return;

        // کپی فایل موقت به حافظهٔ داخلی برنامه
        final tempFile = File(picked.path);
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = picked.name;
        final savedFile = await tempFile.copy('${appDir.path}/$fileName');

        // بازگشت مسیر فایل ذخیره‌شده
        onImageSelected(savedFile.path);
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: imagePath == null
              ? const Text(
            'Upload Image',
            style: TextStyle(color: Colors.grey),
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(imagePath!),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
