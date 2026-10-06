import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/offer_product/controller/offer_product_controller.dart';

class OfferProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferProductController>(() => OfferProductController());
  }
}
