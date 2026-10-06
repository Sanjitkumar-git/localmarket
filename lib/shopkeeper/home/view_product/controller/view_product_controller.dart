import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/widget/validation_controller.dart';

class ViewProductController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = true.obs;
  final RxString searchText = ''.obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _productsSubscription;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    final User? user = _auth.currentUser;

    if (user == null) {
      isLoading.value = false;
      AppSnackbar.error('User is not logged in.');
      return;
    }

    isLoading.value = true;

    _productsSubscription?.cancel();

    _productsSubscription = _firestore
        .collection('products')
        .where('shopId', isEqualTo: user.uid)
        .snapshots()
        .listen(
          (snapshot) {
            final List<Map<String, dynamic>> productList = snapshot.docs.map((
              doc,
            ) {
              final data = doc.data();

              return {...data, 'documentId': doc.id};
            }).toList();

            productList.sort((a, b) {
              final Timestamp? timeA = a['createdAt'] as Timestamp?;
              final Timestamp? timeB = b['createdAt'] as Timestamp?;

              if (timeA == null && timeB == null) {
                return 0;
              }

              if (timeA == null) {
                return 1;
              }

              if (timeB == null) {
                return -1;
              }

              return timeB.compareTo(timeA);
            });

            products.assignAll(productList);
            isLoading.value = false;
          },
          onError: (error) {
            isLoading.value = false;
            AppSnackbar.error('Unable to load products.');
          },
        );
  }

  List<Map<String, dynamic>> get filteredProducts {
    final String query = searchText.value.trim().toLowerCase();

    if (query.isEmpty) {
      return products.toList();
    }

    return products.where((product) {
      final String name = (product['name'] ?? '').toString().toLowerCase();

      final String category = (product['category'] ?? '')
          .toString()
          .toLowerCase();

      return name.contains(query) || category.contains(query);
    }).toList();
  }

  void updateSearch(String value) {
    searchText.value = value;
  }

  Future<void> refreshProducts() async {
    loadProducts();
  }

  Future<void> updateProduct({
    required String documentId,
    required String name,
    required String description,
    required double price,
    required double stockQuantity,
    required String stockUnit,
    required String category,
  }) async {
    try {
      await _firestore.collection('products').doc(documentId).update({
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'stockUnit': stockUnit,
        'category': category,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      AppSnackbar.success('Product updated successfully.');
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to update product.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while updating product.');
    }
  }

  Future<void> confirmDeleteProduct(String documentId) async {
    final bool? result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == true) {
      await deleteProduct(documentId);
    }
  }

  Future<void> deleteProduct(String documentId) async {
    try {
      await _firestore.collection('products').doc(documentId).delete();

      AppSnackbar.success('Product deleted successfully.');
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to delete product.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while deleting product.');
    }
  }

  @override
  void onClose() {
    _productsSubscription?.cancel();
    super.onClose();
  }
}
