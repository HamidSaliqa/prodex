// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:prodex/screens/add_product_screen.dart';
import '../models/product.dart';
import '../widgets/home/search_bar_custom.dart';
import '../widgets/home/header_with_button.dart';
import '../widgets/home/product_card.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  /// تابعی که لیستی از محصولات ساختگی با فیلدهای مدل Product را برمی‌گرداند
  List<Product> getDummyProducts() {
    return [
      Product(
        name: 'Apple iPhone 13',
        category: 'Electronics',
        purchasePrice: 700.00,
        sellingPrice: 799.00,
        isAvailable: true,
        quantity: 20,
        weight: 0.174,
        imageUrl: '',
      ),
      Product(
        name: 'Nike Running Shoes',
        category: 'Clothing',
        purchasePrice: 60.00,
        sellingPrice: 99.00,
        isAvailable: false,
        quantity: 0,
        weight: 0.8,
        imageUrl: '',
      ),
      Product(
        name: 'Organic Bananas',
        category: 'Food',
        purchasePrice: 1.20,
        sellingPrice: 1.50,
        isAvailable: true,
        quantity: 150,
        weight: 0.14,
        imageUrl: '',
      ),
      Product(
        name: 'The Alchemist (Book)',
        category: 'Books',
        purchasePrice: 5.00,
        sellingPrice: 9.99,
        isAvailable: true,
        quantity: 45,
        weight: 0.3,
        imageUrl: '',
      ),
      Product(
        name: 'Football',
        category: 'Sports',
        purchasePrice: 10.00,
        sellingPrice: 19.99,
        isAvailable: false,
        quantity: 0,
        weight: 0.45,
        imageUrl: '',
      ),
      Product(
        name: 'Sony Headphones',
        category: 'Electronics',
        purchasePrice: 80.00,
        sellingPrice: 119.99,
        isAvailable: true,
        quantity: 12,
        weight: 0.25,
        imageUrl: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final products = getDummyProducts();

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // -------------------------------------------------------
              // نوار جستجو
              // (از widget: widgets/home/search_bar_custom.dart)
              // -------------------------------------------------------
              SearchBarCustom(
                onTextChanged: (text) {
                  // TODO: اعمال فیلتر بر اساس متن
                },
                onFilterPressed: () {
                  // TODO: نمایش صفحه یا دیالوگ فیلتر
                },
              ),

              const SizedBox(height: 24),

              // -------------------------------------------------------
              // هدر با دکمه‌ی «+ Add product»
              // (از widget: widgets/home/header_with_button.dart)
              // -------------------------------------------------------
              HeaderWithButton(
                onAddPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AddProductScreen(),
                    ),
                  );
                },
              ),


              const SizedBox(height: 16),

              // -------------------------------------------------------
              // لیست محصولات
              // -------------------------------------------------------
              Expanded(
                child: ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(product: product),
                          ),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
