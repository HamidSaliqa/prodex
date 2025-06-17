// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../data/db_helper.dart';
import '../models/product.dart';
import '../widgets/home/search_bar_custom.dart';
import '../widgets/home/header_with_button.dart';
import '../widgets/home/product_card.dart';
import 'CustomerScreen.dart';
import 'add_product_screen.dart';
import 'details_screen.dart';

/// صفحهٔ اصلی با ConvexAppBarا
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;           // شاخص تب فعال
  List<Product> _products = [];     // لیست محصولات

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  /// بارگذاری محصولات از دیتابیس
  Future<void> _loadProducts() async {
    final list = await DbHelper.getProducts();
    setState(() => _products = list);
  }

  /// هندل سوییچ تب‌ها
  void _onTabTapped(int idx) {
    setState(() => _selectedIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    // صفحات را هر بار اینجا بساز تا پویا باشد
    final pages = <Widget>[
      _HomePageBody(
        products: _products,
        reload: _loadProducts,
      ),
      const CustomerScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],

      // نوار پایین ConvexAppBar با style.react
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.white,
        activeColor: Colors.blue,
        color: Colors.grey,
        elevation: 8,
        initialActiveIndex: _selectedIndex,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Customers'),
        ],
        onTap: _onTabTapped,
      ),
    );
  }
}

/// بدنهٔ صفحهٔ Home
class _HomePageBody extends StatelessWidget {
  final List<Product> products;
  final Future<void> Function() reload;

  const _HomePageBody({
    Key? key,
    required this.products,
    required this.reload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ۱) نوار جستجو
            SearchBarCustom(
              onTextChanged: (text) { /* TODO: فیلتر */ },
              onFilterPressed: () { /* TODO: فیلتر */ },
            ),
            const SizedBox(height: 24),

            // ۲) هدر با دکمه Add
            HeaderWithButton(
              onAddPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(builder: (_) => const AddProductScreen()),
                )
                    .then((_) => reload());
              },
            ),
            const SizedBox(height: 16),

            // ۳) لیست محصولات
            Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('No products available'))
                  : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (ctx, i) {
                  final p = products[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(product: p),
                        ),
                      )
                          .then((_) => reload());
                    },
                    child: ProductCard(product: p),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
