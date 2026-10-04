import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/add_product/controller/add_product_controller.dart';

import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

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
        child: SingleChildScrollView(
          padding: AppPadding.allMd,

          child: Form(
            key: controller.formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Information',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppTextSizes.h5,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Add the details of your product',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.caption,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  final image = controller.selectedImage.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Image',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppTextSizes.h6,
                          fontWeight: AppFontWeights.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: controller.pickProductImage,

                        child: Container(
                          width: double.infinity,
                          height: 220,

                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: AppRadius.rounded,
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.25),
                            ),
                          ),

                          child: image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 55,
                                      color: AppColors.primary,
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      'Select Product Image',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: AppTextSizes.button,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      'Tap here to choose image from gallery',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: AppTextSizes.caption,
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: AppRadius.rounded,

                                      child: Image.file(
                                        File(image.path),

                                        width: double.infinity,
                                        height: double.infinity,

                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      top: 10,
                                      right: 10,

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.55),
                                          shape: BoxShape.circle,
                                        ),

                                        child: IconButton(
                                          onPressed:
                                              controller.removeProductImage,

                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 10,
                                      right: 10,

                                      child: ElevatedButton.icon(
                                        onPressed: controller.pickProductImage,

                                        icon: const Icon(Icons.edit),
                                        label: const Text('Change'),

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  );
                }),

                const SizedBox(height: 10),

                TextFormField(
                  controller: controller.nameController,

                  textInputAction: TextInputAction.next,

                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Enter product name',

                    prefixIcon: const Icon(Icons.inventory_2_outlined),

                    filled: true,
                    fillColor: AppColors.card,

                    border: OutlineInputBorder(borderRadius: AppRadius.rounded),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: controller.descriptionController,

                  maxLines: 4,
                  textInputAction: TextInputAction.newline,

                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter product description',

                    prefixIcon: const Icon(Icons.description_outlined),

                    filled: true,
                    fillColor: AppColors.card,

                    border: OutlineInputBorder(borderRadius: AppRadius.rounded),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter description';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: controller.priceController,

                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  textInputAction: TextInputAction.next,

                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Enter product price',

                    prefixIcon: const Icon(Icons.currency_rupee),

                    filled: true,
                    fillColor: AppColors.card,

                    border: OutlineInputBorder(borderRadius: AppRadius.rounded),
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

                const SizedBox(height: 15),

                TextFormField(
                  controller: controller.stockController,

                  keyboardType: TextInputType.number,

                  textInputAction: TextInputAction.done,

                  decoration: InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Enter available quantity',

                    prefixIcon: const Icon(Icons.inventory_outlined),

                    filled: true,
                    fillColor: AppColors.card,

                    border: OutlineInputBorder(borderRadius: AppRadius.rounded),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter stock';
                    }

                    final int? stock = int.tryParse(value.trim());

                    if (stock == null || stock < 0) {
                      return 'Please enter a valid stock';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                Obx(() {
                  // Loading categories
                  if (controller.isLoadingCategories.value) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),

                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: AppRadius.rounded,
                      ),

                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            'Loading your shop categories...',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextSizes.caption,
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
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: AppRadius.rounded,
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.secondary,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              'No category found for your shop. '
                              'Please select a category during shop registration.',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.caption,
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

                    decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select product category',

                      prefixIcon: const Icon(Icons.category_outlined),

                      filled: true,
                      fillColor: AppColors.card,

                      border: OutlineInputBorder(
                        borderRadius: AppRadius.rounded,
                      ),
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

                const SizedBox(height: 30),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.addProduct,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.rounded,
                        ),
                      ),

                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,

                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                const Icon(Icons.add_shopping_cart_outlined),

                                const SizedBox(width: 8),

                                Text(
                                  'Add Product',
                                  style: TextStyle(
                                    fontSize: AppTextSizes.button,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
