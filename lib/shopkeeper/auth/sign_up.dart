import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/view/sign_up_view.dart';

import 'controllers/sign_up_controller.dart';

class PartnerSignupPage extends StatelessWidget {
  const PartnerSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerSignUpController>(
      init: PartnerSignUpController(),
      builder: (_) {
        return SignUpView();
      },
    );
  }
}
