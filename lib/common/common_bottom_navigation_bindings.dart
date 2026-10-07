import 'package:get/get.dart';
import 'package:localmarket/common/common_bottom_nav_controller.dart';


class CommonBottomNavigationBinding extends Bindings {
  final AppRole role;

  CommonBottomNavigationBinding({required this.role});

  @override
  void dependencies() {
    Get.put(CommonBottomNavigationController(role: role));
  }
}
