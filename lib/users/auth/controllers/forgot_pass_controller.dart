import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:localmarket/users/routes/app_routes.dart';
import 'package:localmarket/users/utils/form_inputs.dart';

class UserForgotController extends GetxController {
  ForgotForm form = ForgotForm();

  final emailController = TextEditingController();
  final emailNode = FocusNode();

  void onEmailChanged(String v) {
    form.email = EmailInput.dirty(value: v);
    update();
  }

  void submitForgot() {
    onEmailChanged(emailController.text.trim());

    if (form.isValid) {
      Get.snackbar('', tr('auth.reset_link_sent'));
      Get.offNamed(Routes.SIGNINSCREEN);
    }
  }

  void goToLogin() => Get.offNamed(Routes.SIGNINSCREEN);

  @override
  void onClose() {
    emailController.dispose();
    emailNode.dispose();
    super.onClose();
  }
}

class ForgotForm with FormzMixin {
  ForgotForm({this.email = const EmailInput.pure()});

  EmailInput email;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email];
}