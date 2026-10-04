import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:localmarket/shopkeeper/home/add_product/model/add_product_model.dart';

class AddProductController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // Selected category for current product
  final RxString selectedCategory = ''.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingCategories = true.obs;
  final Rxn<XFile> selectedImage = Rxn<XFile>();

  final ImagePicker _imagePicker = ImagePicker();

  // Categories selected by this shopkeeper during registration
  final RxList<String> shopCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadShopCategories();
  }

  Future<void> loadShopCategories() async {
    try {
      isLoadingCategories.value = true;

      final User? user = _auth.currentUser;

      if (user == null) {
        Get.snackbar(
          'Error',
          'User is not logged in.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final DocumentSnapshot<Map<String, dynamic>> shopDoc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!shopDoc.exists) {
        Get.snackbar(
          'Error',
          'Shop information not found.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final data = shopDoc.data();

      if (data == null) {
        return;
      }

      final dynamic categoriesData = data['categories'];

      if (categoriesData is List) {
        shopCategories.assignAll(
          categoriesData
              .where((category) => category != null)
              .map((category) => category.toString())
              .toList(),
        );
      }

      if (shopCategories.isEmpty) {
        Get.snackbar(
          'Category Not Found',
          'No shop categories have been selected.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load your shop categories.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> pickProductImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to select image.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeProductImage() {
    selectedImage.value = null;
  }
  // ============================================================
  // ADD PRODUCT
  // ============================================================

  Future<void> addProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategory.value.isEmpty) {
      Get.snackbar(
        'Category Required',
        'Please select a product category.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final User? user = _auth.currentUser;

    if (user == null) {
      Get.snackbar(
        'Error',
        'User is not logged in.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // ========================================================
      // GET SHOPKEEPER INFORMATION
      // ========================================================

      final shopDoc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!shopDoc.exists) {
        Get.snackbar(
          'Error',
          'Shop information not found.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final shopData = shopDoc.data()!;

      final String shopName = shopData['storeName'] ?? 'My Store';

      // ========================================================
      // CREATE PRODUCT ID
      // ========================================================

      final String productId = _firestore.collection('products').doc().id;

      // ========================================================
      // CREATE PRODUCT
      // ========================================================

      final ProductModel product = ProductModel(
        productId: productId,
        shopId: user.uid,
        shopName: shopName,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        category: selectedCategory.value,
        stock: int.parse(stockController.text.trim()),
        isActive: true,
      );

      // ========================================================
      // SAVE PRODUCT
      // ========================================================

      await _firestore
          .collection('products')
          .doc(productId)
          .set(product.toMap());

      Get.snackbar(
        'Success',
        'Product added successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );

      clearFields();

      Get.back();
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Failed to add product.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // CLEAR FIELDS
  // ============================================================

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    stockController.clear();

    selectedCategory.value = '';
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();

    super.onClose();
  }
}
