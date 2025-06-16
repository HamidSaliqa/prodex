// lib/screens/add_product_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prodex/widgets/utils/app_spacing.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/common/category_picker.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';
import '../widgets/utils/constants.dart';

/// صفحهٔ افزودن محصول جدید با Overlay لودینگ و استفاده از ویجت‌های مشترک
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController          = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController  = TextEditingController();
  final _quantityController      = TextEditingController();

  File? _imageFile;
  String? _selectedCategory;
  bool   _isAvailable = true;
  bool   _isQuantity  = true;
  bool   _isLoading   = false;

  void _handleAdd() {
    setState(() => _isLoading = true);
    _saveNewProduct();
  }

  Future<void> _saveNewProduct() async {
    final p = Product(
      name: _nameController.text,
      category: _selectedCategory ?? '',
      purchasePrice: double.tryParse(_purchasePriceController.text) ?? 0,
      sellingPrice:  double.tryParse(_sellingPriceController.text)  ?? 0,
      isAvailable:   _isAvailable,
      quantity:      _isQuantity ? int.tryParse(_quantityController.text) ?? 0 : 0,
      weight:        !_isQuantity ? double.tryParse(_quantityController.text) ?? 0 : 0,
      imageUrl:_imageFile?.path ?? '',
    );
    await DbHelper.addProduct(p);
    await Future.delayed(const Duration(seconds: 1)); // افزایش زمان لودینگ
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _quantityController.dispose();
    super.dispose();
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
          'Add Product',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ImagePickerSection(
                    imagePath: _imageFile?.path,
                    onImageSelected: (path) => setState(() => _imageFile = File(path)),
                  ),
                  AppSpacing.v24,
                  NameFieldSection(nameController: _nameController),
                  AppSpacing.v20,
                  CategoryPicker(
                    selected: _selectedCategory,
                    options: Constants.categories,
                    onSelected: (cat) => setState(() => _selectedCategory = cat),
                  ),
                  AppSpacing.v20,
                  PriceFieldsSection(
                    purchaseController: _purchasePriceController,
                    sellingController: _sellingPriceController,
                  ),
                  AppSpacing.v20,
                  AvailabilitySection(
                    isAvailable: _isAvailable,
                    onChanged: (v) => setState(() => _isAvailable = v),
                  ),
                  AppSpacing.v20,
                  UnitTypeSection(
                    isQuantity: _isQuantity,
                    onChanged: (v) => setState(() => _isQuantity = v),
                  ),
                  AppSpacing.v12,
                  QuantityWeightField(
                    isQuantity: _isQuantity,
                    controller: _quantityController,
                  ),
                  AppSpacing.v32,
                  PrimaryButton(
                    label: 'Add',
                    onPressed: _isLoading ? null : _handleAdd,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
