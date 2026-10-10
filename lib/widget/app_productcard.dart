import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/home/add_product/model/add_product_model.dart';
import 'package:localmarket/widget/app_colors.dart';

class AppProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isFavorite;
  final String? distanceText; 
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewTap;
  final VoidCallback? onLocationTap;
  final String imageUrl;

  const AppProductCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.distanceText,
    this.onFavoriteTap,
    this.onViewTap,
    this.onLocationTap,
    this.imageUrl ='',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: product.imageUrl.isEmpty
                        ? Container(
                            color: Colors.black12,
                            child: const Center(
                                child: Icon(Icons.image_outlined, size: 40)),
                          )
                        : Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (c, child, p) => p == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2)),
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.black12,
                              child: const Center(
                                  child: Icon(Icons.broken_image_outlined)),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: isFavorite ? Colors.red : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 2),

          // Price
          Text(
            'Rs. ${product.price.toStringAsFixed(0)}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),

          // Shop chip
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.storefront_outlined,
                    size: 14, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    product.shopName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Location row
          GestureDetector(
            onTap: onLocationTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.near_me_outlined,
                      size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tr('customer.open_location'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.black87),
                    ),
                  ),
                  if (distanceText != null)
                    Text(distanceText!,
                        style: const TextStyle(
                            fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: onViewTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                tr('customer.view_product'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}