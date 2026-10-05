import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/sign_up_controller.dart';

class UserSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSignUpController>(() => UserSignUpController());
  }
}