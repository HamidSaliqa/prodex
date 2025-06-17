import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/db_helper.dart';
import 'package:prodex/widgets/utils/app_spacing.dart';
import '../widgets/utils/constants.dart';
import '../widgets/common/category_picker.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';             // با پشتیبانی از validator
import '../widgets/add_product/price_fields_section.dart';          // با پشتیبانی از validator
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';         // با پشتیبانی از validator

/// صفحهٔ ویرایش محصول با Form‐based validation
class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // کلید فرم
  final _formKey = GlobalKey<FormState>();

  // کنترلرها با مقادیر اولیه
  late final _nameController     =
  TextEditingController(text: widget.product.name);
  late final _purchaseController =
  TextEditingController(text: widget.product.purchasePrice.toString());
  late final _sellingController  =
  TextEditingController(text: widget.product.sellingPrice.toString());
  late final _quantityController = TextEditingController(
      text: widget.product.quantity > 0
          ? widget.product.quantity.toString()
          : widget.product.weight.toString());

  File?   _imageFile;
  String? _selectedCategory;
  bool    _isAvailable = true;
  bool    _isQuantity  = true;
  bool    _isLoading   = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _imageFile        = p.imageUrl.isNotEmpty ? File(p.imageUrl) : null;
    _selectedCategory = p.category;
    _isAvailable      = p.isAvailable;
    _isQuantity       = p.quantity > 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  /// هنگام فشردن Update، ابتدا اعتبارسنجی می‌کنیم
  void _handleUpdate() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لطفاً یک دسته‌بندی انتخاب کنید'))
      );
      return;
    }

    setState(() => _isLoading = true);
    _saveUpdatedProduct();
  }

  Future<void> _saveUpdatedProduct() async {
    final updated = Product(
      id:             widget.product.id,
      name:           _nameController.text.trim(),
      category:       _selectedCategory!,
      purchasePrice:  double.parse(_purchaseController.text),
      sellingPrice:   double.parse(_sellingController.text),
      isAvailable:    _isAvailable,
      quantity:       _isQuantity ? int.parse(_quantityController.text) : 0,
      weight:         !_isQuantity ? double.parse(_quantityController.text) : 0,
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
      // =========== AppBar ===========
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),

      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              // پیچیدن در Form
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1) عکس (اختیاری)
                    ImagePickerSection(
                      imagePath: _imageFile?.path,
                      onImageSelected: (path) => setState(() => _imageFile = File(path)),
                    ),
                    AppSpacing.v24,

                    // 2) نام محصول (اجباری)
                    NameFieldSection(
                      nameController: _nameController,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Product name is required'
                          : null,
                    ),
                    AppSpacing.v20,

                    // 3) دسته‌بندی (اجباری)
                    const Text('Category', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    AppSpacing.v8,
                    CategoryPicker(
                      selected: _selectedCategory,
                      options: Constants.categories,
                      onSelected: (cat) => setState(() => _selectedCategory = cat),
                    ),
                    AppSpacing.v20,

                    // 4) قیمت‌ها (اجباری)
                    PriceFieldsSection(
                      purchaseController: _purchaseController,
                      sellingController: _sellingController,
                      purchaseValidator: (v) => v == null || v.trim().isEmpty
                          ? 'Purchase price is required'
                          : null,
                      sellingValidator: (v) => v == null || v.trim().isEmpty
                          ? 'Selling price is required'
                          : null,
                    ),
                    AppSpacing.v20,

                    // 5) AvailabilitySection
                    AvailabilitySection(
                      isAvailable: _isAvailable,
                      onChanged: (v) => setState(() => _isAvailable = v),
                    ),
                    AppSpacing.v20,

                    // 6) UnitTypeSection
                    UnitTypeSection(
                      isQuantity: _isQuantity,
                      onChanged: (v) => setState(() => _isQuantity = v),
                    ),
                    AppSpacing.v12,

                    // 7) Quantity/Weight (اجباری)
                    QuantityWeightField(
                      isQuantity: _isQuantity,
                      controller: _quantityController,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Quantity or weight is required'
                          : null,
                    ),
                    AppSpacing.v32,

                    // 8) دکمه Update
                    PrimaryButton(
                      label: 'Update',
                      onPressed: _isLoading ? null : _handleUpdate,
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
