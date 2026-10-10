import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/offer_product/controller/offer_product_controller.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';
import 'package:localmarket/widget/common_app_bar.dart';

class OfferProductView extends GetView<OfferProductController> {
  const OfferProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Offer Product',
        showBackButton: true,
        showSupportButton: true,
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
            onRefresh: () async {
              controller.loadProducts();
            },
            child: Column(
              children: [
                _countHeader(),
                const SizedBox(height: 6),
                Expanded(
                  child: controller.products.isEmpty
                      ? _emptyState()
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                          itemCount: controller.products.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final product = controller.products[index];
                            return _productCard(context, product);
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

  // ───────────────────────── COUNT HEADER ─────────────────────────

  Widget _countHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
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
                  Icons.local_offer_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${controller.products.length} Products',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppTextSizes.button,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(() {
            final offersCount = controller.products
                .where((p) => p['hasOffer'] == true)
                .length;
            if (offersCount == 0) return const SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.discount_outlined,
                    size: 16,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$offersCount Active',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ───────────────────────── PRODUCT CARD (PREMIUM) ─────────────────────────

  Widget _productCard(BuildContext context, Map<String, dynamic> product) {
    final String name = product['name']?.toString() ?? 'Product';
    final String category = product['category']?.toString() ?? '';
    final String description = product['description']?.toString() ?? '';
    final double price = (product['price'] ?? 0).toDouble();
    final double stockQuantity = (product['stockQuantity'] ?? 0).toDouble();
    final String stockUnit = product['stockUnit']?.toString() ?? 'pcs';
    final bool hasOffer = product['hasOffer'] == true;
    final double? offerPrice = product['offerPrice'] != null
        ? (product['offerPrice']).toDouble()
        : null;
    final double? discountPercent = product['discountPercent'] != null
        ? (product['discountPercent']).toDouble()
        : null;
    final String imageUrl = product['imageUrl']?.toString() ?? '';

    final Color stockDot = stockQuantity == 0
        ? const Color(0xFFFF6B6B)
        : (stockQuantity <= 5
              ? const Color(0xFFFFB74D)
              : const Color(0xFF7CE3A1));
    final String stockLabel = stockQuantity == 0
        ? 'Out of stock'
        : 'Stock: ${stockQuantity.toStringAsFixed(stockQuantity % 1 == 0 ? 0 : 2)} $stockUnit';

    // Different gradient based on offer status
    final List<Color> gradient = hasOffer
        ? const [
            Color(0xFFE65100),
            Color(0xFFBF360C),
          ] // Orange gradient for offers
        : const [Color(0xFF1B7F3B), Color(0xFF0F5A28)]; // Green for regular

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

          // Discount Ribbon
          if (hasOffer && discountPercent != null && discountPercent > 0)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      size: 14,
                      color: gradient.first,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${discountPercent.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        color: gradient.first,
                        fontSize: AppTextSizes.caption,
                        fontWeight: AppFontWeights.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IMAGE
                    Container(
                      width: 78,
                      height: 78,
                      padding: const EdgeInsets.all(3),
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
                                  size: 32,
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
                          Padding(
                            padding: EdgeInsets.only(
                              right:
                                  hasOffer &&
                                      discountPercent != null &&
                                      discountPercent > 0
                                  ? 70
                                  : 0,
                            ),
                            child: Text(
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
                          ),
                          if (category.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: AppTextSizes.caption,
                              ),
                            ),
                          ],
                          if (description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.70),
                                fontSize: AppTextSizes.caption,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),

                          // PRICE ROW
                          if (hasOffer && offerPrice != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${offerPrice.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppTextSizes.h6,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    '₹${price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: AppTextSizes.caption,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.white.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              '₹${price.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppTextSizes.h6,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),

                          const SizedBox(height: 8),

                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              _infoChip(dot: stockDot, label: stockLabel),
                              if (hasOffer)
                                _infoChip(
                                  dot: const Color(0xFFFFD54F),
                                  label: 'On Offer',
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ACTION BUTTONS
                if (hasOffer)
                  Row(
                    children: [
                      Expanded(
                        child: _glassButton(
                          icon: Icons.edit_outlined,
                          label: 'Edit Offer',
                          onTap: controller.isSaving.value
                              ? null
                              : () => _showOfferDialog(context, product),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _glassButton(
                          icon: Icons.delete_outline,
                          label: 'Remove',
                          isDanger: true,
                          onTap: controller.isSaving.value
                              ? null
                              : () => controller.confirmRemoveOffer(
                                  product['documentId'].toString(),
                                ),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: _solidButton(
                      icon: Icons.local_offer_outlined,
                      label: 'Add Offer',
                      textColor: gradient.first,
                      onTap: controller.isSaving.value
                          ? null
                          : () => _showOfferDialog(context, product),
                    ),
                  ),
              ],
            ),
          ),
        ],
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

  Widget _glassButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isDanger = false,
  }) {
    return Material(
      color: isDanger
          ? Colors.white.withOpacity(0.95)
          : Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDanger
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isDanger ? AppColors.error : Colors.white,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDanger ? AppColors.error : Colors.white,
                    fontSize: AppTextSizes.caption,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _solidButton({
    required IconData icon,
    required String label,
    required Color textColor,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 46,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: AppTextSizes.button,
                  fontWeight: AppFontWeights.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────── EMPTY STATE ─────────────────────────

  Widget _emptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: Get.height * 0.6,
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
                  Icons.local_offer_outlined,
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
                  'Add a product first to create an offer.',
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

  // ───────────────────────── OFFER DIALOG ─────────────────────────

  Future<void> _showOfferDialog(
    BuildContext context,
    Map<String, dynamic> product,
  ) async {
    controller.selectProduct(product);

    DateTime? startDate = controller.offerStartDate.value;
    DateTime? endDate = controller.offerEndDate.value;

    final bool isEdit = controller.selectedProduct.value?['hasOffer'] == true;

    await Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          final double regularPrice = (product['price'] ?? 0).toDouble();

          return Dialog(
            backgroundColor: AppColors.card,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ─────────── HEADER (GREEN GRADIENT) ───────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B7F3B), Color(0xFF0F5A28)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          isEdit
                              ? Icons.edit_outlined
                              : Icons.local_offer_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEdit ? 'Edit Offer' : 'Create Offer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppTextSizes.h5,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isEdit
                                  ? 'Update your offer details'
                                  : 'Boost your sales with discount',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: AppTextSizes.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ─────────── CONTENT ───────────
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Info Card
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.10),
                                AppColors.primary.withOpacity(0.04),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(
                                        0.15,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.inventory_2_rounded,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name']?.toString() ?? 'Product',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: AppTextSizes.button,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.sell_outlined,
                                          size: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'MRP: ₹${regularPrice.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: AppTextSizes.caption,
                                            fontWeight: AppFontWeights.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Section Label
                        _sectionLabel(
                          icon: Icons.currency_rupee_rounded,
                          label: 'Offer Price',
                        ),
                        const SizedBox(height: 8),

                        TextField(
                          controller: controller.offerPriceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: AppTextSizes.button,
                            fontWeight: AppFontWeights.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter offer price',
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.6),
                              fontWeight: AppFontWeights.medium,
                            ),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              width: 36,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.currency_rupee_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 50,
                              minHeight: 50,
                            ),
                            filled: true,
                            fillColor: AppColors.primary.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: AppColors.primary.withOpacity(0.15),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.6,
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),

                        const SizedBox(height: 10),

                        // Discount Badge
                        Obx(() {
                          final discount = controller.selectedDiscountPercent;
                          if (discount == null || discount <= 0) {
                            return const SizedBox.shrink();
                          }
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.success.withOpacity(0.15),
                                  AppColors.success.withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.success.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.local_fire_department_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Customer saves ',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.caption,
                                  ),
                                ),
                                Text(
                                  '${discount.toStringAsFixed(0)}% OFF',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: AppTextSizes.button,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 22),

                        // Section Label
                        _sectionLabel(
                          icon: Icons.date_range_rounded,
                          label: 'Offer Duration',
                        ),
                        const SizedBox(height: 10),

                        // Date Tiles Row
                        Row(
                          children: [
                            Expanded(
                              child: _dateCard(
                                icon: Icons.play_circle_outline_rounded,
                                label: 'Start Date',
                                date: startDate,
                                placeholder: 'Select',
                                onTap: () async {
                                  final DateTime now = DateTime.now();
                                  final DateTime? selected = await _pickDate(
                                    context: context,
                                    initial: startDate ?? now,
                                    first: now,
                                    last: DateTime(now.year + 5),
                                  );
                                  if (selected != null) {
                                    setState(() => startDate = selected);
                                    controller.setStartDate(selected);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _dateCard(
                                icon: Icons.event_available_rounded,
                                label: 'End Date',
                                date: endDate,
                                placeholder: 'Select',
                                onTap: () async {
                                  final DateTime today = DateTime.now();
                                  final DateTime firstDate = startDate ?? today;
                                  final DateTime? selected = await _pickDate(
                                    context: context,
                                    initial: endDate ?? firstDate,
                                    first: firstDate,
                                    last: DateTime(today.year + 5),
                                  );
                                  if (selected != null) {
                                    setState(() => endDate = selected);
                                    controller.setEndDate(selected);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        // Duration display
                        if (startDate != null && endDate != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Offer runs for ',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppTextSizes.caption,
                                  ),
                                ),
                                Text(
                                  '${endDate!.difference(startDate!).inDays + 1} days',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: AppTextSizes.caption,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // ─────────── ACTIONS ───────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: AppColors.textSecondary.withOpacity(0.4),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontWeight: AppFontWeights.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: controller.isSaving.value
                                ? null
                                : () async {
                                    await controller.addOffer();
                                    if (!controller.isSaving.value) {
                                      Get.back();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shadowColor: AppColors.primary.withOpacity(0.4),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: controller.isSaving.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isEdit
                                            ? Icons.check_rounded
                                            : Icons.add_rounded,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isEdit
                                            ? 'Update Offer'
                                            : 'Create Offer',
                                        style: TextStyle(
                                          fontWeight: AppFontWeights.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─────────── HELPER: Section Label ───────────
  Widget _sectionLabel({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppTextSizes.button,
            fontWeight: AppFontWeights.bold,
          ),
        ),
      ],
    );
  }

  // ─────────── HELPER: Date Card ───────────
  Widget _dateCard({
    required IconData icon,
    required String label,
    required DateTime? date,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    final bool hasDate = date != null;
    return Material(
      color: hasDate
          ? AppColors.primary.withOpacity(0.08)
          : AppColors.primary.withOpacity(0.03),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasDate
                  ? AppColors.primary.withOpacity(0.3)
                  : AppColors.primary.withOpacity(0.12),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 14, color: AppColors.primary),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.caption,
                      fontWeight: AppFontWeights.medium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (hasDate) ...[
                Text(
                  _formatDateShort(date),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppTextSizes.h6,
                    fontWeight: AppFontWeights.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatYear(date),
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.caption,
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    placeholder,
                    style: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.6),
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.medium,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────── HELPER: Date Picker with Green Theme ───────────
  Future<DateTime?> _pickDate({
    required BuildContext context,
    required DateTime initial,
    required DateTime first,
    required DateTime last,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
              surface: AppColors.card,
            ),
            dialogBackgroundColor: AppColors.card,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: TextStyle(fontWeight: AppFontWeights.bold),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  // ─────────── HELPERS: Date Formatting ───────────
  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatDateShort(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  String _formatYear(DateTime date) {
    return date.year.toString();
  }
}
