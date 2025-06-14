// lib/screens/add_product_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/add_product/add_button_section.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/category_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';

/// صفحه‌ای برای افزودن محصول جدید (قابل اسکرول و با قابلیت انتخاب Quantity/Weight)
/// همراه با لودینگ تمام‌صفحه هنگام ذخیره
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // کنترلرهای فیلدها
  final TextEditingController _nameController           = TextEditingController();
  final TextEditingController _purchasePriceController  = TextEditingController();
  final TextEditingController _sellingPriceController   = TextEditingController();
  final TextEditingController _quantityController       = TextEditingController();

  // وضعیت فرم
  String? _selectedCategory;
  bool   _isAvailable = true;
  bool   _isQuantity  = true;
  bool   _isLoading   = false;

  final List<String> _categories = [
    'Electronics', 'Clothing', 'Food', 'Books', 'Sports'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  /// هندلر کلیک روی دکمهٔ Add
  void _handleAdd() {
    setState(() => _isLoading = true);
    _saveNewProduct();
  }

  /// عملیات ذخیرهٔ محصول جدید در دیتابیس
  Future<void> _saveNewProduct() async {
    final newProduct = Product(
      name: _nameController.text,
      category: _selectedCategory ?? '',
      purchasePrice: double.tryParse(_purchasePriceController.text) ?? 0,
      sellingPrice:  double.tryParse(_sellingPriceController.text)  ?? 0,
      isAvailable:   _isAvailable,
      quantity:      _isQuantity
          ? int.tryParse(_quantityController.text) ?? 0
          : 0,
      weight:        !_isQuantity
          ? double.tryParse(_quantityController.text) ?? 0
          : 0,
      imageUrl:      '', // در صورت لزوم مسیر یا URL عکس را وارد کنید
    );

    await DbHelper.addProduct(newProduct);
    await Future.delayed(const Duration(seconds: 1));


    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // اپ‌بار
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18, fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,

      // Stack برای نمایش overlay لودینگ
      body: Stack(
        children: [
          // محتوای اصلی فرم
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ImagePickerSection(onTap: () { /* TODO: آپلود تصویر */ }),
                  const SizedBox(height: 24),
                  NameFieldSection(nameController: _nameController),
                  const SizedBox(height: 20),
                  CategoryFieldSection(
                    selectedCategory: _selectedCategory,
                    onTap: () => _showCategoryPicker(context),
                  ),
                  const SizedBox(height: 20),
                  PriceFieldsSection(
                    purchaseController: _purchasePriceController,
                    sellingController: _sellingPriceController,
                  ),
                  const SizedBox(height: 20),
                  AvailabilitySection(
                    isAvailable: _isAvailable,
                    onChanged: (v) => setState(() => _isAvailable = v),
                  ),
                  const SizedBox(height: 20),
                  UnitTypeSection(
                    isQuantity: _isQuantity,
                    onChanged: (v) => setState(() => _isQuantity = v),
                  ),
                  const SizedBox(height: 12),
                  QuantityWeightField(
                    isQuantity: _isQuantity,
                    controller: _quantityController,
                  ),
                  const SizedBox(height: 32),
                  AddButtonSection(
                    onPressed: _isLoading ? null : _handleAdd,
                  ),
                ],
              ),
            ),
          ),
          // overlay لودینگ
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  // دیالوگ انتخاب دسته‌بندی
  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final category = _categories[i];
            return ListTile(
              title: Text(category),
              onTap: () {
                setState(() => _selectedCategory = category);
                Navigator.of(ctx).pop();
              },
            );
          },
        ),
      ),
    );
  }
}
