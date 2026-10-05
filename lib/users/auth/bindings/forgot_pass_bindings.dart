import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/forgot_pass_controller.dart';

class UserForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserForgotController>(() => UserForgotController());
  }
}