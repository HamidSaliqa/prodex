import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/category_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';
import '../widgets/edit_product/edit_action_buttons_section.dart';

/// صفحهٔ ویرایش محصول؛ مقادیر اولیه را از شیء Product می‌گیرد
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

  final List<String> _categories = [
    'Electronics', 'Clothing', 'Food', 'Books', 'Sports'
  ];

  @override
  void initState() {
    super.initState();
    // مقداردهی اولیه از widget.product
    _nameController = TextEditingController(text: widget.product.name);
    _purchaseController =
        TextEditingController(text: widget.product.purchasePrice.toString());
    _sellingController =
        TextEditingController(text: widget.product.sellingPrice.toString());
    _selectedCategory = widget.product.category;
    _isAvailable = widget.product.isAvailable;
    _isQuantity = widget.product.quantity > 0;
    _quantityController = TextEditingController(
      text: _isQuantity
          ? widget.product.quantity.toString()
          : widget.product.weight.toString(),
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
          'Edit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      // محتوا
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            // ─────────────────────────────────────────────────
            // 1) Upload Image
            ImagePickerSection(onTap: () {
              // TODO: آپلود یا تغییر تصویر
            }),
            const SizedBox(height: 24),

            // 2) Product Name
            NameFieldSection(nameController: _nameController),
            const SizedBox(height: 20),

            // 3) Category
            CategoryFieldSection(
              selectedCategory: _selectedCategory,
              onTap: () => _showCategoryPicker(context),
            ),
            const SizedBox(height: 20),

            // 4) Purchase & Selling Price
            PriceFieldsSection(
              purchaseController: _purchaseController,
              sellingController: _sellingController,
            ),
            const SizedBox(height: 20),

            // 5) Availability
            AvailabilitySection(
              isAvailable: _isAvailable,
              onChanged: (v) => setState(() => _isAvailable = v),
            ),
            const SizedBox(height: 20),

            // 6) Unit Type
            UnitTypeSection(
              isQuantity: _isQuantity,
              onChanged: (v) => setState(() {
                _isQuantity = v;
                // مقدار placeholder را در Controller هم آپدیت کنیم
                _quantityController.text = v
                    ? widget.product.quantity.toString()
                    : widget.product.weight.toString();
              }),
            ),
            const SizedBox(height: 12),

            // 7) Quantity / Weight field
            QuantityWeightField(
              isQuantity: _isQuantity,
              controller: _quantityController,
            ),
            const SizedBox(height: 32),

            // 8) Cancel / Update buttons
            EditActionButtonsSection(
              onCancel: () => Navigator.of(context).pop(),
              onUpdate: () {
                // TODO: منطق ذخیرهٔ تغییرات و بازگشت
              },
            ),
          ],
        ),
      ),
    );
  }

  // دیالوگ انتخاب دسته‌بندی (مانند AddProductScreen)
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
          itemBuilder: (_, i) => ListTile(
            title: Text(_categories[i]),
            onTap: () {
              setState(() => _selectedCategory = _categories[i]);
              Navigator.of(ctx).pop();
            },
          ),
        ),
      ),
    );
  }
}
