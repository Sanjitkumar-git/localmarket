// import 'package:flutter/material.dart';
// import 'package:localmarket/shopkeeper/auth/controllers/forgot_password_controller.dart';
// import 'package:localmarket/shopkeeper/auth/controllers/sign_in_controller.dart';
// import 'package:provider/provider.dart';

// class SignInBinding {
//   static Widget bind({required Widget child}) {
//     return ChangeNotifierProvider<SigninController>(
//       create: (_) => SigninController(),
//       child: child,
//     );
//   }
// }

import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/sign_in_controller.dart';

class PartnerSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerSigninController>(() => PartnerSigninController());
  }
}
