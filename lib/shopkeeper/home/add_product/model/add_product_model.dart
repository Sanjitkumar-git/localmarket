import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String shopId;
  final String shopName;
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;
  final bool isActive;

  ProductModel({
    required this.productId,
    required this.shopId,
    required this.shopName,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
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
      'stock': stock,
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
      price: (map['price'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
      isActive: map['isActive'] ?? true,
    );
  }
}
