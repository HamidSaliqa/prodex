// lib/screens/details_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/details/info_section.dart';
import '../widgets/details/image_section.dart';
import '../widgets/utils/app_spacing.dart';
import 'edit_product_screen.dart';

/// صفحهٔ جزئیات محصول؛ شامل نمایش تصویر، اطلاعات و دکمه‌های Delete/Edit
class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  Future<void> _handleDelete(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await DbHelper.deleteProduct(product.id!);
    Navigator.of(context).pop(); // بستن دیالوگ
    Navigator.of(context).pop(); // بستن DetailsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final totalHeight = constraints.maxHeight;
            return Column(
              children: [
                // تصویر محصول (30% ارتفاع)
                SizedBox(
                  height: totalHeight * 0.3,
                  width: double.infinity,
                  child: ImageSection(imageUrl: product.imageUrl),
                ),
                // اطلاعات و دکمه‌ها
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InfoSection(product: product),
                          AppSpacing.v32,
                          PrimaryButton(
                            label: 'Delete',
                            onPressed: () => _handleDelete(context),
                          ),
                          AppSpacing.v16,
                          PrimaryButton(
                            label: 'Edit',
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditProductScreen(product: product),
                                ),
                              )
                                  .then((_) => Navigator.of(context).pop());
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
