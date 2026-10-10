import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String shopId;
  final String shopName;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double? shopLat;
  final double? shopLng;
  final double stockQuantity;
  final String stockUnit;

  final bool hasOffer;
  final double? offerPrice;
  final double? discountPercent;
  final DateTime? offerStartDate;
  final DateTime? offerEndDate;

  final bool isActive;

  ProductModel({
    required this.productId,
    required this.shopId,
    required this.shopName,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl = '',
    this.shopLat,
    this.shopLng,
    required this.stockQuantity,
    required this.stockUnit,

    required this.hasOffer,
    required this.offerPrice,
    required this.discountPercent,
    required this.offerStartDate,
    required this.offerEndDate,

    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'shopId': shopId,
      'shopName': shopName,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'shopLat': shopLat,
      'shopLng': shopLng,
      // Stock
      'stockQuantity': stockQuantity,
      'stockUnit': stockUnit,

      // Offer
      'hasOffer': hasOffer,
      'offerPrice': offerPrice,
      'discountPercent': discountPercent,
      'offerStartDate': offerStartDate != null
          ? Timestamp.fromDate(offerStartDate!)
          : null,
      'offerEndDate': offerEndDate != null
          ? Timestamp.fromDate(offerEndDate!)
          : null,

      // Status
      'isActive': isActive,

      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      shopId: map['shopId'] ?? '',
      shopName: map['shopName'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: (map['imageUrl'] ?? '').toString(),
      shopLat: (map['shopLat'] as num?)?.toDouble(),
      shopLng: (map['shopLng'] as num?)?.toDouble(),
      price: (map['price'] ?? 0).toDouble(),

      category: map['category'] ?? '',

      // Stock
      stockQuantity: (map['stockQuantity'] ?? 0).toDouble(),

      stockUnit: map['stockUnit'] ?? 'pcs',

      // Offer
      hasOffer: map['hasOffer'] ?? false,

      offerPrice: map['offerPrice'] != null
          ? (map['offerPrice']).toDouble()
          : null,

      discountPercent: map['discountPercent'] != null
          ? (map['discountPercent']).toDouble()
          : null,

      offerStartDate: _timestampToDate(map['offerStartDate']),

      offerEndDate: _timestampToDate(map['offerEndDate']),

      // Status
      isActive: map['isActive'] ?? true,
    );
  }

  static DateTime? _timestampToDate(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return null;
  }
}
