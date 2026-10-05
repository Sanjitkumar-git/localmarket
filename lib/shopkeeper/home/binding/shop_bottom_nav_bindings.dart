import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/controller/shop_bottom_nav_controller.dart';


class ShopkeeperBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopkeeperBottomController>(() => ShopkeeperBottomController());
  }
}
