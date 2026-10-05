import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/shop_registration_controller.dart';

class ShopRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopRegistrationController>(() => ShopRegistrationController());
  }
}
