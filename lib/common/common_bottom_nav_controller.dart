import 'package:get/get.dart';

enum AppRole { user, shopkeeper }

class CommonBottomNavigationController extends GetxController {
  final AppRole role;

  CommonBottomNavigationController({required this.role});

  final RxInt selectedIndex = 0.obs;

  bool get isShopkeeper => role == AppRole.shopkeeper;

  bool get isUser => role == AppRole.user;

  int get tabCount => 3;

  void changeTab(int index) {
    if (index < 0 || index >= tabCount) return;

    selectedIndex.value = index;
  }

  void resetTab() {
    selectedIndex.value = 0;
  }
}
