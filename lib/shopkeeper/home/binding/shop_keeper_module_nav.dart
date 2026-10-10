import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/controller/dashboard_controller.dart';
import 'package:localmarket/common/common_bottom_nav_controller.dart';
import 'package:localmarket/shopkeeper/profile/controller/profile_controller.dart';

class ShopkeeperHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommonBottomNavigationController>(
      () => CommonBottomNavigationController(role: AppRole.shopkeeper),
    );

    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
