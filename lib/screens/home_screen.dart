// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:prodex/data/db_helper.dart';
import 'package:prodex/models/product.dart';
import 'package:prodex/screens/add_product_screen.dart';
import 'package:prodex/screens/details_screen.dart';
import 'package:prodex/widgets/home/search_bar_custom.dart';
import 'package:prodex/widgets/home/header_with_button.dart';
import 'package:prodex/widgets/home/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    // ← از کلاس DbHelper و متد getProducts استفاده کن
    final list = await DbHelper.getProducts();
    setState(() => products = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              SearchBarCustom(
                onTextChanged: (text) { /* TODO */ },
                onFilterPressed: () { /* TODO */ },
              ),
              const SizedBox(height: 24),
              HeaderWithButton(
                onAddPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (_) => const AddProductScreen(),
                  ))
                      .then((_) => _loadProducts());
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text('No products available'))
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 16),
                  itemBuilder: (ctx, i) {
                    final p = products[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(product: p),
                        ))
                            .then((_) => _loadProducts());
                      },
                      child: ProductCard(product: p),
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
