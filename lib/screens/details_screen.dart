// lib/screens/details_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/details/image_section.dart';
import '../widgets/details/info_section.dart';
import '../widgets/details/action_buttons_section.dart';
import 'edit_product_screen.dart';

/// صفحهٔ «Details» که وقتی کاربر روی کارت محصول کلیک می‌کند اینجا نمایش داده می‌شود.
/// حالا با استفاده از LayoutBuilder و Flexible، بخش تصویر و محتوای متنی به صورت نسبتی از ارتفاع صفحه تنظیم شده‌اند تا روی صفحات کوچک از هم نریزند.
class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // اپ‌بار ساده با عنوان «Details»
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ارتفاع کل صفحه بدون اپ‌بار و SafeArea را داریم
            final totalHeight = constraints.maxHeight;

            return Column(
              children: [
                // ----------------------------------------------------
                // تصویر محصول: 30% از ارتفاع موجود
                // ----------------------------------------------------
                SizedBox(
                  height: totalHeight * 0.3,
                  width: double.infinity,
                  child: ImageSection(imageUrl: product.imageUrl),
                ),

                // ----------------------------------------------------
                // بقیهٔ محتوا (InfoSection و ActionButtonsSection) داخل Expanded و SingleChildScrollView
                // تا اگر محتوای متنی زیاد بود، اسکرول بخورد.
                // ----------------------------------------------------
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // بخش اطلاعات (تیتر و ردیف‌های info)
                          InfoSection(product: product),

                          const SizedBox(height: 32),

                          // دکمه‌های Delete / Edit
                          ActionButtonsSection(
                            onDelete: () {
                              // TODO: منطق حذف محصول را اینجا پیاده کنید
                            },
                            onEdit: () {
                              // TODO: مثلاً به صفحهٔ ویرایش هدایت شود.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditProductScreen(product: product),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
