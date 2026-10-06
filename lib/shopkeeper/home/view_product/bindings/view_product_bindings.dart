import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/view_product/controller/view_product_controller.dart';

class ViewProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewProductController>(() => ViewProductController());
  }
}
