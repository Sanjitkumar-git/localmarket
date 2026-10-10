import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/add_product/controller/add_product_controller.dart';

import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // AppBar same as before
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Product',
          style: TextStyle(
            color: AppColors.white,
            fontSize: AppTextSizes.h5,
            fontWeight: AppFontWeights.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= _wideBreakpoint;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 24 : 16,
                      16,
                      isWide ? 24 : 16,
                      24,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _headerBanner(),
                          const SizedBox(height: 16),

                          if (isWide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 4, child: _imageSection(true)),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      _detailsSection(),
                                      const SizedBox(height: 16),
                                      _pricingSection(),
                                      const SizedBox(height: 16),
                                      _categorySection(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                _imageSection(false),
                                const SizedBox(height: 16),
                                _detailsSection(),
                                const SizedBox(height: 16),
                                _pricingSection(),
                                const SizedBox(height: 16),
                                _categorySection(),
                              ],
                            ),

                          const SizedBox(height: 24),
                          _submitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ───────────────────────── HEADER BANNER ─────────────────────────

  Widget _headerBanner() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7F3B), Color(0xFF0F5A28)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7F3B).withOpacity(0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -26,
            top: -30,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: -40,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_business_outlined,
                    color: Color(0xFF1B7F3B),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Information',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextSizes.h5,
                          fontWeight: AppFontWeights.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Add the details of your product',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: AppTextSizes.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── SECTION HELPERS ─────────────────────────

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppTextSizes.h6,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  InputDecoration _dec({required String label, String? hint, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: AppColors.textSecondary),
      hintStyle: TextStyle(
        color: AppColors.textSecondary.withOpacity(0.7),
        fontSize: AppTextSizes.caption,
      ),
      prefixIcon: icon == null
          ? null
          : Icon(icon, color: AppColors.primary, size: 20),
      filled: true,
      fillColor: AppColors.primary.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.primary.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.primary, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.error, width: 1.4),
      ),
    );
  }

  // ───────────────────────── IMAGE SECTION ─────────────────────────

  Widget _imageSection(bool isWide) {
    return _sectionCard(
      title: 'Product Image',
      icon: Icons.photo_camera_outlined,
      child: Obx(() {
        final image = controller.selectedImage.value;
        final double height = isWide ? 320 : 210;

        return GestureDetector(
          onTap: controller.pickProductImage,
          child: Container(
            width: double.infinity,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.30),
                width: 1.4,
              ),
            ),
            child: image == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 34,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Select Product Image',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: AppTextSizes.button,
                          fontWeight: AppFontWeights.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Tap here to choose image from gallery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.caption,
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      kIsWeb
                          ? Image.network(image.path, fit: BoxFit.cover)
                          : Image.file(File(image.path), fit: BoxFit.cover),

                      // Remove
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Material(
                          color: Colors.black.withOpacity(0.55),
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: controller.removeProductImage,
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Change
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Material(
                          color: Colors.white,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: controller.pickProductImage,
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Change',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: AppTextSizes.caption,
                                      fontWeight: AppFontWeights.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  // ───────────────────────── DETAILS SECTION ─────────────────────────

  Widget _detailsSection() {
    return _sectionCard(
      title: 'Basic Details',
      icon: Icons.inventory_2_outlined,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
            decoration: _dec(
              label: 'Product Name',
              hint: 'Enter product name',
              icon: Icons.shopping_bag_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: controller.descriptionController,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            textCapitalization: TextCapitalization.sentences,
            decoration: _dec(
              label: 'Description',
              hint: 'Enter product description',
              icon: Icons.notes_rounded,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // ───────────────────────── PRICING SECTION ─────────────────────────

  Widget _pricingSection() {
    return _sectionCard(
      title: 'Pricing & Stock',
      icon: Icons.sell_outlined,
      child: Column(
        children: [
          TextFormField(
            controller: controller.priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            decoration: _dec(
              label: 'Price',
              hint: 'Enter product price',
              icon: Icons.currency_rupee_rounded,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter price';
              }

              final double? price = double.tryParse(value.trim());

              if (price == null || price <= 0) {
                return 'Please enter a valid price';
              }

              return null;
            },
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: controller.stockController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: _dec(
                    label: 'Stock Quantity',
                    hint: 'Quantity',
                    icon: Icons.layers_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter stock';
                    }

                    final double? stock = double.tryParse(value.trim());

                    if (stock == null || stock < 0) {
                      return 'Enter valid stock';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedStockUnit.value.isEmpty
                        ? null
                        : controller.selectedStockUnit.value,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(14),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                    ),
                    decoration: _dec(label: 'Unit'),
                    hint: const Text('Unit'),
                    items: controller.stockUnits.map((unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedStockUnit.value = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select unit';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────────────── CATEGORY SECTION ─────────────────────────

  Widget _categorySection() {
    return _sectionCard(
      title: 'Category',
      icon: Icons.category_outlined,
      child: Obx(() {
        // Loading categories
        if (controller.isLoadingCategories.value) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Loading your shop categories...',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.caption,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // No categories found
        if (controller.shopCategories.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1DF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFF57C00).withOpacity(0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFF57C00),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'No category found for your shop. '
                    'Please select a category during shop registration.',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.caption,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Categories loaded
        return DropdownButtonFormField<String>(
          value: controller.selectedCategory.value.isEmpty
              ? null
              : controller.selectedCategory.value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(14),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
          ),
          decoration: _dec(
            label: 'Category',
            hint: 'Select product category',
            icon: Icons.category_outlined,
          ),
          items: controller.shopCategories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            controller.selectedCategory.value = value ?? '';
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select category';
            }
            return null;
          },
        );
      }),
    );
  }

  // ───────────────────────── SUBMIT BUTTON ─────────────────────────

  Widget _submitButton() {
    return Obx(() {
      final bool loading = controller.isLoading.value;

      return Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: loading
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: ElevatedButton(
          onPressed: loading ? null : controller.addProduct,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: loading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: AppColors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_shopping_cart_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: AppTextSizes.button,
                        fontWeight: AppFontWeights.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
