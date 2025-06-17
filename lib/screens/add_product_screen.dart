// lib/screens/add_product_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prodex/widgets/utils/app_spacing.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/utils/constants.dart';
import '../widgets/common/category_picker.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';

/// صفحهٔ افزودن محصول جدید با Form‐based validation
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // کلید فرم
  final _formKey = GlobalKey<FormState>();

  // کنترلرهای فیلدها
  final _nameController          = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController  = TextEditingController();
  final _quantityController      = TextEditingController();

  File?   _imageFile;
  String? _selectedCategory;
  bool    _isAvailable = true;
  bool    _isQuantity  = true;
  bool    _isLoading   = false;

  /// ذخیره محصول در دیتابیس
  Future<void> _saveNewProduct() async {
    final product = Product(
      name:           _nameController.text.trim(),
      category:       _selectedCategory!,
      purchasePrice:  double.parse(_purchasePriceController.text),
      sellingPrice:   double.parse(_sellingPriceController.text),
      isAvailable:    _isAvailable,
      quantity:       _isQuantity ? int.parse(_quantityController.text) : 0,
      weight:         !_isQuantity ? double.parse(_quantityController.text) : 0,
      imageUrl:       _imageFile?.path ?? '',
    );
    await DbHelper.addProduct(product);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  /// هندل دکمه Add
  void _handleAdd() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    _saveNewProduct();
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
      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
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
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1) انتخاب عکس (اختیاری)
                    ImagePickerSection(
                      imagePath: _imageFile?.path,
                      onImageSelected: (path) => setState(() => _imageFile = File(path)),
                    ),
                    AppSpacing.v24,

                    // 2) نام محصول (اجباری)
                    NameFieldSection(
                      nameController: _nameController,
                      validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Name is required' : null,
                    ),
                    AppSpacing.v20,

                    // 3) دسته‌بندی با FormField
                    FormField<String>(
                      initialValue: _selectedCategory,
                      validator: (val) =>
                      val == null || val.isEmpty ? 'Category is required' : null,
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            AppSpacing.v8,
                            CategoryPicker(
                              selected: state.value,
                              options: Constants.categories,
                              onSelected: (cat) {
                                state.didChange(cat);
                                setState(() => _selectedCategory = cat);
                              },
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  state.errorText!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    AppSpacing.v20,

                    // 4) قیمت‌ها (اجباری)
                    PriceFieldsSection(
                      purchaseController: _purchasePriceController,
                      sellingController: _sellingPriceController,
                      purchaseValidator: (v) =>
                      v == null || v.trim().isEmpty ? 'Purchase price is required' : null,
                      sellingValidator: (v) =>
                      v == null || v.trim().isEmpty ? 'Selling price is required' : null,
                    ),
                    AppSpacing.v20,

                    // 5) Availability (اجباری)
                    AvailabilitySection(
                      isAvailable: _isAvailable,
                      onChanged: (v) => setState(() => _isAvailable = v),
                    ),
                    AppSpacing.v20,

                    // 6) Unit type (اجباری)
                    UnitTypeSection(
                      isQuantity: _isQuantity,
                      onChanged: (v) => setState(() => _isQuantity = v),
                    ),
                    AppSpacing.v12,

                    // 7) تعداد/وزن (اجباری)
                    QuantityWeightField(
                      isQuantity: _isQuantity,
                      controller: _quantityController,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Quantity/Weight is required'
                          : null,
                    ),
                    AppSpacing.v32,

                    // 8) دکمه Add
                    PrimaryButton(
                      label: 'Add',
                      onPressed: _isLoading ? null : _handleAdd,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Overlay لودینگ
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
