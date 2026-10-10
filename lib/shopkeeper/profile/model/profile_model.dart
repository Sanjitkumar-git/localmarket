import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String userId;
  final String ownerName;
  final String shopName;
  final String email;
  final String phone;
  final String shopImage;
  final String address;
  final double? latitude;
  final double? longitude;
  final List<String> categories;

  ProfileModel({
    required this.userId,
    required this.ownerName,
    required this.shopName,
    required this.email,
    required this.phone,
    required this.shopImage,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'ownerName': ownerName,
      'storeName': shopName,
      'email': email,
      'phone': phone,
      'shopImage': shopImage,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'categories': categories,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProfileModel(
      userId: map['userId'] ?? documentId,
      ownerName: map['ownerName'] ?? '',
      shopName: map['storeName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      shopImage: map['shopImage'] ?? '',
      address: map['address'] ?? '',
      latitude: _toDouble(map['latitude']),
      longitude: _toDouble(map['longitude']),
      categories: map['categories'] is List
          ? List<String>.from(
              (map['categories'] as List).map((item) => item.toString()),
            )
          : [],
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
