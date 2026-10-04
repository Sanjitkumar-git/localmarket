import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/add_product/controller/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController());
  }
}
