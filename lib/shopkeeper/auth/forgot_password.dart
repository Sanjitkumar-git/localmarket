import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/forgot_password_controller.dart';
import 'package:localmarket/shopkeeper/auth/view/forgot_password_view.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (_) {
        return const ForgotPasswordView();
      },
    );
  }
}
