import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/widget/validation_controller.dart';

class OfferProductController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController offerPriceController = TextEditingController();

  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedProduct = Rxn<Map<String, dynamic>>();

  final Rxn<DateTime> offerStartDate = Rxn<DateTime>();
  final Rxn<DateTime> offerEndDate = Rxn<DateTime>();

  final RxBool isLoading = true.obs;
  final RxBool isSaving = false.obs;

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

  void selectProduct(Map<String, dynamic> product) {
    selectedProduct.value = product;

    final dynamic existingOfferPrice = product['offerPrice'];

    final dynamic existingStartDate = product['offerStartDate'];

    final dynamic existingEndDate = product['offerEndDate'];

    offerPriceController.text = existingOfferPrice != null
        ? existingOfferPrice.toString()
        : '';

    offerStartDate.value = _convertToDate(existingStartDate);

    offerEndDate.value = _convertToDate(existingEndDate);
  }

  double calculateDiscount({
    required double regularPrice,
    required double offerPrice,
  }) {
    if (regularPrice <= 0 || offerPrice <= 0) {
      return 0;
    }

    if (offerPrice >= regularPrice) {
      return 0;
    }

    return ((regularPrice - offerPrice) / regularPrice) * 100;
  }

  double? get selectedDiscountPercent {
    final product = selectedProduct.value;

    if (product == null) {
      return null;
    }

    final double regularPrice = (product['price'] ?? 0).toDouble();

    final double? offerPrice = double.tryParse(
      offerPriceController.text.trim(),
    );

    if (offerPrice == null) {
      return null;
    }

    return calculateDiscount(
      regularPrice: regularPrice,
      offerPrice: offerPrice,
    );
  }

  void setStartDate(DateTime date) {
    offerStartDate.value = date;
  }

  void setEndDate(DateTime date) {
    offerEndDate.value = date;
  }

  Future<void> addOffer() async {
    final product = selectedProduct.value;

    if (product == null) {
      AppSnackbar.error('Please select a product.');
      return;
    }

    final double? offerPrice = double.tryParse(
      offerPriceController.text.trim(),
    );

    if (offerPrice == null || offerPrice <= 0) {
      AppSnackbar.error('Please enter a valid offer price.');
      return;
    }

    final double regularPrice = (product['price'] ?? 0).toDouble();

    if (regularPrice <= 0) {
      AppSnackbar.error('Product price is not valid.');
      return;
    }

    if (offerPrice >= regularPrice) {
      AppSnackbar.error('Offer price must be lower than regular price.');
      return;
    }

    if (offerStartDate.value == null) {
      AppSnackbar.error('Please select offer start date.');
      return;
    }

    if (offerEndDate.value == null) {
      AppSnackbar.error('Please select offer end date.');
      return;
    }

    if (offerEndDate.value!.isBefore(offerStartDate.value!)) {
      AppSnackbar.error('Offer end date must be after start date.');
      return;
    }

    try {
      isSaving.value = true;

      final double discountPercent = calculateDiscount(
        regularPrice: regularPrice,
        offerPrice: offerPrice,
      );

      await _firestore
          .collection('products')
          .doc(product['documentId'].toString())
          .update({
            'hasOffer': true,
            'offerPrice': offerPrice,
            'discountPercent': discountPercent,
            'offerStartDate': Timestamp.fromDate(offerStartDate.value!),
            'offerEndDate': Timestamp.fromDate(offerEndDate.value!),
          });

      AppSnackbar.success('Offer added successfully.');

      clearOfferForm();
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to add offer.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while adding offer.');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> removeOffer(String documentId) async {
    try {
      isSaving.value = true;

      await _firestore.collection('products').doc(documentId).update({
        'hasOffer': false,
        'offerPrice': null,
        'discountPercent': null,
        'offerStartDate': null,
        'offerEndDate': null,
      });

      AppSnackbar.success('Offer removed successfully.');

      if (selectedProduct.value?['documentId'] == documentId) {
        clearOfferForm();
      }
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to remove offer.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while removing offer.');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> confirmRemoveOffer(String documentId) async {
    final bool? result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Remove Offer'),
        content: const Text('Are you sure you want to remove this offer?'),
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
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (result == true) {
      await removeOffer(documentId);
    }
  }

  void clearOfferForm() {
    selectedProduct.value = null;
    offerPriceController.clear();
    offerStartDate.value = null;
    offerEndDate.value = null;
  }

  DateTime? _convertToDate(dynamic value) {
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

  @override
  void onClose() {
    _productsSubscription?.cancel();
    offerPriceController.dispose();

    super.onClose();
  }
}
