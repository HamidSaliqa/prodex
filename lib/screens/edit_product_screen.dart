// lib/screens/edit_product_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
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
import '../widgets/utils/app_spacing.dart';
import '../widgets/utils/constants.dart';

/// صفحهٔ ویرایش محصول؛ شامل پیش‌نمایش و انتخاب تصویر جدید، و overlay لودینگ
class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late final TextEditingController _nameController     =
  TextEditingController(text: widget.product.name);
  late final TextEditingController _purchaseController =
  TextEditingController(text: widget.product.purchasePrice.toString());
  late final TextEditingController _sellingController  =
  TextEditingController(text: widget.product.sellingPrice.toString());
  late final TextEditingController _quantityController =
  TextEditingController(
      text: widget.product.quantity > 0
          ? widget.product.quantity.toString()
          : widget.product.weight.toString());

  String? _selectedCategory;
  bool   _isAvailable = true;
  bool   _isQuantity  = true;
  bool   _isLoading   = false;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _selectedCategory = p.category;
    _isAvailable      = p.isAvailable;
    _isQuantity       = p.quantity > 0;
    _imageFile        = p.imageUrl.isNotEmpty ? File(p.imageUrl) : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    setState(() => _isLoading = true);
    _saveUpdatedProduct();
  }

  Future<void> _saveUpdatedProduct() async {
    final updated = Product(
      id:             widget.product.id,
      name:           _nameController.text,
      category:       _selectedCategory ?? '',
      purchasePrice:  double.tryParse(_purchaseController.text) ?? 0,
      sellingPrice:   double.tryParse(_sellingController.text)  ?? 0,
      isAvailable:    _isAvailable,
      quantity:       _isQuantity
          ? int.tryParse(_quantityController.text) ?? 0
          : 0,
      weight:         !_isQuantity
          ? double.tryParse(_quantityController.text) ?? 0
          : 0,
      imageUrl:       _imageFile?.path ?? widget.product.imageUrl,
    );

    await DbHelper.editProduct(updated);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
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
          'Edit Product',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                  purchaseController: _purchaseController,
                  sellingController: _sellingController,
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
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Cancel',
                        onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      ),
                    ),
                    AppSpacing.v16,
                    Expanded(
                      child: PrimaryButton(
                        label: 'Update',
                        onPressed: _isLoading ? null : _handleUpdate,
                      ),
                    ),
                  ],
                ),
              ],
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
