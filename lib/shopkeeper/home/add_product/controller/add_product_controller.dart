import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localmarket/common/storage_services.dart';

import 'package:localmarket/shopkeeper/home/add_product/model/add_product_model.dart';
import 'package:localmarket/widget/validation_controller.dart';

class AddProductController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  final RxBool isUploadingImage = false.obs;

  final RxString selectedStockUnit = ''.obs;

  final List<String> stockUnits = [
    'pcs',
    'kg',
    'g',
    'liter',
    'ml',
    'pack',
    'box',
    'bottle',
    'dozen',
  ];

  final RxString selectedCategory = ''.obs;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingCategories = true.obs;
  final Rxn<XFile> selectedImage = Rxn<XFile>();

  final ImagePicker _imagePicker = ImagePicker();

  final RxList<String> shopCategories = <String>[].obs;

  // Debug ke liye true rakho. Release se pehle false kar do.
  static const bool _showDebugErrors = true;

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
        AppSnackbar.error('User is not logged in.');
        return;
      }

      final DocumentSnapshot<Map<String, dynamic>> shopDoc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!shopDoc.exists) {
        AppSnackbar.error('Shop information not found.');
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
        AppSnackbar.error('No shop categories have been selected.');
      }
    } catch (e) {
      AppSnackbar.error('Failed to load your shop categories.');
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
      AppSnackbar.error('Unable to select image.');
    }
  }

  void removeProductImage() {
    selectedImage.value = null;
  }

  Future<void> addProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategory.value.isEmpty) {
      AppSnackbar.error('Please select a product category.');
      return;
    }

    if (selectedStockUnit.value.isEmpty) {
      AppSnackbar.error('Please select stock unit.');
      return;
    }

    final User? user = _auth.currentUser;

    if (user == null) {
      AppSnackbar.error('User is not logged in.');
      return;
    }

    try {
      isLoading.value = true;

      final shopDoc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!shopDoc.exists) {
        AppSnackbar.error('Shop information not found.');
        return;
      }

      final Map<String, dynamic> shopData = shopDoc.data() ?? {};

      final String shopName = shopData['storeName'] ?? 'My Store';

      String imageUrl = '';

      if (selectedImage.value != null) {
        isUploadingImage.value = true;

        final String? uploadedUrl = await CloudinaryService.uploadImage(
          image: selectedImage.value!,
          folder: 'nearshop/products',
        );

        isUploadingImage.value = false;

        if (uploadedUrl == null || uploadedUrl.isEmpty) {
          debugPrint('Upload failed: ${CloudinaryService.lastError}');

          AppSnackbar.error(
            _showDebugErrors && CloudinaryService.lastError.isNotEmpty
                ? 'Upload failed: ${CloudinaryService.lastError}'
                : 'Unable to upload product image.',
          );
          return;
        }

        imageUrl = uploadedUrl;
      }

      final String productId = _firestore.collection('products').doc().id;

      final ProductModel product = ProductModel(
        productId: productId,
        shopId: user.uid,
        shopName: shopName,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        category: selectedCategory.value,
        stockQuantity: double.parse(stockController.text.trim()),
        stockUnit: selectedStockUnit.value,
        imageUrl: imageUrl,
        hasOffer: false,
        offerPrice: null,
        discountPercent: null,
        offerStartDate: null,
        offerEndDate: null,
        isActive: true,
      );

      await _firestore
          .collection('products')
          .doc(productId)
          .set(product.toMap());

      AppSnackbar.success('Product added successfully.');

      clearFields();
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Failed to add product.');
    } catch (e) {
      debugPrint('addProduct error: $e');
      AppSnackbar.error('Something went wrong.');
    } finally {
      isUploadingImage.value = false;
      isLoading.value = false;
    }
  }

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    stockController.clear();

    selectedStockUnit.value = '';
    selectedCategory.value = '';
    selectedImage.value = null;
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();

    super.onClose();
  }
}
