import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopRegistrationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController storeNameController = TextEditingController();

  final RxBool isLoading = false.obs;

  final RxList<String> selectedCategories = <String>[].obs;

  final List<Map<String, String>> shopCategories = [
    {'id': 'grocery', 'localeKey': 'categories.grocery'},
    {'id': 'fruits_veg', 'localeKey': 'categories.fruits_veg'},
    {'id': 'dairy', 'localeKey': 'categories.dairy'},
    {'id': 'bakery', 'localeKey': 'categories.bakery'},
    {'id': 'clothing', 'localeKey': 'categories.clothing'},
    {'id': 'footwear', 'localeKey': 'categories.footwear'},
    {'id': 'pharmacy', 'localeKey': 'categories.pharmacy'},
    {'id': 'electronics', 'localeKey': 'categories.electronics'},
    {'id': 'mobile', 'localeKey': 'categories.mobile'},
    {'id': 'hardware', 'localeKey': 'categories.hardware'},
    {'id': 'stationery', 'localeKey': 'categories.stationery'},
    {'id': 'cosmetics', 'localeKey': 'categories.cosmetics'},
    {'id': 'home_kitchen', 'localeKey': 'categories.home_kitchen'},
    {'id': 'meat_fish', 'localeKey': 'categories.meat_fish'},
    {'id': 'toys_gifts', 'localeKey': 'categories.toys_gifts'},
    {'id': 'flowers_plants', 'localeKey': 'categories.flowers_plants'},
    {'id': 'other', 'localeKey': 'categories.other'},
  ];

  void setCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
  }

  void removeCategory(String categoryId) {
    selectedCategories.remove(categoryId);
  }

  String? validate() {
    if (storeNameController.text.trim().isEmpty) {
      return 'Please enter store name';
    }

    if (selectedCategories.isEmpty) {
      return 'Please select at least one category';
    }

    return null;
  }

  Future<String?> registerShop({
    required String uid,
    required String? email,
    required String? displayName,
    required String? photoURL,
  }) async {
    final validationError = validate();

    if (validationError != null) {
      return validationError;
    }

    isLoading.value = true;

    try {
      await _firestore.collection('shopkeepers').doc(uid).set({
        'fullName': displayName ?? 'User',
        'email': email,
        'storeName': storeNameController.text.trim(),
        'categories': selectedCategories.toList(),
        'role': 'partner',
        'createdAt': FieldValue.serverTimestamp(),
        'profileImage': photoURL,
      });

      return null;
    } catch (error) {
      return error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    storeNameController.dispose();
    super.onClose();
  }
}
