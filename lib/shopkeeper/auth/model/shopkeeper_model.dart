class ShopkeeperModel {
  final String uid;
  final String fullName;
  final String email;
  final String storeName;
  final List<String> categories;
  final String role;

  ShopkeeperModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.storeName,
    required this.categories,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'storeName': storeName,
      'categories': categories,
      'role': role,
    };
  }
}
