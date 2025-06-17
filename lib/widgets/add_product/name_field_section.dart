import 'package:flutter/material.dart';

/// بخش فیلد نام محصول با پشتیبانی از validator
class NameFieldSection extends StatelessWidget {
  final TextEditingController nameController;
  final String? Function(String?)? validator;

  const NameFieldSection({
    Key? key,
    required this.nameController,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Name',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: nameController,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter product name',
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
