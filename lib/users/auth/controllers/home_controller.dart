import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/add_product/model/add_product_model.dart';

import 'package:localmarket/users/repos/product_repo.dart';

class HomeController extends GetxController {
  static const double radiusKm = 10;
  final userPos = Rxn<Position>();
  final locationError = RxnString();
  final ProductRepository _repo;

  HomeController(this._repo);

  final products = <ProductModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final selectedCategory = 'all'.obs;
  final searchQuery = ''.obs;

  final searchController = TextEditingController();
  StreamSubscription<List<ProductModel>>? _sub;

  final categoryKeys = const [
    'all',
    'grocery',
    'fruits_veg',
    'dairy',
    'bakery',
    'clothing',
    'footwear',
    'pharmacy',
    'electronics',
    'mobile',
    'hardware',
    'stationery',
    'cosmetics',
    'home_kitchen',
    'meat_fish',
    'toys_gifts',
    'flowers_plants',
    'other',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadLocation();
    _listenProducts();
  }

  Future<void> _loadLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        locationError.value = 'Location off cha';
        return;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        locationError.value = 'errors.location_permission_denied';
        return;
      }
      userPos.value = await Geolocator.getCurrentPosition();
      locationError.value = null;
    } catch (e) {
      locationError.value = e.toString();
    }
  }

  double? distanceKm(ProductModel p) {
    final pos = userPos.value;
    if (pos == null || p.shopLat == null || p.shopLng == null) return null;
    final meters = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      p.shopLat!,
      p.shopLng!,
    );
    return meters / 1000;
  }

  void _listenProducts() {
    isLoading.value = true;
    _sub = _repo.watchProducts().listen(
      (list) {
        debugPrint('PRODUCTS FETCHED: ${list.length}');
        products.value = list;
        errorMessage.value = null;
        isLoading.value = false;
      },
      onError: (e) {
        debugPrint('FETCH ERROR: $e');
        errorMessage.value = e.toString();
        isLoading.value = false;
      },
    );
  }

  List<ProductModel> get filteredProducts {
    final q = searchQuery.value.trim().toLowerCase();
    final cat = selectedCategory.value;
    final hasLocation = userPos.value != null;
    final result = products.where((p) {
      final okCat = cat == 'all' || p.category == cat;
      final okSearch =
          q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.shopName.toLowerCase().contains(q);
      final d = distanceKm(p);
      final okDistance = d != null && d <= radiusKm;

      return okCat && okSearch && hasLocation && okDistance;
    }).toList();

    result.sort((a, b) {
      final aDistance = distanceKm(a) ?? double.infinity;
      final bDistance = distanceKm(b) ?? double.infinity;
      return aDistance.compareTo(bDistance);
    });
    return result;
  }


  void onSearchChanged(String v) => searchQuery.value = v;
  void selectCategory(String key) => selectedCategory.value = key;

  Future<void> refreshProducts() async {
    await _sub?.cancel();
    _listenProducts();
  }

  @override
  void onClose() {
    _sub?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
