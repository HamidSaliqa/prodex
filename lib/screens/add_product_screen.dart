// lib/screens/add_product_screen.dart

import 'package:flutter/material.dart';
import '../widgets/add_product/add_button_section.dart';
import '../widgets/add_product/image_picker_section.dart';
import '../widgets/add_product/name_field_section.dart';
import '../widgets/add_product/category_field_section.dart';
import '../widgets/add_product/price_fields_section.dart';
import '../widgets/add_product/availability_section.dart';
import '../widgets/add_product/unit_type_section.dart';
import '../widgets/add_product/quantity_weight_field.dart';

/// صفحه‌ای برای افزودن محصول جدید (قابل اسکرول و با قابلیت انتخاب Quantity/Weight)
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // =======================================================================
  //  کنترلرهای فیلدهای متنی
  // =======================================================================
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // =======================================================================
  //  متغیرهای وضعیت (state)
  // =======================================================================
  String? _selectedCategory; // دسته‌بندی انتخاب‌شده
  bool _isAvailable = true;  // true = Available, false = Not Available
  bool _isQuantity = true;   // true = Quantity, false = Weight

  // لیست نمونه دسته‌بندی‌ها برای BottomSheet
  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Food',
    'Books',
    'Sports',
  ];

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
      // =====================================================================
      //  اپ‌بار ساده با عنوان «Add products»
      // =====================================================================
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
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,

      // =====================================================================
      //  استفاده از ListView برای اسکرول کل فرم
      // =====================================================================
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // -----------------------------------------------------------------
              // از widget: widgets/add_product/image_picker_section.dart
              ImagePickerSection(
                onTap: () {
                  // TODO: عملکرد آپلود تصویر را اینجا اضافه کنید
                },
              ),

              const SizedBox(height: 24),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/name_field_section.dart
              NameFieldSection(nameController: _nameController),

              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/category_field_section.dart
              CategoryFieldSection(
                selectedCategory: _selectedCategory,
                onTap: () => _showCategoryPicker(context),
              ),

              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/price_fields_section.dart
              PriceFieldsSection(
                purchaseController: _purchasePriceController,
                sellingController: _sellingPriceController,
              ),

              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/availability_section.dart
              AvailabilitySection(
                isAvailable: _isAvailable,
                onChanged: (newValue) {
                  setState(() {
                    _isAvailable = newValue;
                  });
                },
              ),

              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/unit_type_section.dart
              UnitTypeSection(
                isQuantity: _isQuantity,
                onChanged: (newValue) {
                  setState(() {
                    _isQuantity = newValue;
                  });
                },
              ),

              const SizedBox(height: 12),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/quantity_weight_field.dart
              QuantityWeightField(
                isQuantity: _isQuantity,
                controller: _quantityController,
              ),

              const SizedBox(height: 32),

              // -----------------------------------------------------------------
              // از widget: widgets/add_product/add_button_section.dart
              AddButtonSection(
                onPressed: () {
                  // TODO: منطق ارسال داده و افزودن محصول را اینجا پیاده کنید
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  //  تابعی برای نمایش دیالوگ انتخاب دسته‌بندی (BottomSheet)
  //  این تابع مربوط به بخش CategoryFieldSection است
  // ===========================================================================
  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return ListTile(
                title: Text(category),
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                  Navigator.of(ctx).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
