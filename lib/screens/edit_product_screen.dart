// lib/screens/edit_product_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/category_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';
import '../widgets/edit_product/edit_action_buttons_section.dart';

/// صفحهٔ ویرایش محصول؛ همراه با overlay لودینگ هنگام ذخیره‌سازی
class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _purchaseController;
  late TextEditingController _sellingController;
  late TextEditingController _quantityController;

  String? _selectedCategory;
  bool _isAvailable = true;
  bool _isQuantity = true;
  bool _isLoading = false;

  final List<String> _categories = [
    'Electronics', 'Clothing', 'Food', 'Books', 'Sports'
  ];

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p.name);
    _purchaseController =
        TextEditingController(text: p.purchasePrice.toString());
    _sellingController =
        TextEditingController(text: p.sellingPrice.toString());
    _selectedCategory = p.category;
    _isAvailable = p.isAvailable;
    _isQuantity = p.quantity > 0;
    _quantityController = TextEditingController(
      text: _isQuantity ? p.quantity.toString() : p.weight.toString(),
    );
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
      id: widget.product.id,
      name: _nameController.text,
      category: _selectedCategory ?? '',
      purchasePrice: double.tryParse(_purchaseController.text) ?? 0,
      sellingPrice: double.tryParse(_sellingController.text) ?? 0,
      isAvailable: _isAvailable,
      quantity:
      _isQuantity ? int.tryParse(_quantityController.text) ?? 0 : 0,
      weight:
      !_isQuantity ? double.tryParse(_quantityController.text) ?? 0 : 0,
      imageUrl: widget.product.imageUrl,
    );

    await DbHelper.editProduct(updated);
    // افزودن تأخیر کوچک برای نمایش بهتر لودینگ
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
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                ImagePickerSection(onTap: () {
                  // TODO: تغییر تصویر
                }),
                const SizedBox(height: 24),
                NameFieldSection(nameController: _nameController),
                const SizedBox(height: 20),
                CategoryFieldSection(
                  selectedCategory: _selectedCategory,
                  onTap: () => _showCategoryPicker(context),
                ),
                const SizedBox(height: 20),
                PriceFieldsSection(
                  purchaseController: _purchaseController,
                  sellingController: _sellingController,
                ),
                const SizedBox(height: 20),
                AvailabilitySection(
                  isAvailable: _isAvailable,
                  onChanged: (v) => setState(() => _isAvailable = v),
                ),
                const SizedBox(height: 20),
                UnitTypeSection(
                  isQuantity: _isQuantity,
                  onChanged: (v) => setState(() {
                    _isQuantity = v;
                    _quantityController.text = v
                        ? widget.product.quantity.toString()
                        : widget.product.weight.toString();
                  }),
                ),
                const SizedBox(height: 12),
                QuantityWeightField(
                  isQuantity: _isQuantity,
                  controller: _quantityController,
                ),
                const SizedBox(height: 32),
                EditActionButtonsSection(
                  onCancel: () => Navigator.of(context).pop(),
                  onUpdate: _isLoading ? null : _handleUpdate,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape:
      const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            return ListTile(
              title: Text(_categories[i]),
              onTap: () {
                setState(() => _selectedCategory = _categories[i]);
                Navigator.of(ctx).pop();
              },
            );
          },
        ),
      ),
    );
  }
}
