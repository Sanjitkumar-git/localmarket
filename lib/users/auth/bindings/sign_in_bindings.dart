import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/sign_in_controller.dart';


class UserSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSigninController>(() => UserSigninController());
  }
}
