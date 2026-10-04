import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/sign_up_controller.dart';

class PartnerSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerSignUpController>(() => PartnerSignUpController());
  }
}
