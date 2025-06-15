// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import '../models/product.dart';
import '../screens/add_product_screen.dart';
import '../screens/details_screen.dart';
import '../widgets/home/search_bar_custom.dart';
import '../widgets/home/header_with_button.dart';
import '../widgets/home/product_card.dart';
import '../widgets/utils/app_spacing.dart';

/// صفحهٔ اصلی: نمایش لیست محصولات از SQLite
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final list = await DbHelper.getProducts();
    setState(() => products = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpacing.v12,
              SearchBarCustom(
                onTextChanged: (t) {},
                onFilterPressed: () {},
              ),
              AppSpacing.v24,
              HeaderWithButton(
                onAddPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const AddProductScreen()))
                      .then((_) => _loadProducts());
                },
              ),
              AppSpacing.v16,
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text('No products available'))
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => AppSpacing.v16,
                  itemBuilder: (ctx, i) {
                    final p = products[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => DetailsScreen(product: p)))
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
