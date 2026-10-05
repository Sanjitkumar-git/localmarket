import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/auth/controllers/sign_in_controller.dart';
import 'package:localmarket/shopkeeper/auth/view/sign_in_view.dart';



class PartnerSignInPage extends StatelessWidget {
  const PartnerSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerSigninController>(
      init: PartnerSigninController(),
      builder: (_) {
        return SignInView();
      },
    );
  }
}
