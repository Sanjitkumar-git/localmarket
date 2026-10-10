import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/view_product/controller/view_product_controller.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';
import 'package:localmarket/widget/validation_controller.dart';

class ViewProductView extends GetView<ViewProductController> {
  const ViewProductView({super.key});

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
          'View Products',
          style: TextStyle(
            color: AppColors.white,
            fontSize: AppTextSizes.h5,
            fontWeight: AppFontWeights.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: controller.refreshProducts,
            child: Column(
              children: [
                _searchBar(),
                _countHeader(),
                const SizedBox(height: 6),
                Expanded(
                  child: controller.filteredProducts.isEmpty
                      ? _emptyState()
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                          itemCount: controller.filteredProducts.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final product = controller.filteredProducts[index];
                            return _productCard(product);
                          },
                        ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ───────────────────────── SEARCH BAR ─────────────────────────

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.10),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.updateSearch,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppTextSizes.button,
          ),
          decoration: InputDecoration(
            hintText: 'Search products',
            hintStyle: TextStyle(color: AppColors.textSecondary),
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.primary, width: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── COUNT HEADER ─────────────────────────

  Widget _countHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${controller.filteredProducts.length} Products',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppTextSizes.button,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── PRODUCT CARD ─────────────────────────

  // ───────────────────────── PRODUCT CARD (PREMIUM, COMPACT) ─────────────────────────

  Widget _productCard(Map<String, dynamic> product) {
    final String name = product['name']?.toString() ?? 'Product';
    final String description = product['description']?.toString() ?? '';
    final String category = product['category']?.toString() ?? '';

    // Image URL future mein Cloudflare R2 se aayega.
    final String imageUrl = product['imageUrl']?.toString() ?? '';

    final String price = product['price']?.toString() ?? '0';

    final double stockQuantity = (product['stockQuantity'] ?? 0).toDouble();

    final String stockUnit = product['stockUnit']?.toString() ?? 'pcs';

    final bool isActive = product['isActive'] == true;

    final String stockValue = stockQuantity % 1 == 0
        ? stockQuantity.toInt().toString()
        : stockQuantity.toString();

    final Color stockDot = stockQuantity <= 0
        ? const Color(0xFFFF6B6B)
        : (stockQuantity <= 5
              ? const Color(0xFFFFB74D)
              : const Color(0xFF7CE3A1));

    final String stockLabel = stockQuantity <= 0
        ? 'Out of stock'
        : 'Stock: $stockValue $stockUnit';

    final List<Color> gradient = isActive
        ? const [Color(0xFF1B7F3B), Color(0xFF0F5A28)]
        : const [Color(0xFF6B7570), Color(0xFF454D49)];

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -28,
            top: -28,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: -36,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IMAGE
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: imageUrl.isEmpty
                        ? Container(
                            color: AppColors.shophome,
                            child: Icon(
                              Icons.inventory_2_outlined,
                              size: 30,
                              color: AppColors.primary,
                            ),
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.shophome,
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  size: 30,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
                          ),
                  ),
                ),

                const SizedBox(width: 12),

                // DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextSizes.button,
                          fontWeight: AppFontWeights.bold,
                          letterSpacing: 0.2,
                        ),
                      ),

                      if (category.isNotEmpty || description.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          category.isNotEmpty ? category : description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: AppTextSizes.caption,
                          ),
                        ),
                      ],

                      const SizedBox(height: 6),

                      Text(
                        '₹$price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextSizes.h6,
                          fontWeight: AppFontWeights.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _infoChip(dot: stockDot, label: stockLabel),
                          _infoChip(
                            dot: isActive
                                ? const Color(0xFF7CE3A1)
                                : const Color(0xFFFF8A80),
                            label: isActive ? 'Active' : 'Inactive',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // ACTIONS
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _actionButton(
                      icon: Icons.edit_outlined,
                      color: AppColors.primary,
                      onTap: () => _showEditDialog(product),
                    ),
                    const SizedBox(height: 10),
                    _actionButton(
                      icon: Icons.delete_outline,
                      color: AppColors.error,
                      onTap: () {
                        controller.confirmDeleteProduct(
                          product['documentId'].toString(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 19, color: color),
        ),
      ),
    );
  }

  Widget _infoChip({required Color dot, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dot),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppTextSizes.caption,
              fontWeight: AppFontWeights.medium,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── EMPTY STATE ─────────────────────────

  Widget _emptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: Get.height * 0.55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.08),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'No Products Found',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.h5,
                  fontWeight: AppFontWeights.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Add products from the Add Product section.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.caption,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ───────────────────────── EDIT DIALOG ─────────────────────────

  Future<void> _showEditDialog(Map<String, dynamic> product) async {
    await Get.dialog(
      _EditProductDialog(product: product, controller: controller),
    );
  }
}

// ═════════════════════════ EDIT DIALOG WIDGET ═════════════════════════

class _EditProductDialog extends StatefulWidget {
  final Map<String, dynamic> product;
  final ViewProductController controller;

  const _EditProductDialog({required this.product, required this.controller});

  @override
  State<_EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<_EditProductDialog> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _price;
  late final TextEditingController _stock;
  late String _stockUnit;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _name = TextEditingController(text: p['name']?.toString() ?? '');
    _description = TextEditingController(
      text: p['description']?.toString() ?? '',
    );
    _price = TextEditingController(text: p['price']?.toString() ?? '');
    _stock = TextEditingController(text: p['stockQuantity']?.toString() ?? '');
    _stockUnit = p['stockUnit']?.toString() ?? 'pcs';
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    _stock.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final String name = _name.text.trim();
    final String description = _description.text.trim();
    final double? price = double.tryParse(_price.text.trim());
    final double? stockQuantity = double.tryParse(_stock.text.trim());

    if (name.isEmpty || price == null || stockQuantity == null) {
      AppSnackbar.error('Please enter valid product details.');
      return;
    }

    setState(() => _saving = true);

    try {
      await widget.controller.updateProduct(
        documentId: widget.product['documentId'].toString(),
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        stockUnit: _stockUnit,
        category: widget.product['category']?.toString() ?? '',
      );
      Get.back();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textSecondary),
      prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
      filled: true,
      fillColor: AppColors.primary.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 12, 18),
            color: AppColors.primary,
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Edit Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppTextSizes.h5,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _saving ? null : () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              ],
            ),
          ),

          // Fields
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _decoration(
                      'Product Name',
                      Icons.shopping_bag_outlined,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _description,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _decoration('Description', Icons.notes_rounded),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _price,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: _decoration(
                            'Price',
                            Icons.currency_rupee_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _stock,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: _decoration(
                            'Stock Quantity',
                            Icons.layers_outlined,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _stockUnit,
                          decoration: _decoration(
                            'Unit',
                            Icons.straighten_outlined,
                          ),
                          items: const [
                            DropdownMenuItem(value: 'pcs', child: Text('pcs')),
                            DropdownMenuItem(value: 'kg', child: Text('kg')),
                            DropdownMenuItem(value: 'g', child: Text('g')),
                            DropdownMenuItem(
                              value: 'liter',
                              child: Text('liter'),
                            ),
                            DropdownMenuItem(value: 'ml', child: Text('ml')),
                            DropdownMenuItem(
                              value: 'pack',
                              child: Text('pack'),
                            ),
                            DropdownMenuItem(value: 'box', child: Text('box')),
                            DropdownMenuItem(
                              value: 'bottle',
                              child: Text('bottle'),
                            ),
                            DropdownMenuItem(
                              value: 'dozen',
                              child: Text('dozen'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _stockUnit = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving ? null : () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: BorderSide(
                        color: AppColors.textSecondary.withOpacity(0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
