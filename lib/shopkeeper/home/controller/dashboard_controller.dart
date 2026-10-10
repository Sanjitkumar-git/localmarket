import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:localmarket/services/location_service.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';

import 'package:localmarket/widget/validation_controller.dart';

class DashboardController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final shopName = 'My Store'.obs;

  final userLocation = 'Choose your location'.obs;
  final isLoadingLocation = true.obs;

  @override
  void onInit() {
    super.onInit();

    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    await Future.wait([loadShopName(), getUserLocation()]);
  }

  Future<void> loadShopName() async {
    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    try {
      final doc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();

        shopName.value = data?['storeName'] ?? 'My Store';
      }
    } catch (e) {
      Get.log('Shop name error: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();

      Get.offAllNamed(AppRoutes.signin);
    } catch (e) {
      AppSnackbar.error('Failed to logout.');
    }
  }

  Future<void> getUserLocation() async {
    try {
      isLoadingLocation.value = true;

      final address = await LocationService.getCurrentAddress();

      Get.log('Address result: $address');

      userLocation.value = address ?? 'Location not found';
    } catch (e) {
      Get.log('Location error: $e');

      userLocation.value = 'Unable to get location';
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }
}
