// lib/screens/customer_screen.dart

import 'package:flutter/material.dart';
import 'package:prodex/widgets/home/search_bar_custom.dart';
import 'package:prodex/widgets/common/primary_button.dart';
import '../widgets/utils/app_spacing.dart';

/// صفحهٔ مشتریان با امکان جست‌وجو، ویرایش/حذف و افزودن مشتری جدید
class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  // لیست نمونه مشتریان
  final List<String> _allCustomers = [
    'Alice Johnson',
    'Bob Smith',
    'Charlie Davis',
    'Diana Evans',
    'Ethan Ford',
    'Fiona Green',
  ];
  // لیست فیلترشده برای نمایش
  late List<String> _filteredCustomers;

  // کنترلرهای فرم افزودن مشتری
  final _firstNameController = TextEditingController();
  final _lastNameController  = TextEditingController();
  final _phoneController     = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCustomers = List.from(_allCustomers);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // فیلتر لیست هنگام تغییر متن جست‌وجو
  void _onSearchChanged(String text) {
    setState(() {
      _filteredCustomers = _allCustomers
          .where((c) => c.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  /// نمایش دیالوگ افزودن مشتری جدید
  Future<void> _showAddCustomerDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false, // کلیک بیرون پنجره بسته نشود
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Customer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                AppSpacing.v16,

                // First Name
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                ),
                AppSpacing.v12,

                // Last Name
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                ),
                AppSpacing.v12,

                // Phone Number
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                ),
                AppSpacing.v24,

                // Cancel / Confirm buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    AppSpacing.v16,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final first = _firstNameController.text.trim();
                          final last  = _lastNameController.text.trim();
                          if (first.isEmpty || last.isEmpty) return;
                          final fullName = '$first $last';
                          setState(() {
                            _allCustomers.add(fullName);
                            _filteredCustomers.add(fullName);
                          });
                          Navigator.of(ctx).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                AppSpacing.v16,
              ],
            ),
          ),
        );
      },
    );
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
              AppSpacing.v16,
              const Text(
                'Customers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AppSpacing.v16,

              // نوار جست‌وجو
              SearchBarCustom(
                hintText: 'Search customers',
                onTextChanged: _onSearchChanged,
                onFilterPressed: () {},
              ),
              AppSpacing.v16,

              // لیست مشتریان
              Expanded(
                child: _filteredCustomers.isEmpty
                    ? const Center(child: Text('No customers found'))
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filteredCustomers.length,
                  separatorBuilder: (_, __) => AppSpacing.v12,
                  itemBuilder: (ctx, i) {
                    final name = _filteredCustomers[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (val) {
                              if (val == 'Edit') {
                                // TODO: ویرایش مشتری
                              } else if (val == 'Delete') {
                                setState(() {
                                  _allCustomers.remove(name);
                                  _filteredCustomers.remove(name);
                                });
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'Edit', child: Text('Edit')),
                              PopupMenuItem(value: 'Delete', child: Text('Delete')),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // دکمه Add Customer
              AppSpacing.v16,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: PrimaryButton(
                  label: 'Add Customer',
                  onPressed: _showAddCustomerDialog,
                ),
              ),
              AppSpacing.v16,
            ],
          ),
        ),
      ),
    );
  }
}
