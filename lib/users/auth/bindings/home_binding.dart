import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/home_controller.dart';
import 'package:localmarket/users/repos/product_repo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<ProductRepository>()),
    );
  }
}