import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/controller/dashboard_controller.dart';
import 'package:localmarket/shopkeeper/home/controller/shop_bottom_nav_controller.dart';

class ShopkeeperHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopkeeperBottomController>(() => ShopkeeperBottomController());

    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
