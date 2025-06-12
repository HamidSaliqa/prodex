// lib/widgets/home/app_bar_custom.dart

import 'package:flutter/material.dart';

/// ویجت: اپ‌بار ساده با عنوان "Home"
PreferredSizeWidget buildAppBarCustom() {
  return AppBar(
    backgroundColor: const Color(0xFFF5F5F5),
    elevation: 0,
    centerTitle: false,
    title: const Text(
      'Home',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
