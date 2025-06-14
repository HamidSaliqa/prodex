// lib/screens/details_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/details/image_section.dart';
import '../widgets/details/info_section.dart';
import '../widgets/details/action_buttons_section.dart';
import 'edit_product_screen.dart';

/// صفحهٔ جزئیات محصول؛ شامل منطق حذف و ویرایش با نشانگر لودینگ
class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  Future<void> _handleDelete(BuildContext context) async {
    // نمایش دیالوگ لودینگ
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    // حذف از دیتابیس
    await DbHelper.deleteProduct(product.id!);
    // بستن دیالوگ و صفحهٔ Details
    Navigator.of(context).pop(); // دیالوگ
    Navigator.of(context).pop(); // DetailsScreen
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
            final totalHeight = constraints.maxHeight;
            return Column(
              children: [
                SizedBox(
                  height: totalHeight * 0.3,
                  width: double.infinity,
                  child: ImageSection(imageUrl: product.imageUrl),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InfoSection(product: product),
                          const SizedBox(height: 32),
                          ActionButtonsSection(
                            onDelete: () => _handleDelete(context),
                            onEdit: () {
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
